---@diagnostic disable: undefined-global
local util = require("util")
local i18n = require("i18n")
local icons = require("icons")

local M = {}

local function has(list, want)
  for _, v in ipairs(list or {}) do
    if v == want then return true end
  end
  return false
end

local function scopes_of(cfg)
  if cfg.scope == "both" then return { "page", "work" } end
  return { cfg.scope }
end

-- Confirma que (scope, style) tem citação de fato renderizada. csl.lua omite
-- da tabela de variantes estilos que falharam em todos os escopos (ver
-- csl.lua:172-177) — então o par "ativo" resolvido a partir da config pode
-- não existir. Sem essa checagem, variants_html marcaria hidden em tudo e o
-- leitor sem JavaScript não veria citação nenhuma.
local function has_variant(state, scope, style)
  return state.variants[style] ~= nil and state.variants[style][scope] ~= nil
end

-- Encontra o par (scope, style) a exibir: usa o par pedido se ele tiver
-- dado; senão cai no primeiro par, na mesma ordem de varredura de
-- variants_html (escopo fora, estilo dentro), que tiver. Devolve nil, nil
-- se nenhum par tiver dado — nesse caso M.build não emite widget algum.
local function find_active_variant(state, wanted_scope, wanted_style)
  if has_variant(state, wanted_scope, wanted_style) then
    return wanted_scope, wanted_style
  end
  for _, scope in ipairs(scopes_of(state.cfg)) do
    for _, st in ipairs(state.styles) do
      if has_variant(state, scope, st.name) then
        return scope, st.name
      end
    end
  end
  return nil, nil
end

-- Uma variante por combinação. Só a combinação inicial fica visível, de modo
-- que a citação continue legível sem JavaScript.
local function variants_html(state, active_scope, active_style)
  local out = {}
  for _, scope in ipairs(scopes_of(state.cfg)) do
    for _, st in ipairs(state.styles) do
      local v = state.variants[st.name] and state.variants[st.name][scope]
      if v then
        local hidden = (scope == active_scope and st.name == active_style) and "" or " hidden"
        out[#out + 1] = ([[<div class="cite-this-variant" data-kind="text" data-scope="%s" data-style="%s"%s><div class="cite-this-rendered">%s</div><div class="cite-this-text" hidden>%s</div></div>]])
          :format(scope, st.name, hidden, v.html, util.esc_html(v.text))
      end
    end
    local bib = state.bibtex[scope]
    if bib then
      out[#out + 1] = ([[<div class="cite-this-variant" data-kind="bibtex" data-scope="%s" data-filename="%s" hidden><pre class="cite-this-text">%s</pre></div>]])
        :format(scope, util.esc_html(bib.filename), util.esc_html(bib.text))
    end
  end
  return table.concat(out)
end

local function button(action, label, icon)
  return ([[<button type="button" class="cite-this-btn" data-cite-this-action="%s" title="%s" aria-label="%s">%s<span class="cite-this-done">%s</span></button>]])
    :format(action, util.esc_html(label), util.esc_html(label), icon, icons.check)
end

local function radios(group, items, active, legend)
  local parts = { ([[<fieldset class="cite-this-group" data-group="%s"><legend>%s</legend>]])
    :format(group, util.esc_html(legend)) }
  for _, item in ipairs(items) do
    parts[#parts + 1] = ([[<label class="cite-this-option"><input type="radio" name="cite-this-%s" value="%s"%s> <span>%s</span></label>]])
      :format(group, util.esc_html(item.value), item.value == active and " checked" or "",
              util.esc_html(item.label))
  end
  parts[#parts + 1] = "</fieldset>"
  return table.concat(parts)
end

local function menu(state, terms, active_scope, active_style)
  local cfg = state.cfg
  local multi_style = #state.styles > 1
  local multi_scope = cfg.scope == "both"
  if not multi_style and not multi_scope then return "" end

  local body = {}
  if multi_scope then
    body[#body + 1] = radios("scope", {
      { value = "page", label = terms.page }, { value = "work", label = terms.work },
    }, active_scope, terms.scope)
  end
  if multi_style then
    local items = {}
    for _, st in ipairs(state.styles) do
      items[#items + 1] = { value = st.name, label = st.label }
    end
    body[#body + 1] = radios("style", items, active_style, terms.style)
  end

  return ([[<details class="cite-this-menu"><summary class="cite-this-btn" title="%s" aria-label="%s">%s</summary><div class="cite-this-panel">%s<div class="cite-this-preview" aria-live="polite"></div></div></details>]])
    :format(util.esc_html(terms.options), util.esc_html(terms.options), icons.options,
            table.concat(body))
end

-- data-copied-label carrega terms.copied já traduzido: é o texto que
-- cite-this.js anuncia (região aria-live) depois de uma cópia bem-sucedida.
-- Fica na raiz porque é o mesmo em todo o widget, independente de escopo/
-- estilo ativo — texto de interface não deve ser duplicado em JavaScript.
local function root_attrs(state, opts, active_scope, active_style)
  local cfg = state.cfg
  local terms = i18n.terms(state.lang)
  return ([[data-position="%s" data-corner="%s" data-scope="%s" data-default-scope="%s" data-default-style="%s" data-remember="%s" data-copied-label="%s" data-copy-text-label="%s" data-copy-bibtex-label="%s"]])
    :format(opts.mode == "inline" and "inline" or cfg.position, cfg.corner, cfg.scope,
            active_scope, active_style, tostring(cfg["remember-choice"] == true),
            util.esc_html(terms.copied), util.esc_html(terms.copy_text),
            util.esc_html(terms.copy_bibtex))
end

function M.build(state, opts)
  opts = opts or {}
  local cfg = state.cfg
  local terms = i18n.terms(state.lang)
  local label = cfg.label or terms.label

  local active_scope = opts.scope or cfg["default-scope"]
  if not has(scopes_of(cfg), active_scope) then active_scope = scopes_of(cfg)[1] end
  local active_style = opts.style or state.default_style
  local known = false
  for _, st in ipairs(state.styles) do
    if st.name == active_style then known = true end
  end
  if not known then active_style = state.default_style end

  -- O par (scope, style) resolvido acima pode não ter citação renderizada
  -- (estilo que falhou nos dois escopos, por exemplo). Cai no primeiro par
  -- que realmente tiver; se nenhum tiver, não há o que mostrar — emitir um
  -- widget com botões e abas mas nenhuma citação seria pior que não emitir
  -- nada, então o widget inteiro é omitido.
  local found_scope, found_style = find_active_variant(state, active_scope, active_style)
  if not found_scope then
    util.warn("cite-this: nenhuma variante de citação com dado renderizado — widget omitido")
    return ""
  end
  active_scope, active_style = found_scope, found_style

  local text_button = has(cfg.actions, "text")
    and button("text", terms.copy_text, icons.quote) or ""
  local bibtex_button = has(cfg.actions, "bibtex")
    and button("bibtex", terms.copy_bibtex, icons.bibtex) or ""
  local download_button = has(cfg.actions, "download")
    and button("download", terms.download, icons.download) or ""
  local menu_html = menu(state, terms, active_scope, active_style)

  local label_html = ""
  if cfg["show-label"] then
    label_html = ('<span class="cite-this-label">%s</span>'):format(util.esc_html(label))
  end

  -- A primeira ação direta habilitada é o gatilho que permanece visível no
  -- estado recolhido. Assim, desabilitar "text" não transforma por acidente
  -- o menu de opções na ação principal: BibTeX ou download assumem o lugar.
  local lead = text_button ~= "" and text_button
    or bibtex_button ~= "" and bibtex_button
    or download_button ~= "" and download_button
    or menu_html

  local secondary = {}
  if menu_html ~= "" and menu_html ~= lead then secondary[#secondary + 1] = menu_html end
  if text_button ~= "" and text_button ~= lead then secondary[#secondary + 1] = text_button end
  if bibtex_button ~= "" and bibtex_button ~= lead then secondary[#secondary + 1] = bibtex_button end
  if download_button ~= "" and download_button ~= lead then secondary[#secondary + 1] = download_button end

  local actions = ('<div class="cite-this-actions">%s<div class="cite-this-collapsible">%s%s</div></div>')
    :format(lead, label_html, table.concat(secondary))

  local data = ('<div class="cite-this-data" hidden>%s</div>')
    :format(variants_html(state, active_scope, active_style))

  if opts.mode ~= "inline" then
    return ('<div class="cite-this cite-this--mount" %s hidden>%s%s</div>')
      :format(root_attrs(state, opts, active_scope, active_style), actions, data)
  end

  -- Modo inline: abas de escopo e de formato, com a citação visível.
  local tabs = {}
  if cfg.scope == "both" then
    for _, s in ipairs({ { "page", terms.page }, { "work", terms.work } }) do
      local selected = s[1] == active_scope
      tabs[#tabs + 1] = ([[<button type="button" role="tab" class="cite-this-tab" data-tab-scope="%s" aria-selected="%s" tabindex="%s">%s</button>]])
        :format(s[1], tostring(selected), selected and "0" or "-1", util.esc_html(s[2]))
    end
  end
  local scope_tabs = #tabs > 0
    and ('<div class="cite-this-tabs cite-this-tabs--scope" role="tablist">%s</div>'):format(table.concat(tabs))
    or ""

  local kind_tabs = {}
  for _, k in ipairs({ { "text", terms.text_tab, icons.text }, { "bibtex", terms.bibtex_tab, icons.bibtex } }) do
    local selected = k[1] == "text"
    kind_tabs[#kind_tabs + 1] = ([[<button type="button" role="tab" class="cite-this-tab" data-tab-kind="%s" aria-selected="%s" tabindex="%s">%s<span>%s</span></button>]])
      :format(k[1], tostring(selected), selected and "0" or "-1", k[3], util.esc_html(k[2]))
  end

  local style_select = ""
  if #state.styles > 1 then
    local options = {}
    for _, st in ipairs(state.styles) do
      options[#options + 1] = ('<option value="%s"%s>%s</option>')
        :format(util.esc_html(st.name), st.name == active_style and " selected" or "",
                util.esc_html(st.label))
    end
    style_select = ([[<label class="cite-this-select" data-cite-this-style-wrap>%s <select data-cite-this-style>%s</select></label>]])
      :format(util.esc_html(terms.style), table.concat(options))
  end

  local footer_buttons = {}
  if has(cfg.actions, "text") or has(cfg.actions, "bibtex") then
    footer_buttons[#footer_buttons + 1] = button("active", terms.copy_text, icons.copy)
  end
  if has(cfg.actions, "download") then
    footer_buttons[#footer_buttons + 1] = button("download", terms.download, icons.download)
  end

  -- No modo recolhível o próprio <summary> já é o cabeçalho. Repetir marca e
  -- rótulo dentro do conteúdo produzia dois "Como citar" consecutivos. Os
  -- seletores de escopo passam para a barra principal, ao lado do formato.
  local head = ""
  local bar_class = "cite-this-bar"
  local bar_scope = scope_tabs
  if not opts.collapsed then
    head = ([[<div class="cite-this-head"><span class="cite-this-label">%s%s</span>%s</div>]])
      :format(icons.quote, util.esc_html(label), scope_tabs)
    bar_scope = ""
  else
    bar_class = bar_class .. " cite-this-bar--collapsed"
  end

  local body = ([[%s<div class="%s">%s<div class="cite-this-tabs cite-this-tabs--kind" role="tablist">%s</div>%s</div><div class="cite-this-body">%s</div><div class="cite-this-foot">%s</div>]])
    :format(head, bar_class, bar_scope, table.concat(kind_tabs), style_select,
            variants_html(state, active_scope, active_style),
            table.concat(footer_buttons))

  if opts.collapsed then
    return ('<div class="cite-this cite-this--inline" %s><details class="cite-this-collapse"><summary>%s%s</summary>%s</details></div>')
      :format(root_attrs(state, opts, active_scope, active_style), icons.quote,
              util.esc_html(label), body)
  end

  return ('<div class="cite-this cite-this--inline" %s>%s</div>')
    :format(root_attrs(state, opts, active_scope, active_style), body)
end

-- v.text é a versão literal, sem marcação, feita para cópia — não pode
-- passar por um parser de Markdown: um pandoc.read reinterpretaria "- item"
-- como lista, "_x_" como ênfase, um "[algo](url)" acidental como link, e
-- estouraria com texto vazio (blocks[1] == nil) ou com sintaxe de lista
-- (Inline expected, got Blocks). Em vez disso, tokeniza a string à mão:
-- cada linha vira palavras separadas por Space, e quebras de linha reais
-- viram LineBreak, preservando tudo sem reinterpretar nada.
local function plain_inlines(text)
  local inlines = pandoc.Inlines({})
  local first_line = true
  for line in ((text or "") .. "\n"):gmatch("([^\n]*)\n") do
    if not first_line then
      inlines:insert(pandoc.LineBreak())
    end
    local first_word = true
    for word in line:gmatch("%S+") do
      if not first_word then
        inlines:insert(pandoc.Space())
      end
      inlines:insert(pandoc.Str(word))
      first_word = false
    end
    first_line = false
  end
  return inlines
end

function M.static_blocks(state, opts)
  opts = opts or {}
  local terms = i18n.terms(state.lang)
  local scope = opts.scope or state.cfg["default-scope"]
  local style = opts.style or state.default_style
  local blocks = pandoc.Blocks({})

  blocks:insert(pandoc.Para({ pandoc.Strong({ pandoc.Str(state.cfg.label or terms.label) }) }))

  local v = state.variants[style] and state.variants[style][scope]
  if v then
    local inlines = plain_inlines(v.text)
    if #inlines > 0 then
      blocks:insert(pandoc.Para(inlines))
    end
  end

  local bib = state.bibtex[scope]
  if bib then
    blocks:insert(pandoc.CodeBlock(bib.text, pandoc.Attr("", { "bibtex" })))
  end

  return blocks
end

return M

---@diagnostic disable: undefined-global
local util = require("util")
local i18n = require("i18n")

local M = {}

local LABELS = {
  abnt = "ABNT", apa = "APA", ieee = "IEEE", mla = "MLA",
  harvard = "Harvard", chicago = "Chicago", vancouver = "Vancouver",
}

function M.style_dir(script_file)
  local dir = (script_file or PANDOC_SCRIPT_FILE or ""):match("(.*[/\\])") or ""
  return dir .. "styles/"
end

local function exists(path)
  local f = io.open(path, "r")
  if f then f:close() return true end
  return false
end

function M.resolve_styles(cfg, meta, script_file)
  local list, seen_paths, used_names = {}, {}, {}
  local style_dir = M.style_dir(script_file)
  local document_style

  local function unique_name(name)
    local candidate, suffix = name, 2
    while used_names[candidate] do
      candidate = name .. "-" .. suffix
      suffix = suffix + 1
    end
    used_names[candidate] = true
    return candidate
  end

  local function add(name, path, label, is_document)
    if not path or path == "" or seen_paths[path] then return end
    if not exists(path) then
      util.warn(("estilo CSL não encontrado: %s (%s)"):format(name, path))
      return
    end
    seen_paths[path] = true
    local style = {
      name = name,
      path = path,
      label = label or LABELS[name] or name,
      is_document = is_document or nil,
    }
    if is_document then
      document_style = style
    else
      style.name = unique_name(name)
      list[#list + 1] = style
    end
  end

  if cfg["use-document-csl"] and meta and meta.csl then
    local path = util.to_plain(meta.csl)
    if type(path) == "string" then
      local lang = meta.lang and util.to_plain(meta.lang) or "en"
      add(path:match("([^/\\]+)%.csl$") or "document", path, i18n.terms(lang).document_style, true)
    end
  end

  for _, s in ipairs(cfg.styles or {}) do
    if type(s) == "string" and s ~= "" then
      if s:find("/", 1, true) or s:sub(-4) == ".csl" then
        add(s:match("([^/\\]+)%.csl$") or s, s)
      else
        add(s, style_dir .. s .. ".csl")
      end
    end
  end

  if document_style then
    -- Keep configured style names available to default-style and shortcodes.
    document_style.name = unique_name(document_style.name)
    table.insert(list, 1, document_style)
  elseif #list == 0 then
    add("apa", style_dir .. "apa.csl")
  end

  return list
end

function M.pick_default(list, want, explicit)
  if #list == 0 then return nil end

  -- Sem escolha explícita do autor, o csl: do documento define o padrão: a
  -- citação copiada fica coerente com as referências do próprio documento.
  if not explicit and list[1].is_document then return list[1].name end

  for _, s in ipairs(list) do
    if s.name == want then return want end
  end

  -- Só avisa sobre um valor que o autor realmente escreveu.
  if want and explicit then
    util.warn(("extensions.cite-this.default-style %q não está na lista de estilos — usando %q")
      :format(tostring(want), list[1].name))
  end
  return list[1].name
end

-- Converte o registro Lua puro em references CSL. Datas viram date-parts.
local function to_reference(rec)
  local out = {}
  for k, v in pairs(rec) do
    if k == "issued" or k == "accessed" then
      local parts = { tostring(v.year) }
      if v.month then parts[#parts + 1] = tostring(v.month) end
      if v.day then parts[#parts + 1] = tostring(v.day) end
      out[k] = { ["date-parts"] = { parts } }
    else
      out[k] = v
    end
  end
  return util.to_meta(out)
end

local NOWRAP = nil
local function writer_opts()
  if NOWRAP == nil then NOWRAP = pandoc.WriterOptions({ wrap_text = "none" }) end
  return NOWRAP
end

-- Corpo de render_one que pode estourar em qualquer ponto: montagem do
-- documento, a chamada ao citeproc, o walk_block ou as duas escritas. Fica
-- separado só para o pcall em M.render_one cobrir o caminho inteiro — a
-- garantia do projeto é que o render nunca falha por causa da extensão, e
-- render_one é contrato público que tarefas futuras chamam com dados que
-- podem não vir do citation.lua (logo, sem a validação que ele já faz).
local function do_render_one(rec, style_path, lang)
  local doc = pandoc.Pandoc(
    { pandoc.Para({ pandoc.Cite(
        { pandoc.Str("@" .. rec.id) },
        { pandoc.Citation(rec.id, "NormalCitation") }) }) },
    pandoc.Meta({
      references = pandoc.MetaList({ to_reference(rec) }),
      csl = pandoc.MetaString(style_path),
      lang = pandoc.MetaString(lang or "en"),
      ["link-citations"] = pandoc.MetaBool(false),
    }))

  local res = pandoc.utils.citeproc(doc)

  local entry
  pandoc.walk_block(pandoc.Div(res.blocks), {
    Div = function(el)
      if el.identifier == "ref-" .. rec.id then entry = el end
    end,
  })
  if not entry then return nil, "entrada não encontrada na bibliografia" end

  -- Para vira Plain para que o HTML não venha embrulhado em <p>.
  local blocks = {}
  for _, b in ipairs(entry.content) do
    blocks[#blocks + 1] = (b.t == "Para") and pandoc.Plain(b.content) or b
  end

  local inner = pandoc.Pandoc(blocks)
  return {
    html = util.trim(pandoc.write(inner, "html", writer_opts())),
    text = util.trim(pandoc.write(inner, "plain", writer_opts())),
  }
end

function M.render_one(rec, style_path, lang)
  if not rec then return nil, "registro vazio" end

  local ok, res, err = pcall(do_render_one, rec, style_path, lang)
  if not ok then return nil, tostring(res) end
  return res, err
end

function M.render(records, styles, lang)
  local out = {}
  for _, st in ipairs(styles) do
    local variant = {}
    for _, scope in ipairs({ "page", "work" }) do
      local rec = records[scope]
      if rec then
        local res, err = M.render_one(rec, st.path, lang)
        if res then
          variant[scope] = res
        else
          util.warn(("falha ao formatar o escopo %s no estilo %s: %s")
            :format(scope, st.name, tostring(err)))
        end
      end
    end
    -- Estilo sem nenhum escopo renderizado não entra na tabela: os
    -- consumidores não precisam checar .page/.work um a um para descobrir
    -- se o estilo falhou por completo.
    if next(variant) ~= nil then
      out[st.name] = variant
    end
  end
  return out
end

return M

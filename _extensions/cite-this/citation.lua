---@diagnostic disable: undefined-global
local util = require("util")

local M = {}

-- Partículas que pertencem ao sobrenome em nomes latinos e germânicos.
local PARTICLES = {
  ["da"] = true, ["das"] = true, ["de"] = true, ["del"] = true, ["della"] = true,
  ["di"] = true, ["do"] = true, ["dos"] = true, ["du"] = true, ["la"] = true,
  ["le"] = true, ["van"] = true, ["von"] = true, ["der"] = true, ["den"] = true,
  ["ter"] = true, ["y"] = true, ["e"] = true,
}

function M.parse_name(s)
  s = util.trim(s or "")
  if s == "" then return nil end

  local family, given = s:match("^([^,]+),%s*(.+)$")
  if family then
    return { family = util.trim(family), given = util.trim(given) }
  end

  local words = {}
  for w in s:gmatch("%S+") do words[#words + 1] = w end
  if #words == 0 then return nil end
  if #words == 1 then return { family = words[1] } end

  family = table.remove(words)
  while #words > 1 and PARTICLES[words[#words]:lower()] do
    family = table.remove(words) .. " " .. family
  end
  return { family = family, given = table.concat(words, " ") }
end

function M.normalize_authors(v)
  if v == nil then return nil end
  local out = {}

  local function add(item)
    if type(item) == "string" then
      local n = M.parse_name(item)
      if n then out[#out + 1] = n end
      return
    end
    if type(item) ~= "table" then return end

    local name = item.name
    if type(name) == "table" then
      if name.family or name.given then
        out[#out + 1] = { family = name.family, given = name.given }
      elseif name.literal then
        -- Nome literal (institucional) não é particionado em família/prenome.
        local lit = util.trim(name.literal)
        if lit ~= "" then out[#out + 1] = { literal = lit } end
      end
    elseif type(name) == "string" then
      local n = M.parse_name(name)
      if n then out[#out + 1] = n end
    elseif item.family or item.given then
      out[#out + 1] = { family = item.family, given = item.given }
    elseif item.literal then
      local lit = util.trim(item.literal)
      if lit ~= "" then out[#out + 1] = { literal = lit } end
    end
  end

  if type(v) == "table" and #v > 0 then
    for _, item in ipairs(v) do add(item) end
  else
    add(v)
  end

  if #out == 0 then return nil end
  return out
end

function M.page_url(site_url, output_file)
  if not site_url or site_url == "" then return nil end
  local base = tostring(site_url):gsub("/+$", "")
  if not output_file or output_file == "" or output_file == "index.html" then
    return base .. "/"
  end
  return base .. "/" .. output_file
end

local function first(...)
  -- select(), não ipairs sobre {...}: ipairs para no primeiro nil, então
  -- first(nil, "x") devolveria nil mesmo com "x" presente na posição 2.
  local n = select("#", ...)
  for i = 1, n do
    local v = select(i, ...)
    if v ~= nil and v ~= "" then return v end
  end
  return nil
end

-- Nomes de campo aceitos na config do usuário → chave CSL correspondente.
local FIELD_ALIAS = {
  url = "URL", doi = "DOI", isbn = "ISBN",
  ["publisher-place"] = "publisher-place",
}

-- Quarto injeta o número do capítulo em meta.title antes do filtro rodar.
-- Verificado em protótipo (livro numerado, Quarto 1.8.26) inspecionando os
-- bytes da string já achatada por pandoc.utils.stringify: o HTML real é
-- <span class="chapter-number">2</span>&nbsp; <span class="chapter-title">
-- Fabaceae</span>, e o stringify achata isso em "2\194\160 Fabaceae" — um
-- NBSP (U+00A0, bytes C2 A0) logo após o número, seguido de um espaço comum.
-- Título normal nunca contém NBSP, então ancorar nele (em vez de contar
-- espaços) elimina o falso positivo de título legítimo começando com número:
-- o capítulo 4 "1984 revisitado" chega como "4\194\160 1984 revisitado" — só
-- o "4\194\160 " injetado sai, e o "1984" do título de verdade, que usa
-- espaço comum, permanece. Sem numeração o título chega puro, sem NBSP.
-- Apêndices (testado com o campo appendices: do book, sem configuração
-- especial) seguem um padrão totalmente diferente e sem NBSP ("Appendix A —
-- Título" / "Apêndice A — Título", já com o rótulo por extenso) — não são
-- tratados aqui. O padrão aceita letra ou dígito antes do NBSP (%w+, não só
-- %d+) para não perder um esquema de numeração por letra caso exista, mas
-- isso não foi observado em nenhum caso testado; documentado como limitação
-- conhecida. O autor sobrescreve com extensions.cite-this.page.title quando precisar.
local NBSP = "\194\160"
local function strip_chapter_number(title)
  if type(title) ~= "string" then return title end
  local cleaned = title:match("^%w+" .. NBSP .. " (.+)$")
  return cleaned or title
end

local function apply_overrides(rec, over)
  if type(over) ~= "table" then return rec end
  for k, v in pairs(over) do
    local key = FIELD_ALIAS[k] or k
    if key == "author" or key == "editor" then
      rec[key] = M.normalize_authors(v)
    elseif key == "issued" or key == "accessed" then
      rec[key] = util.date_parts(v)
    else
      rec[key] = v
    end
  end
  return rec
end

function M.build(meta, cfg, ctx)
  local m = util.to_plain(meta) or {}
  ctx = ctx or {}

  -- ctx.project é a base (vem do _quarto.yml); o metadata do documento, quando
  -- traz o bloco, sobrepõe. Books têm meta.book; websites não têm meta.website.
  local from_meta = (type(m.book) == "table" and m.book)
    or (type(m.website) == "table" and m.website) or nil
  local is_book = type(m.book) == "table"
    or (ctx.project ~= nil and ctx.project.kind == "book")

  local proj = {}
  for k, v in pairs(ctx.project or {}) do
    if k ~= "kind" then proj[k] = v end
  end
  for k, v in pairs(from_meta or {}) do proj[k] = v end

  local site_url = first(proj["site-url"], m["site-url"])

  local work = {
    id = "work",
    -- webpage nos dois escopos: é o que faz os estilos imprimirem "Disponível
    -- em"/"Acesso em". Com book/chapter o ABNT, que é o padrão, omite ambos.
    type = "webpage",
    title = first(proj.title, m.title),
    author = M.normalize_authors(first(proj.author, proj.authors)),
    issued = util.date_parts(first(proj.date, m.date)),
    publisher = proj.publisher,
    ISBN = proj.isbn,
    DOI = proj.doi,
    URL = site_url,
  }

  -- Overrides de extensions.cite-this.work precisam rodar antes de "page" herdar de
  -- "work" por fallback (container-title, author, issued): como Lua atribui
  -- por valor, herdar antes do override congelaria o estado derivado de
  -- "work" e nenhum override chegaria à página.
  apply_overrides(work, cfg.work)

  local page = {
    id = "page",
    type = "webpage",
    title = strip_chapter_number(m.title),
    ["container-title"] = work.title,
    author = M.normalize_authors(first(m["by-author"], m.author, m.authors)) or work.author,
    issued = util.date_parts(m.date) or work.issued,
    DOI = m.doi,
    URL = M.page_url(site_url, ctx.output_file),
  }

  -- O bloco citation: nativo do Quarto descreve o documento atual e continua
  -- vindo antes de extensions.cite-this.page (mesma precedência de antes).
  apply_overrides(page, m.citation)
  apply_overrides(page, cfg.page)

  if page["container-title"] == page.title then
    page["container-title"] = nil
  end

  local accessed = util.date_parts(cfg.accessed)
  work.accessed = work.accessed or accessed
  page.accessed = page.accessed or accessed

  for _, rec in ipairs({ work, page }) do
    if not rec.title then
      util.warn(("sem título para a citação do escopo %q — o campo será omitido"):format(rec.id))
    end
    if not rec.URL then
      util.warn(("sem URL para a citação do escopo %q — defina site-url no _quarto.yml")
        :format(rec.id))
    end
    if not rec.author then
      util.warn(("sem autor para a citação do escopo %q — o campo será omitido"):format(rec.id))
    end
  end

  return { page = page, work = work }
end

return M

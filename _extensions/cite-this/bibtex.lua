local util = require("util")
local i18n = require("i18n")

local M = {}

-- Abreviações de mês do BibTeX: sempre em inglês, é o que o formato define.
local BIB_MONTHS = { "jan", "feb", "mar", "apr", "may", "jun",
                     "jul", "aug", "sep", "oct", "nov", "dec" }

local LATEX = {
  ["\\"] = "\\textbackslash{}", ["&"] = "\\&", ["%"] = "\\%", ["#"] = "\\#",
  ["_"] = "\\_", ["$"] = "\\$", ["{"] = "\\{", ["}"] = "\\}",
  ["~"] = "\\textasciitilde{}", ["^"] = "\\textasciicircum{}",
}

-- Uma passagem só: as substituições contêm barras e chaves que não podem ser
-- reprocessadas.
function M.escape(s)
  return (tostring(s):gsub("[\\&%%#_%${}~%^]", LATEX))
end

-- Palavras ignoradas ao escolher a palavra do título para a chave.
local STOPWORDS = {
  a = true, o = true, as = true, os = true, um = true, uma = true,
  de = true, da = true, do_ = true, das = true, dos = true, e = true,
  the = true, an = true, of = true, ["in"] = true, on = true, and_ = true,
  el = true, la = true, los = true, las = true, y = true,
}
STOPWORDS["do"] = true
STOPWORDS["and"] = true

function M.tokens(rec)
  local author = "anon"
  if rec.author and rec.author[1] then
    local first_author = rec.author[1]
    author = first_author.literal or first_author.family or first_author.given or "anon"
  end

  local year = "nd"
  if rec.issued and rec.issued.year then year = tostring(rec.issued.year) end

  local title = ""
  for word in tostring(rec.title or ""):gmatch("%S+") do
    local slug = util.slug(word)
    if slug ~= "" and not STOPWORDS[slug] then
      title = slug
      break
    end
  end

  return { author = util.slug(author), year = year, title = title, scope = tostring(rec.id or "") }
end

function M.make_key(rec, pattern)
  local tk = M.tokens(rec)
  return (tostring(pattern or "{author}{year}{title}"):gsub("{(%w+)}", function(k)
    return tk[k] or ""
  end))
end

function M.filename(rec, cfg)
  local bib = cfg.bibtex or {}
  local tk = M.tokens(rec)
  tk.key = M.make_key(rec, bib.key)
  local name = tostring(bib.filename or "{key}.bib"):gsub("{(%w+)}", function(k)
    return tk[k] or ""
  end)
  return name
end

local CONTAINER_TYPES = { inbook = true, incollection = true, inproceedings = true }

function M.render(rec, cfg, lang)
  local terms = i18n.terms(lang)
  local bib = cfg.bibtex or {}
  local btype = bib.type or "misc"
  local key = M.make_key(rec, bib.key)

  local fields = {}
  local function put(name, value, raw)
    if value == nil or value == "" then return end
    fields[#fields + 1] = { name, raw and tostring(value) or M.escape(value) }
  end

  if rec.author then
    local parts = {}
    for _, a in ipairs(rec.author) do
      if a.literal then
        parts[#parts + 1] = "{" .. M.escape(a.literal) .. "}"
      elseif a.family and a.given then
        parts[#parts + 1] = M.escape(a.family .. ", " .. a.given)
      else
        parts[#parts + 1] = M.escape(a.family or a.given)
      end
    end
    put("author", table.concat(parts, " and "), true)
  end

  put("title", rec.title)

  if rec.issued then
    put("year", rec.issued.year and tostring(rec.issued.year))
    put("month", rec.issued.month and BIB_MONTHS[rec.issued.month])
  end

  put("publisher", rec.publisher)
  put("address", rec["publisher-place"])
  put("edition", rec.edition)
  put("version", rec.version)
  put("isbn", rec.ISBN)
  put("doi", rec.DOI, true)

  if rec["container-title"] and CONTAINER_TYPES[btype] then
    put("booktitle", rec["container-title"])
  end

  if rec.URL then
    fields[#fields + 1] = { "howpublished", "\\url{" .. rec.URL .. "}" }
    fields[#fields + 1] = { "url", rec.URL }
    local iso = util.iso_date(rec.accessed)
    if iso then fields[#fields + 1] = { "urldate", iso } end
  end

  local note = {}
  if rec["container-title"] and not CONTAINER_TYPES[btype] then
    note[#note + 1] = terms.in_label .. ": " .. rec["container-title"]
  end
  local human = i18n.human_date(rec.accessed, lang)
  if human then note[#note + 1] = terms.accessed .. ": " .. human end
  if #note > 0 then put("note", table.concat(note, ". ")) end

  local width = 0
  for _, f in ipairs(fields) do width = math.max(width, #f[1]) end

  local lines = { "@" .. btype .. "{" .. key .. "," }
  for i, f in ipairs(fields) do
    lines[#lines + 1] = ("  %-" .. width .. "s = {%s}%s")
      :format(f[1], f[2], i < #fields and "," or "")
  end
  lines[#lines + 1] = "}"
  return table.concat(lines, "\n")
end

return M

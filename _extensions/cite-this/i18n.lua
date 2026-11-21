local M = {}

local STRINGS = {
  pt = {
    label = "Como citar", copy_text = "Copiar citação", copy_bibtex = "Copiar BibTeX",
    download = "Baixar .bib", copied = "Copiado", options = "Opções de citação",
    scope = "Escopo", style = "Estilo", page = "Esta página", work = "Obra completa",
    text_tab = "Texto", bibtex_tab = "BibTeX", accessed = "Acesso em",
    in_label = "Em", document_style = "Do documento",
  },
  en = {
    label = "Cite this", copy_text = "Copy citation", copy_bibtex = "Copy BibTeX",
    download = "Download .bib", copied = "Copied", options = "Citation options",
    scope = "Scope", style = "Style", page = "Page", work = "Whole work",
    text_tab = "Text", bibtex_tab = "BibTeX", accessed = "Accessed",
    in_label = "In", document_style = "Document style",
  },
  es = {
    label = "Cómo citar", copy_text = "Copiar cita", copy_bibtex = "Copiar BibTeX",
    download = "Descargar .bib", copied = "Copiado", options = "Opciones de cita",
    scope = "Ámbito", style = "Estilo", page = "Esta página", work = "Obra completa",
    text_tab = "Texto", bibtex_tab = "BibTeX", accessed = "Acceso en",
    in_label = "En", document_style = "Del documento",
  },
}

local MONTHS = {
  pt = { "jan.", "fev.", "mar.", "abr.", "maio", "jun.", "jul.", "ago.", "set.", "out.", "nov.", "dez." },
  en = { "Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec." },
  es = { "ene.", "feb.", "mar.", "abr.", "may.", "jun.", "jul.", "ago.", "sep.", "oct.", "nov.", "dic." },
}

local function code(lang)
  return tostring(lang or "en"):lower():sub(1, 2)
end

function M.terms(lang)
  return STRINGS[code(lang)] or STRINGS.en
end

function M.month_abbr(lang)
  return MONTHS[code(lang)] or MONTHS.en
end

function M.human_date(parts, lang)
  if not parts or not parts.year then return nil end
  if not parts.month then return tostring(parts.year) end
  local month = M.month_abbr(lang)[parts.month]
  if not month then return tostring(parts.year) end
  if not parts.day then return ("%s %d"):format(month, parts.year) end
  if code(lang) == "en" then
    return ("%s %d, %d"):format(month, parts.day, parts.year)
  end
  return ("%d %s %d"):format(parts.day, month, parts.year)
end

return M

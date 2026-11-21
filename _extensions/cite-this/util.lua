---@diagnostic disable: undefined-global
local M = {}

function M.warn(msg)
  io.stderr:write("\27[33mWARNING [cite-this]: " .. tostring(msg) .. "\27[0m\n")
end

function M.trim(s)
  return (tostring(s):gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Dobra de acentos latinos. As chaves cobrem maiúsculas e minúsculas porque
-- string.lower() do Lua não age sobre bytes multibyte de UTF-8.
local FOLD = {
  ["á"]="a", ["à"]="a", ["â"]="a", ["ã"]="a", ["ä"]="a", ["å"]="a",
  ["Á"]="a", ["À"]="a", ["Â"]="a", ["Ã"]="a", ["Ä"]="a", ["Å"]="a",
  ["é"]="e", ["è"]="e", ["ê"]="e", ["ë"]="e",
  ["É"]="e", ["È"]="e", ["Ê"]="e", ["Ë"]="e",
  ["í"]="i", ["ì"]="i", ["î"]="i", ["ï"]="i",
  ["Í"]="i", ["Ì"]="i", ["Î"]="i", ["Ï"]="i",
  ["ó"]="o", ["ò"]="o", ["ô"]="o", ["õ"]="o", ["ö"]="o",
  ["Ó"]="o", ["Ò"]="o", ["Ô"]="o", ["Õ"]="o", ["Ö"]="o",
  ["ú"]="u", ["ù"]="u", ["û"]="u", ["ü"]="u",
  ["Ú"]="u", ["Ù"]="u", ["Û"]="u", ["Ü"]="u",
  ["ç"]="c", ["Ç"]="c", ["ñ"]="n", ["Ñ"]="n", ["ý"]="y", ["Ý"]="y",
}

function M.ascii_fold(s)
  -- Casa qualquer sequência UTF-8 multibyte; o que não estiver na tabela é
  -- descartado, o que é o comportamento desejado para chaves BibTeX.
  local folded = tostring(s):gsub("[\194-\244][\128-\191]*", function(c)
    return FOLD[c] or ""
  end)
  return folded:lower()
end

function M.slug(s)
  return (M.ascii_fold(s):gsub("[^%a%d]", ""))
end

local HTML_ESC = { ["&"]="&amp;", ["<"]="&lt;", [">"]="&gt;", ['"']="&quot;", ["'"]="&#39;" }

function M.esc_html(s)
  return (tostring(s):gsub("[&<>\"']", HTML_ESC))
end

function M.to_plain(v)
  if v == nil then return nil end
  local lt = type(v)
  if lt == "boolean" or lt == "number" or lt == "string" then return v end
  local pt = pandoc.utils.type(v)
  if pt == "Inlines" or pt == "Blocks" then return pandoc.utils.stringify(v) end
  if pt == "List" then
    local out = {}
    for i, item in ipairs(v) do out[i] = M.to_plain(item) end
    return out
  end
  if lt == "table" then
    local out = {}
    for k, item in pairs(v) do out[k] = M.to_plain(item) end
    return out
  end
  return pandoc.utils.stringify(v)
end

function M.to_meta(v)
  local lt = type(v)
  if lt == "boolean" then return pandoc.MetaBool(v) end
  if lt == "number" then return pandoc.MetaString(tostring(v)) end
  if lt == "string" then return pandoc.MetaString(v) end
  if lt == "table" then
    if #v > 0 then
      local out = {}
      for i, item in ipairs(v) do out[i] = M.to_meta(item) end
      return pandoc.MetaList(out)
    end
    local out = {}
    for k, item in pairs(v) do out[k] = M.to_meta(item) end
    return pandoc.MetaMap(out)
  end
  return pandoc.MetaString(tostring(v))
end

function M.date_parts(s)
  if s == nil then return nil end
  s = M.trim(s)
  if s == "" then return nil end
  local y, m, d = s:match("^(%d%d%d%d)%-(%d%d?)%-(%d%d?)")
  if not y then y, m = s:match("^(%d%d%d%d)%-(%d%d?)") end
  if not y then y = s:match("^(%d%d%d%d)$") end
  if not y then y = s:match("(%d%d%d%d)") end
  if not y then return nil end
  return { year = tonumber(y), month = m and tonumber(m) or nil, day = d and tonumber(d) or nil }
end

function M.iso_date(parts)
  if not parts or not parts.year then return nil end
  if not parts.month then return tostring(parts.year) end
  if not parts.day then return ("%04d-%02d"):format(parts.year, parts.month) end
  return ("%04d-%02d-%02d"):format(parts.year, parts.month, parts.day)
end

return M

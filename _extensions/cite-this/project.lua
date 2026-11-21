local M = {}

local function parse_scalar(raw)
  local v = raw:gsub("^%s+", ""):gsub("%s+$", "")
  if v == "" or v:sub(1, 1) == "#" then return nil end
  if v == "true" then return true end
  if v == "false" then return false end
  local dq = v:match('^"(.*)"$')
  if dq then return dq end
  local sq = v:match("^'(.*)'$")
  if sq then return sq end
  return v
end

-- Lê os escalares de primeiro nível de book:/website: no _quarto.yml.
-- Não é um parser de YAML: só o que a citação da obra precisa (title, author,
-- date, site-url, publisher, isbn). Listas e mapas aninhados são ignorados de
-- propósito.
function M.read(dir)
  if dir == nil or dir == "" then return nil end
  local f = io.open(dir .. "/_quarto.yml", "r")
  if not f then return nil end

  local found, current, indent = {}, nil, nil

  for line in f:lines() do
    if not line:match("^%s*#") and not line:match("^%s*$") then
      local top = line:match("^(book):%s*$") or line:match("^(website):%s*$")
      if top then
        current, indent = top, nil
        found[top] = found[top] or {}
      elseif current then
        local lead = #(line:match("^(%s*)"))
        if lead == 0 then
          current, indent = nil, nil
        else
          indent = indent or lead
          if lead == indent then
            local key, raw = line:match("^%s*([%w_.-]+):%s*(.-)%s*$")
            if key then
              local value = parse_scalar(raw)
              if value ~= nil then found[current][key] = value end
            end
          end
        end
      end
    end
  end

  f:close()

  local kind = found.book and "book" or (found.website and "website" or nil)
  if not kind then return nil end
  local out = found[kind]
  out.kind = kind
  return out
end

return M

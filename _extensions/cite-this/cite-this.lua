---@diagnostic disable: undefined-global
-- Pass the extension path explicitly so Quarto's own filters can still
-- resolve their assets against the filter runner's PANDOC_SCRIPT_FILE.
local SCRIPT_FILE = PANDOC_SCRIPT_FILE
package.path = ((SCRIPT_FILE or ""):match("(.*[/\\])") or "") .. "?.lua;" .. package.path

local data = require("data")
local widget = require("widget")

local state = nil

local function collect(meta)
  state = data.get(meta, SCRIPT_FILE)
  return meta
end

local function inject(doc)
  if not state then return doc end
  local cfg = state.cfg
  if cfg.position == "inline" or cfg.position == "none" then return doc end
  if #state.styles == 0 then return doc end
  if not data.wants_format(cfg) then return doc end
  if not quarto.doc.is_format("html:js") then return doc end

  data.add_dependency()
  doc.blocks:insert(pandoc.RawBlock("html", widget.build(state, { mode = "actions" })))
  return doc
end

return {
  { Meta = collect },
  { Pandoc = inject },
}

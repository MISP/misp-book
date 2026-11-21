---@diagnostic disable: undefined-global
local SCRIPT_FILE = PANDOC_SCRIPT_FILE
package.path = ((SCRIPT_FILE or ""):match("(.*[/\\])") or "") .. "?.lua;" .. package.path

local data = require("data")
local widget = require("widget")

local function opt(kwargs, name)
  local v = kwargs and kwargs[name]
  if v == nil then return nil end
  local s = pandoc.utils.stringify(v)
  if s == "" then return nil end
  return s
end

return {
  ["cite-this"] = function(args, kwargs, meta)
    local state = data.get(meta, SCRIPT_FILE)
    local cfg = state.cfg
    local opts = { mode = "inline" }

    for _, a in ipairs(args or {}) do
      local v = pandoc.utils.stringify(a)
      if v == "page" or v == "work" then opts.scope = v end
    end

    opts.style = opt(kwargs, "style")
    local collapsed = opt(kwargs, "collapsed")
    opts.collapsed = collapsed == "true" or (collapsed == nil and cfg.collapsed == true)

    if #state.styles == 0 then return pandoc.Null() end
    if not data.wants_format(cfg) then return pandoc.Null() end

    if quarto.doc.is_format("html:js") then
      data.add_dependency()
      return pandoc.RawBlock("html", widget.build(state, opts))
    end

    return widget.static_blocks(state, opts)
  end,
}

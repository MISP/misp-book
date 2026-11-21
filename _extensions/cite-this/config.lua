---@diagnostic disable: undefined-global
local util = require("util")

local M = {}

M.DEFAULTS = {
  position = "floating",
  corner = "bottom-right",
  scope = "both",
  ["default-scope"] = "page",
  styles = { "apa", "abnt", "ieee", "mla", "harvard" },
  ["use-document-csl"] = true,
  ["default-style"] = "apa",
  ["access-date"] = "build",
  actions = { "text", "bibtex", "download" },
  ["show-label"] = true,
  ["remember-choice"] = true,
  formats = { "html" },
  collapsed = false,
  label = nil,
  bibtex = { type = "misc", key = "{author}{year}{title}", filename = "{key}.bib" },
}

local ENUMS = {
  position = {
    sidebar = true,
    ["margin-sidebar"] = true,
    floating = true,
    navbar = true,
    title = true,
    inline = true,
    none = true,
  },
  corner = { ["bottom-right"] = true, ["bottom-left"] = true, ["top-right"] = true, ["top-left"] = true },
  scope = { both = true, work = true, page = true },
  ["default-scope"] = { page = true, work = true },
}

local function copy_array(tbl)
  local out = {}
  for i, v in ipairs(tbl) do out[i] = v end
  return out
end

local function copy_defaults()
  local out = {}
  for k, v in pairs(M.DEFAULTS) do
    if type(v) == "table" then
      local inner = {}
      for kk, vv in pairs(v) do inner[kk] = vv end
      out[k] = inner
    else
      out[k] = v
    end
  end
  return out
end

function M.resolve(meta)
  local extensions = meta and util.to_plain(meta.extensions) or nil
  local user = type(extensions) == "table" and extensions["cite-this"] or nil
  if type(user) ~= "table" then user = {} end

  local cfg = copy_defaults()
  for k, v in pairs(user) do
    if k == "bibtex" and type(v) == "table" then
      for kk, vv in pairs(v) do cfg.bibtex[kk] = vv end
    else
      cfg[k] = v
    end
  end

  for _, k in ipairs({ "styles", "actions", "formats" }) do
    if type(cfg[k]) == "string" then cfg[k] = { cfg[k] } end
    if type(cfg[k]) ~= "table" then cfg[k] = copy_array(M.DEFAULTS[k]) end
  end

  -- Aceita os nomes direcionais usados brevemente durante o desenvolvimento,
  -- mas expõe os mesmos termos dos elementos oficiais do Quarto.
  if cfg.position == "sidebar-left" then cfg.position = "sidebar" end
  if cfg.position == "sidebar-right" then cfg.position = "margin-sidebar" end

  for key, allowed in pairs(ENUMS) do
    if not allowed[cfg[key]] then
      util.warn(("valor inválido para extensions.cite-this.%s: %q — usando %q")
        :format(key, tostring(cfg[key]), M.DEFAULTS[key]))
      cfg[key] = M.DEFAULTS[key]
    end
  end

  local today = os.date("%Y-%m-%d")
  local ad = cfg["access-date"]
  if ad == "dynamic" then
    util.warn("extensions.cite-this.access-date: dynamic ainda não está implementado — usando a data do build")
    ad = "build"
  end
  if ad == "build" then
    cfg.accessed = today
  elseif type(ad) == "string" and ad:match("^%d%d%d%d%-%d%d%-%d%d$") then
    cfg.accessed = ad
  else
    util.warn(("extensions.cite-this.access-date inválido: %q — usando a data do build"):format(tostring(ad)))
    cfg.accessed = today
    ad = "build"
  end
  cfg["access-date"] = ad

  if cfg.scope ~= "both" then cfg["default-scope"] = cfg.scope end

  -- Registra se o autor escolheu o estilo padrão. Se não escolheu, o csl: do
  -- documento pode assumir esse papel (ver csl.pick_default).
  cfg["default-style-explicit"] = user["default-style"] ~= nil

  return cfg
end

return M

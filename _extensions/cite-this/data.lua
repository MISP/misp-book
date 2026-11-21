---@diagnostic disable: undefined-global
local util = require("util")
local config = require("config")
local citation = require("citation")
local bibtex = require("bibtex")
local csl = require("csl")
local project = require("project")

local M = {}

local cached = nil
local declared = false

function M.get(meta, script_file)
  if cached then return cached end

  local cfg = config.resolve(meta)
  local lang = meta and meta.lang and util.to_plain(meta.lang) or "en"
  local ctx = {
    output_file = (quarto.doc.project_output_file and quarto.doc.project_output_file())
      or (PANDOC_STATE and PANDOC_STATE.output_file),
    -- Websites não expõem meta.website ao filtro; o _quarto.yml cobre a lacuna.
    project = project.read(quarto.project and quarto.project.directory),
  }

  local records = citation.build(meta, cfg, ctx)
  local styles = csl.resolve_styles(cfg, meta, script_file)
  local variants = csl.render(records, styles, lang)

  -- Um estilo que não formatou nenhum escopo não pode aparecer na interface.
  local kept = {}
  for _, st in ipairs(styles) do
    if variants[st.name] and next(variants[st.name]) ~= nil then
      kept[#kept + 1] = st
    end
  end

  local bib = {}
  for _, scope in ipairs({ "page", "work" }) do
    if records[scope] then
      bib[scope] = {
        text = bibtex.render(records[scope], cfg, lang),
        filename = bibtex.filename(records[scope], cfg),
      }
    end
  end

  cached = {
    cfg = cfg,
    lang = lang,
    records = records,
    styles = kept,
    variants = variants,
    bibtex = bib,
    default_style = csl.pick_default(kept, cfg["default-style"], cfg["default-style-explicit"]),
  }
  return cached
end

function M.add_dependency()
  if declared then return end
  declared = true
  quarto.doc.add_html_dependency({
    name = "cite-this",
    version = "1.0.4",
    stylesheets = { "cite-this.css" },
    scripts = { "cite-this.js" },
  })
end

function M.wants_format(cfg)
  for _, f in ipairs(cfg.formats or {}) do
    if quarto.doc.is_format(f) then return true end
  end
  return false
end

return M

-- Only the print edition: keep one chapter title per source file, and cap tall figures.
local current_file, seen_title, legacy_container = nil, false, false
local level_offset = nil
local chapter_ids = {}
local function file_info()
  local state = quarto.doc.file_metadata()
  return state and state.file or nil
end
local function header(el)
  local file = file_info()
  if not file or file.bookItemType == 'part' then return nil end
  if file.bookItemType == 'appendix' and el.level == 1 and el.classes:includes('unnumbered') then
    -- The book filter's synthetic divider duplicates our actual Appendices chapter.
    return pandoc.RawBlock('typst', '#show: appendices.with("Appendices", hide-parent: true)')
  end
  if file.bookItemFile ~= current_file then
    current_file, seen_title, legacy_container = file.bookItemFile, false, false
    level_offset = nil
  end
  if el.level == 1 and not seen_title then
    seen_title = true
    chapter_ids[file.bookItemFile] = el.identifier
    if file.bookItemFile == 'index.qmd' then el.classes:insert('unnumbered') end
  elseif el.level == 1 then
    legacy_container = true
    el.level = 2
  elseif legacy_container then
    el.level = math.min(el.level + 1, 6)
  end
  -- Some older chapters start at H3. Keep sibling headings at the same depth.
  if el.level > 1 then
    level_offset = level_offset or (el.level - 2)
    el.level = math.max(2, el.level - level_offset)
  end
  if file.bookItemFile == 'index.qmd' and not el.classes:includes('unnumbered') then
    el.classes:insert('unnumbered')
  end
  return el
end
local function raw_block(el)
  if el.format ~= 'typst' then return nil end
  local file = file_info()
  if file and file.bookItemType == 'appendix' and
    el.text == '#heading(level: 1, numbering: none)[Appendices]' then return {} end
  if file and file.bookItemFile == 'index.qmd' and el.text:match('^#pagebreak%(%s*%)$') then return {} end
end
local function image(el)
  if el.attributes.width or el.attributes.height then return nil end
  local f = io.open(el.src, 'rb')
  if not f then return nil end
  local bytes = f:read(4096); f:close()
  local w, h
  if bytes:sub(1, 8) == '\137PNG\13\10\26\10' then
    local function uint32(n)
      local a,b,c,d = bytes:byte(n,n+3)
      return ((a*256+b)*256+c)*256+d
    end
    w, h = uint32(17), uint32(21)
  elseif el.src:match('%.svg$') then
    local box = bytes:match('viewBox="([^"]+)"')
    if box then local x,y; x,y,w,h = box:match('(%S+)%s+(%S+)%s+(%S+)%s+(%S+)'); w,h=tonumber(w),tonumber(h) end
  end
  if w and h and w>0 and h>0 then
    local width = math.min(164, 140*w/h)
    el.attributes.width = string.format('%.2fmm',width)
  end
  return el
end
local function chapter_links(doc)
  -- Quarto resolves section links, but some chapter-only links retain a .qmd path.
  -- All book chapters currently live at the project root or one directory below it.
  -- Resolve against the collected chapter identifiers after the complete header pass.
  return doc:walk({Link = function(el)
    local path = el.target:match('^(.-%.qmd)$')
    if not path or path:match('^%a[%w+.-]*:') then return nil end
    path = path:gsub('^%./', '')
    while path:sub(1, 3) == '../' do path = path:sub(4) end
    if chapter_ids[path] and chapter_ids[path] ~= '' then
      el.target = '#' .. chapter_ids[path]
      return el
    end
  end})
end
return quarto.utils.combineFilters({quarto.utils.file_metadata_filter(), {
  Header=header, Image=image, RawBlock=raw_block, Pandoc=chapter_links
}})

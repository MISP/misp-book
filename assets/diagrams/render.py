#!/usr/bin/env python3
"""Render the book's committed Mermaid sources to portable SVGs (no Quarto filter)."""
import argparse
import hashlib
import json
import re
from pathlib import Path
import xml.etree.ElementTree as ET

from playwright.sync_api import sync_playwright

ROOT = Path(__file__).resolve().parents[2]
THEME = ROOT / "assets/diagrams/theme.json"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mermaid-js", type=Path, required=True)
    parser.add_argument("--chromium", default="/usr/bin/chromium")
    args = parser.parse_args()
    theme = json.loads(THEME.read_text())
    logo_path = ROOT / theme['frame']['logo']
    logo = logo_path.read_text()
    # Sources carry meaning and semantic classes; presentation lives in one place.
    classes = '\n'.join(f'  classDef {name} {style};' for name, style in theme['classes'].items())
    rows = []
    with sync_playwright() as p:
        browser = p.chromium.launch(executable_path=args.chromium, args=["--no-sandbox"])
        page = browser.new_page()
        page.set_content('<html><head></head><body></body></html>')
        page.add_script_tag(path=str(args.mermaid_js))
        for source in sorted(ROOT.glob('*/figures/*.mmd')):
            source_text = source.read_text()
            if re.search(r'\bclassDef\b|\b(?:fill|stroke|color):|%%\{', source_text):
                raise ValueError(f'{source}: use shared theme classes instead of local styling')
            # classDef is flowchart syntax; sequence diagrams reject it. Other
            # diagram types still receive the shared Mermaid theme and frame.
            if re.search(r'^\s*(?:flowchart|graph)\b', source_text, re.MULTILINE):
                source_text += '\n' + classes
            svg = page.evaluate(r"""async ({source, id, theme, logo}) => {
              mermaid.initialize({...theme.mermaid, deterministicIDSeed:id});
              const result = await mermaid.render(id, source);
              document.body.innerHTML = result.svg;
              await document.fonts.ready;
              // Explicit SVG geometry also works in Typst; CSS rx/ry do not.
              for (const [selector, radius] of [['.node rect', theme.shapes.nodeRadius],
                ['.cluster rect', theme.shapes.clusterRadius]]) {
                for (const rect of document.querySelectorAll(selector)) {
                  rect.setAttribute('rx', radius);
                  rect.setAttribute('ry', radius);
                }
              }
              // Native SVG edge labels need an explicit background: unlike HTML
              // labels, Mermaid leaves them transparent over the connecting line.
              const labelBackground = theme.mermaid.themeVariables.edgeLabelBackground;
              for (const label of document.querySelectorAll('g.edgeLabel text')) {
                const box = label.getBBox();
                const background = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
                for (const [key, value] of Object.entries({x:box.x-4, y:box.y-2,
                  width:box.width+8, height:box.height+4, fill:labelBackground, rx:3})) {
                  background.setAttribute(key, String(value));
                }
                background.setAttribute('style', `fill:${labelBackground}!important;opacity:1!important`);
                label.parentNode.insertBefore(background, label);
              }
              const graph = document.querySelector('svg');
              const [x, y, width, height] = graph.getAttribute('viewBox').split(/\s+/).map(Number);
              const frame = theme.frame;
              const totalWidth = Math.max(width + 2 * frame.padding,
                frame.logoWidth + 2 * frame.padding);
              const graphTop = frame.headerHeight + frame.graphGap;
              const totalHeight = graphTop + height + frame.padding;
              const ns = 'http://www.w3.org/2000/svg';
              const element = (tag, attrs) => {
                const el = document.createElementNS(ns, tag);
                for (const [key, value] of Object.entries(attrs)) el.setAttribute(key, value);
                return el;
              };
              // Keep the diagram's accessible title/description and stylesheet at the root.
              const contents = element('g', {class:'misp-diagram-content',
                transform:`translate(${(totalWidth-width)/2-x},${graphTop-y})`});
              for (const child of [...graph.children]) {
                if (!['title', 'desc', 'style', 'defs'].includes(child.tagName)) contents.append(child);
              }
              graph.append(element('rect', {x:0.5, y:0.5, width:totalWidth-1,
                height:totalHeight-1, rx:10, fill:frame.background, stroke:frame.border,
                'stroke-width':1, 'aria-hidden':'true'}));
              // Embed actual vector artwork, not a URL, font glyph or raster image.
              const brand = new DOMParser().parseFromString(logo, 'image/svg+xml').documentElement;
              const [, , lw, lh] = brand.getAttribute('viewBox').split(/\s+/).map(Number);
              for (const [key, value] of Object.entries({x:frame.padding, y:frame.logoTop,
                width:frame.logoWidth, height:frame.logoWidth*lh/lw,
                'aria-hidden':'true', focusable:'false', class:'misp-diagram-logo'})) {
                brand.setAttribute(key, value);
              }
              graph.append(document.importNode(brand, true));
              graph.append(element('line', {x1:frame.padding, y1:frame.headerHeight,
                x2:totalWidth-frame.padding, y2:frame.headerHeight,
                stroke:frame.rule, 'stroke-width':1, 'aria-hidden':'true'}));
              graph.append(contents);
              graph.setAttribute('viewBox', `0 0 ${totalWidth} ${totalHeight}`);
              graph.setAttribute('style', `background:${frame.background};max-width:100%;height:auto`);
              return graph.outerHTML;
            }""", {"source": source_text,
                    "id": "misp-" + source.parent.parent.name + '-' + source.stem,
                    "theme": theme, "logo": logo})
            root = ET.fromstring(svg)
            assert 'foreignObject' not in svg, source
            assert root.find('{http://www.w3.org/2000/svg}title') is not None, source
            assert root.find('{http://www.w3.org/2000/svg}desc') is not None, source
            # Explicit dimensions keep SVG sizing consistent in HTML, EPUB and Typst.
            _, _, width, height = root.attrib['viewBox'].split()
            opening = re.match(r'<svg\b[^>]*>', svg).group()
            sized = re.sub(r'\s(?:width|height)="[^"]*"', '', opening)
            sized = sized.replace('<svg', f'<svg width="{width}" height="{height}"', 1)
            svg = sized + svg[len(opening):]
            ET.fromstring(svg)
            target = source.with_suffix('.svg')
            target.write_text(svg + '\n')
            rows.append({"source": str(source.relative_to(ROOT)),
                         "file": str(target.relative_to(ROOT)),
                         "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
                         "sha256": hashlib.sha256(target.read_bytes()).hexdigest(),
                         "viewBox": root.attrib['viewBox']})
            print(target.relative_to(ROOT))
        browser.close()
    manifest = {"renderer": "Mermaid bundled with Quarto 1.9.38; Chromium via Playwright",
                "mermaid_js_sha256": hashlib.sha256(args.mermaid_js.read_bytes()).hexdigest(),
                "theme": str(THEME.relative_to(ROOT)),
                "theme_sha256": hashlib.sha256(THEME.read_bytes()).hexdigest(),
                "logo": str(logo_path.relative_to(ROOT)),
                "logo_sha256": hashlib.sha256(logo_path.read_bytes()).hexdigest(),
                "accessibility": "Each diagram has accTitle/accDescr, SVG text labels and explicit arrow labels; HTML labels are disabled for Typst compatibility.",
                "diagrams": rows}
    (ROOT / 'assets/diagrams/manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()

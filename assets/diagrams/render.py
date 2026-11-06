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
CHAPTERS = ("sharing", "managing-feeds", "collections", "cryptographic-keys",
            "automation", "pymisp", "misp-zmq", "modules", "connectors",
            "administration", "workflows", "updating-python")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mermaid-js", type=Path, required=True)
    parser.add_argument("--chromium", default="/usr/bin/chromium")
    args = parser.parse_args()
    rows = []
    with sync_playwright() as p:
        browser = p.chromium.launch(executable_path=args.chromium, args=["--no-sandbox"])
        page = browser.new_page()
        page.set_content('<html><head></head><body></body></html>')
        page.add_script_tag(path=str(args.mermaid_js))
        for chapter in CHAPTERS:
            for source in sorted((ROOT / chapter / "figures").glob("*.mmd")):
                svg = page.evaluate("""async ({source, id}) => {
                  mermaid.initialize({startOnLoad:false, securityLevel:'strict',
                    theme:'base', htmlLabels:false, deterministicIds:true, deterministicIDSeed:id,
                    fontFamily:'DejaVu Sans, sans-serif', fontSize:16,
                    themeVariables:{primaryColor:'#e7f6fa', primaryTextColor:'#153448',
                      primaryBorderColor:'#007b96', lineColor:'#516479',
                      secondaryColor:'#f0f3f7', tertiaryColor:'#ffffff',
                      clusterBkg:'#f8fafc', clusterBorder:'#bccbd5',
                      edgeLabelBackground:'#ffffff', fontSize:'16px'},
                    flowchart:{htmlLabels:false, curve:'linear', padding:18,
                      nodeSpacing:28, rankSpacing:42, useMaxWidth:false}});
                  const result = await mermaid.render(id, source);
                  document.body.innerHTML = result.svg;
                  await document.fonts.ready;
                  // Native SVG edge labels need an explicit background: unlike HTML
                  // labels, Mermaid leaves them transparent over the connecting line.
                  for (const label of document.querySelectorAll('g.edgeLabel text')) {
                    const box = label.getBBox();
                    const background = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
                    for (const [key, value] of Object.entries({x:box.x-4, y:box.y-2,
                      width:box.width+8, height:box.height+4, fill:'#ffffff', rx:3})) {
                      background.setAttribute(key, String(value));
                    }
                    background.setAttribute('style', 'fill:#ffffff!important;opacity:1!important');
                    label.parentNode.insertBefore(background, label);
                  }
                  return document.querySelector('svg').outerHTML;
                }""", {"source": source.read_text(), "id": "misp-" + source.stem})
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
                "accessibility": "Each diagram has accTitle/accDescr, SVG text labels and explicit arrow labels; HTML labels are disabled for Typst compatibility.",
                "diagrams": rows}
    (ROOT / 'assets/diagrams/manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()

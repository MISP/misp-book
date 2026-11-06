# Sharing and synchronization diagrams

The `.mmd` files beside each diagram are the editable Mermaid sources. The SVGs are
committed so HTML, PDF and EPUB builds do not need a browser or a Mermaid download.
Each SVG includes a title, a description and native text labels. Arrows explicitly
identify requests, data transfers or decisions; colour is supplementary.

To regenerate with Quarto **1.9.38**, Python Playwright and Chromium installed:

```sh
python assets/diagrams/render.py \
  --mermaid-js /path/to/quarto/share/formats/html/mermaid/mermaid.min.js \
  --chromium /usr/bin/chromium
```

`manifest.json` records source/output hashes and the Mermaid script hash. Review
the rendered figures after editing; check labels and arrow directions, and render
all book formats. HTML labels are disabled because Typst does not render SVG
`foreignObject` content.

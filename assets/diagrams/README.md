# Book diagrams

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

## Data-model overview adaptations

The diagrams in `data-model/figures/` adapt the **MISP / Team CIRCL** training
[data-model overview](https://github.com/MISP/misp-training/tree/b93884a7e2cefbeebdee0521e19638bca6962ed2/a.11.a-misp-data-model-overview)
at commit `b93884a7e2cefbeebdee0521e19638bca6962ed2`, under its
AGPL-3.0-or-later / CC-BY-SA-4.0 licensing:

| Mermaid source | Training TikZ source | Meaning of lines |
|---|---|---|
| `model-map.mmd` | `model-map.tikz` | Undirected branches identify four teaching views; they do not imply containment or storage boundaries. |
| `event-anatomy.mmd` | `event-anatomy.tikz` | Labeled arrows show optional event/object contents. |
| `references-and-correlation.mmd` | `object-references.tikz`, `correlation.tikz` | Solid arrows are explicit directed references; a dashed undirected line is a computed match. The examples are separate. |

The chapter adapts the training's 2.5 explanation to the book's MISP 3.0 snapshot,
`99ebee729702c560528f9788953719bda68aa1c1`. Value identity and Analyst Data target
claims were checked against `MispAttribute.php`, `AttributeValue.php`,
`AnalystData.php` and `Relationship.php`; reference/correlation caveats against
`ObjectReference.php` and `Correlation.php`. This is conceptual documentation,
not a complete schema or a new live-instance capture.

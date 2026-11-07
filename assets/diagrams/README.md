# Book diagrams

The `.mmd` files beside each diagram are the editable Mermaid sources. The SVGs are
committed so HTML, PDF and EPUB builds do not need a browser or a Mermaid download.
Each SVG includes a title, a description and native text labels. Arrows explicitly
identify requests, data transfers or decisions; colour is supplementary.

## Shared MISP theme

[`theme.json`](theme.json) is the single source for the Mermaid palette, typography,
spacing, semantic node classes and branded frame. It uses the book's teal
(`#007f99`), navy ink (`#203344`) and pale neutral surfaces. Rounded nodes, restrained
borders and clear connector labels provide a consistent style. Amber and green
remain available for caution and success; the wording and arrows carry the meaning.

Every rendered diagram receives the MISP logo at the top left, above a separator
and outside the graph's bounds. The white canvas keeps text and the unmodified
logo readable in the website's light/dark modes and in PDF/ePub. The logo is embedded
as vector paths in every SVG, so no remote image, raster fallback or brand font is
required. It is decorative; the diagram retains its own accessible title/description.

The [`misp-logo.svg`](misp-logo.svg) artwork is copied unchanged from
[MISP/misp-modules](https://github.com/MISP/misp-modules/blob/8548067afbb14c2a089c41105ec18b06ef71ab79/website/app/static/images/misp-logo.svg).
Credit: **MISP contributors**. See the MISP project's
[logo license (CC BY 4.0)](https://github.com/MISP/MISP/blob/99ebee729702c560528f9788953719bda68aa1c1/INSTALL/logos/README.md).

Use these shared classes in a source, without copying color definitions:

```text
flowchart LR
  accTitle: A reviewed result
  accDescr: An input is reviewed before an approved result is saved.
  A[Input] --> B[Review] --> C[Approved result]
  class A,B accent;
  class C success;
```

| Class | Use |
|---|---|
| Default | Ordinary diagram elements, with navy text and a teal outline. |
| `accent` | Main stages, instances or shared elements. |
| `muted` | Supporting records, credentials or results. |
| `caution` | Restricted paths, external trust boundaries, failures or retries. |
| `success` | Confirmed outcomes. |

The renderer discovers every `*/figures/*.mmd`, including new chapter diagrams,
and applies the theme and logo automatically. Keep local `classDef`, color values
and Mermaid initialization directives out of those sources so styling cannot drift.
The standalone `.mmd` files remain editable; use the renderer below to obtain the
shared appearance. The book includes the generated SVGs rather than rendering
Mermaid at page-load time.

## Regenerate

To regenerate with Quarto **1.9.38**, Python Playwright and Chromium installed:

```sh
python assets/diagrams/render.py \
  --mermaid-js /path/to/quarto/share/formats/html/mermaid/mermaid.min.js \
  --chromium /usr/bin/chromium
```

`manifest.json` records source/output, theme, logo and Mermaid script hashes. Review
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

The chapter adapts the training overview to the book's MISP 3.0 snapshot,
`99ebee729702c560528f9788953719bda68aa1c1`. Value identity and Analyst Data target
claims were checked against `MispAttribute.php`, `AttributeValue.php`,
`AnalystData.php` and `Relationship.php`; reference/correlation caveats against
`ObjectReference.php` and `Correlation.php`. This is conceptual documentation,
not a complete schema or a new live-instance capture.

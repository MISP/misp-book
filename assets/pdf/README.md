# PDF presentation

The `typst` format in `_quarto.yml` loads this layout; HTML and ePub keep their own
styles and navigation. Render with the repository's pinned Quarto 1.9.38:

```sh
quarto render --to typst
```

The result is `_book/book.pdf`. No LaTeX installation or live MISP service is needed.

- `misp-book.typ` controls the selectable-text cover, A4 page geometry, running
  headers/footers, part/chapter pages, contents, headings, tables and figure captions.
  It uses the existing MISP logo and the site's navy/teal palette.
- `typst-show.typ` replaces Quarto's Orange Book presentation while retaining the
  generated definitions for links, cross-references and chapter/appendix counters.
  Callouts retain their labels and highlighted code retains its tokens and line breaks.
  Typst's built-in raw-text size reduction is compensated for so code is 8.5pt.
  Long JSON examples in narrow table cells break between fields, preserving quoted
  values and avoiding inserted hyphens or invisible characters.
- `pdf-layout.lua` runs only for Typst. It keeps one chapter per source file,
  demotes legacy extra level-one headings, closes initial skipped heading levels,
  leaves introductory sections unnumbered, and removes the duplicate synthetic
  appendix divider. It preserves heading identifiers and resolves chapter-only
  `.qmd` links to those identifiers inside the PDF. PNG/SVG figures without an
  explicit size fit within 164mm width and 140mm height, retaining their aspect ratio.
  The introduction's explicit print page break is omitted; its repeat logo is hidden
  with a format condition in `index.qmd` because the cover already supplies branding.
- `fonts/` contains Source Sans 3 and Source Code Pro, under the SIL Open Font
  License 1.1. License texts, immutable upstream URLs and SHA-256 checksums are
  recorded alongside the fonts. `font-paths` makes these available in local and CI
  builds without an additional font installation or font download.

## Reviewing changes

Render all three formats with `quarto render` before changing the pinned Quarto
version or these interfaces. Check the cover, both contents pages, a part divider,
chapter and appendix starts, a page with long code, multi-page reference tables
(including repeated headers), and portrait/landscape screenshots. Check PDF links,
bookmarks, section/figure numbering and page boundaries as well as appearance.
The existing build and offline HTML link checks also need to pass. CI additionally
runs `quarto render --profile pdf-smoke --to typst`. This profile appends `smoke.qmd`
to the book and writes to the ignored `_book-pdf-smoke/` directory. It exercises
referenced notes/warnings, figure/table references, quoted/escaped JSON values and
numbered highlighted code. It does not add test content to the published book.
When reviewing its PDF, check that the referenced note retains its explicit title.

For layout iteration, `quarto render --to typst -M keep-typ:true` retains the generated
`index.typ`; compile it with the bundled `quarto typst compile` command after editing
`misp-book.typ`. Template/filter changes require a fresh Quarto render. Do not commit
the generated Typst source or PDF.

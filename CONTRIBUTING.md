# Contributing to MISP Book

Everyone can help improve the MISP User Guide: report confusing instructions, correct the text, test procedures, contribute use cases, update illustrations, or review a pull request.
You do not need to write code to contribute.

The book's [How to Contribute](contributing/index.qmd) chapter explains these options, browser editing, the local workflow, screenshot and diagram requirements, translations, and attribution.
Use it as the detailed contributor guide; the notes below summarize repository conventions.

## How to make a contribution

- Search [issues](https://github.com/MISP/misp-book/issues) before reporting a problem or starting substantial work.
  Include the affected page and heading, the MISP version/branch where relevant, expected and observed behavior, and shareable reproduction details.
- For a small correction, use **Edit this page** in the book or GitHub's file editor and propose a pull request against `main`.
- For a larger change, fork the repository, create a focused branch, and follow the [local workflow](contributing/index.qmd#contribution-local).
- Explain the reader's problem, your change, and what you checked in the PR.
  Respond to review comments and investigate failed checks.

All changes go through maintainer review before merge.
For application defects or changes to a companion project, use that project's repository and link related documentation work here.

## Source and writing conventions

- Most chapters live in `<chapter>/index.qmd`, with illustrations in `<chapter>/figures/`.
  Register new chapters in `_quarto.yml` and link related material.
- Use American English and English interface examples, consistent with the [book conventions](book-convention/index.qmd).
- Put one sentence per source line where practical, use spaces instead of tabs, and leave blank lines around headings, lists, and code fences.
- Use ATX headings (`## Heading`) and fenced code blocks with a language.
  Preserve heading identifiers and existing link targets when reorganizing a page.
- Use relative `.qmd` links between book pages and established [glossary](glossary.qmd) terminology.
  Link to maintained component or installation documentation rather than duplicating it.
- State the version, branch, role, and configuration relevant to a tested procedure.
  Distinguish observed behavior from an unverified assumption or proposed feature.
- Use sanitized, shareable examples and screenshots; never commit credentials or private records.
  Include meaningful alternative text, captions, and version/provenance details.
- Follow the [diagram guide](assets/diagrams/README.md) for Mermaid sources, the shared theme, generated SVGs, and the manifest.
  Follow the [data model guide](assets/data-model/README.md) for generated reference tables.

## Build and check

See [README.md](README.md#building-locally) for Quarto installation and build instructions.
Use the version pinned in [.github/workflows/quarto.yml](.github/workflows/quarto.yml) when reproducing CI.
Run `quarto render` for HTML/PDF/ePub and `quarto render --profile pdf-smoke --to typst` for the PDF layout checks.
Inspect the affected output, including a narrow browser viewport for new tables or figures.
GitHub Actions also checks internal links and anchors.

Ordinary builds reuse the committed `_freeze/` results and need no live MISP instance or API key.
Only refresh executable examples deliberately, following the [README](README.md#executable-code-chapters), and review the resulting frozen output.
Do not commit generated `_book/` or `_book-pdf-smoke/` output.

## Attribution and community

The guide is dual-licensed under [AGPLv3](https://www.gnu.org/licenses/agpl-3.0.html) and [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
Contribute material you can share under the applicable terms, credit sources, and preserve material-specific notices and licenses.
Follow the MISP project's [code of conduct](https://github.com/MISP/MISP/blob/3.0_wip/code_of_conduct.md).
Use clear [commit messages](https://github.com/MISP/MISP/wiki/CommitMessageBestPractices) and constructive review feedback.

Language corrections are welcome.
Discuss a book translation in an issue to agree on scope and maintenance; application-interface translation is described separately in the [internationalization chapter](translation/index.qmd).

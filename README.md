# MISP Book

[![Build & publish MISP book](https://github.com/MISP/misp-book/actions/workflows/quarto.yml/badge.svg)](https://github.com/MISP/misp-book/actions/workflows/quarto.yml)

Source of the **MISP User Guide** — the official user guide for
[MISP](https://github.com/MISP/MISP), the open source threat intelligence
sharing platform.

Read it online at **<https://www.circl.lu/doc/misp/>** (also available as
[PDF](https://www.circl.lu/doc/misp/book.pdf) and
[EPUB](https://www.circl.lu/doc/misp/book.epub)).

The book is built with [Quarto](https://quarto.org). Each chapter lives in its
own directory as `index.qmd`, in plain Markdown — you can edit any chapter and
open a pull request without installing anything.

## Repository layout

| Path | Purpose |
|---|---|
| `_quarto.yml` | Book definition: metadata, chapter reading order, output formats |
| `index.qmd` | Book landing page (Introduction) |
| `<chapter>/index.qmd` | One directory per chapter (was `README.md` under Honkit) |
| `<chapter>/figures/` | Screenshots and images for that chapter |
| `glossary.qmd` | Glossary (rendered as an appendix) |
| `assets/` | Logo, favicon and `misp.scss` theme |
| `_freeze/` | **Committed** output of executable code cells (keeps CI hermetic) |

## Building locally

1. Install Quarto (single self-contained binary): <https://quarto.org/docs/get-started/>.
2. Render everything:

   ```bash
   quarto render          # writes HTML + PDF + EPUB into _book/
   ```

   Or preview with hot reload while editing:

   ```bash
   quarto preview         # or ./serve.sh
   ```

PDF is produced with Quarto's bundled **Typst** engine — no LaTeX toolchain is
required. HTML and EPUB are native.

## Executable code chapters

Code-heavy chapters (e.g. PyMISP) contain live cells that run against a MISP
instance at render time. Their output is **frozen** into `_freeze/` and
committed, so ordinary contributors and CI render the book offline without a
live instance.

To re-execute those cells against your own instance and refresh the frozen
output:

```bash
export QUARTO_PYTHON=/path/to/venv/bin/python   # env with jupyter + pymisp
export MISP_URL=https://your-misp
export MISP_KEY=your-api-key                    # never commit real keys
rm -rf _freeze/<chapter>                         # drop the stale freeze
quarto render <chapter>/index.qmd
```

Then commit the updated `_freeze/` directory.

## Publishing

`quarto render` produces `_book/`, which is rsynced to the two CIRCL servers.
Maintainers can run [`publish.sh`](publish.sh) locally, or let the
[`quarto.yml`](.github/workflows/quarto.yml) GitHub Actions workflow build and
deploy on push to `main` (deploy requires the `CIRCL_DEPLOY_KEY` and
`CIRCL_KNOWN_HOSTS` repository secrets).

## Contributing

See [How to Contribute](contributing/index.qmd) for ways to help and [CONTRIBUTING.md](CONTRIBUTING.md) for repository conventions.
The MISP user guide is dual-licensed
under [AGPLv3](http://www.gnu.org/licenses/agpl-3.0.html) and
[CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

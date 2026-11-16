# Module inventory maintenance

The chapter includes `_module-reference.qmd`; `modules.csv` supplies the fuller metadata download.
`inventory.json` records the source commit, family counts and source-file hashes.
All 331 production handlers in the reviewed revision are retained as candidates, including case-specific utilities and legacy integrations.
Presence in this inventory is not a runtime test, compatibility guarantee or recommendation to enable every module.

To regenerate from a local checkout, run from the book root:

```sh
python dfir/reference/generate.py /path/to/misp-modules --reviewed-on YYYY-MM-DD
```

The generator statically parses declarations without importing or executing module code.
Four action descriptions are summarized explicitly because their metadata is constructed dynamically.
Dynamic input/requirement declarations may not be captured completely; the handler source is authoritative.
Descriptions in the chapter table are shortened source declarations; the CSV retains their full captured text.

Review changes to the inventory, the curated process guidance and contracts in `../index.qmd` together.
When adopting a new revision, update the chapter's pinned links and rerun the relevant live examples instead of implying that regenerating this list tests the services.
Screenshots use a separately pinned MISP core revision, recorded in `../screenshots.json`.

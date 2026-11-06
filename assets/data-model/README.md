# Data model reference

`categories-and-types/reference/attribute-definitions.json` records public model definitions
from the MISP commit named in its `source` block. Its type/category names, allowed mappings
and defaults were compared with that running checkout's `/attributes/describeTypes` response.
The API does not include the descriptions; those are extracted from the same model.

To refresh, collect `MispAttribute::typeDefinitions` and `categoryDefinitions` from the intended
checkout, compare them with the API, and update the snapshot and source pin. Do not include
instance configuration or credentials. Then run:

```sh
python assets/data-model/generate_reference.py
python assets/data-model/generate_reference.py --check
```

The generated include retains all category/type mappings in portable Markdown. The CSV carries
the complete allowed-category lists as well as defaults/descriptions. Normal builds need no
network, live API, Python package or JavaScript dependency to generate the reference.

`assets/reference-tables.html` progressively enhances `.misp-reference-table` in HTML using
metadata on the type elements. It uses literal search and all allowed categories. The
SCSS handles sticky headers, a bounded scroll region, dark mode, narrow-screen rows and browser
printing. Without JavaScript all rows remain available; PDF/ePub use the committed Markdown.

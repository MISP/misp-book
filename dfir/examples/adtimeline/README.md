# Selected ADTimeline replication metadata

`timeline_selected.csv` is the header and first two data records of the synthetic
fixture [`tests/fixtures/adtimeline/timeline_example.test.csv`](https://github.com/MISP/misp-modules/blob/f4899ad42ac074de672ed32485223badb8680a45/tests/fixtures/adtimeline/timeline_example.test.csv)
from **MISP contributors**, misp-modules commit
`f4899ad42ac074de672ed32485223badb8680a45` (AGPLv3; see the project's
[license](https://github.com/MISP/misp-modules/blob/f4899ad42ac074de672ed32485223badb8680a45/LICENSE)).
The third, altRecipient record was omitted. Retained bytes, including the UTF-8
BOM and CRLF line endings, are unchanged. This fixture has no multiline records;
select records with a real CSV parser when processing arbitrary exports.

The upstream fixture was serialized by PowerShell 7.4.6 with `Export-Csv`, using
ADTimeline's native property order, semicolon delimiter and quoting. Its
[`reproduce.ps1`](https://github.com/MISP/misp-modules/blob/f4899ad42ac074de672ed32485223badb8680a45/tests/fixtures/adtimeline/reproduce.ps1)
and [provenance](https://github.com/MISP/misp-modules/blob/f4899ad42ac074de672ed32485223badb8680a45/tests/fixtures/adtimeline/README.md)
record the exact producer settings and upstream ADTimeline revision. No actual
directory was collected and no production identities are present. The unusual
large USNs deliberately exercise exact text preservation; they are not a real
server history or an anomaly finding.

Reproduce this particular selection from an unmodified misp-modules checkout:

```python
from pathlib import Path

source = Path("tests/fixtures/adtimeline/timeline_example.test.csv").read_bytes()
Path("timeline_selected.csv").write_bytes(b"".join(source.splitlines(keepends=True)[:3]))
```

`module-response.json` is the actual ADTimeline service response for this CSV,
filename `timeline_selected.csv`, `domain_scope=example.test` and
`collection_server=dc02.example.test`. It is a separate run from the native UI
import, with identical object UUIDs because the input and context match. It
includes the exact CSV bytes as base64. All returned attributes have IDS matching
and correlation disabled, and both observations start as unreviewed.

The isolated MISP 3.0_wip import produced a source file and two
`ad-replication-metadata` objects: 53 attributes and two `derived-from` references.
The saved source attachment was downloaded and compared byte-for-byte with the
CSV. Exact USNs, raw/normalized timestamps, record indices, review states and
non-IDS/non-correlating settings were verified. See `provenance.json` and
`../../screenshots.json` for hashes, source/runtime versions and capture details.

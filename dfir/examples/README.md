# Synthetic DFIR evidence exchange

`hayabusa-selected.jsonl` is an authored, fictional Hayabusa-shaped finding.
It was not generated from an EVTX file and does not demonstrate a compromise.
The rule UUID, workstation name, evidence path and account are documentation fixtures.
Its Event ID 4624 and service logon type 5 illustrate a finding that needs context before escalation.

`windows-observations.jsonl` is the actual `timesketch_export` result for the saved MISP documentation event after compact, explicit UTC offsets were normalized in an export-only copy.
It contains two observations: a detection time and the associated Windows event time, both at 2026-11-15T09:20:00Z.
The generated MISP identifiers belong only to that isolated fixture instance.

`export_timeline.py` accepts one selected MISP event JSON file and writes Timesketch JSONL through a running misp-modules service.
It makes no MISP writes and never rewrites the source export.
Only explicit compact offsets on `datetime` attributes are converted to the colon form; unknown `-0000` offsets and timezone-free values remain unresolved.
Choose the input event and destination service according to the case's handling rules.

Versions, input hashes, live verification and screenshot provenance are recorded in `../screenshots.json`.
The module source inventory and reviewed revision are in `../reference/`.

`sleuthkit/` contains a compressed, authored ext2 filesystem and actual Sleuth Kit bodyfile/text/CSV outputs for one selected file.
Its README and provenance record describe the fixed teaching timestamps, image integrity, tool versions and native MISP Mactime import exercise.

`pcap/` contains an authored DNS/HTTP capture, its deterministic generator, actual TShark outputs, the recovered text payload and a pre-review module result.
The chapter follows that capture through native PCAP import, connection analysis and verification of the reconstructed file.

`adtimeline/` contains the selected first two records of the misp-modules project's synthetic, PowerShell-serialized ADTimeline CSV fixture and a real parser response.
The chapter follows native import, source-attachment verification and analysis of an ACL-related last change and a removed member link.
No Active Directory collection or modification took place; source attribution, selection and runtime checks are recorded in that example's README and provenance.

`timeline/` contains a separate authored MISP event for comparing native Seen, Modified and Created views.
Its fictional observation intervals, missing endpoint and undated field demonstrate timeline behavior without changing the forensic import examples.

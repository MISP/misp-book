# Sleuth Kit filesystem timeline example

This is an authored synthetic ext2 filesystem, not an acquired device or a malware sample.
The 4 MiB raw filesystem image is compressed as `filesystem.img.gz` (approximately 4.5 KiB).
It has no partition table; the filesystem starts at byte zero.
Its `/case/notes.txt` file contains harmless text, with explicitly assigned modification, inode-change and access times.
No birth time is supplied by this fixture.

`provenance.json` records the decompressed image hash, tool versions, timestamp meanings and data-file hashes.
`filesystem.img.sha256` is the digest of the decompressed image, not the gzip archive.
`filesystem.body` is the actual recursive `fls` output.
`notes.body` selects only `/case/notes.txt` (inode 13).
`notes-timeline.txt` and `notes-timeline.csv` are actual Sleuth Kit 4.12.1 `mactime` outputs for the explicit 2026-11-16..2026-11-17 UTC window.
The date restriction omits the unknown birth-time placeholder while retaining its zero value in the bodyfile.

Run the commands in the chapter from the book root to reproduce the analysis from the bundled image.
The example uses `LC_ALL=C` and `-z UTC` so its weekday/month labels and displayed times are explicit.
The raw image was created with e2fsprogs 1.47.2 and populated with `debugfs`, without mounting it.
Analysis by `fls`, `icat` and `mactime` does not modify that image.

Use `notes-timeline.txt` with the pinned MISP core **Forensic analysis → Mactime** form.
That UI expects the default human-readable format; the CSV and bodyfiles are provided for comparison and other analysis tools.
Each selected row becomes one `mactime-timeline-analysis` object and receives the entire uploaded timeline as an attachment.
The tested browser form normalizes the original LF line endings to CRLF in that attachment; its bytes and hash therefore differ from the original exported text.
Retain the original output and digest separately in the evidence repository.
The live exercise created three objects with 18 non-IDS attributes and four ordering references in an organization-only, unpublished event.
The chapter explains why `ctime` is not creation time and why the ordering links do not establish causality.

Capture and live MISP verification details are in `../../screenshots.json`.

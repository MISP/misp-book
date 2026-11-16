# Native MISP timeline teaching event

`event-input.json` is an authored standard MISP JSON event, with one file object
and three standalone attributes. All attributes have IDS matching and correlation
disabled. It has no attachments or real collected evidence.

The invented observation times are:

- `updates.example`: 12 November 2026 09:00 through 14 November 09:30 UTC.
- File object / filename: 13 November 10:00 through 14 November 08:00 UTC.
- Path attribute: 13 November 11:00 UTC at both endpoints.
- `203.0.113.25`: 14 November 10:00 UTC, with last seen unset.
- Standalone teaching text: no seen dates.
- File `modification-time` value: 12 November 08:00 UTC, with no seen metadata.

This last field deliberately demonstrates that a datetime-valued attribute is
not automatically placed in the Seen timeline. Object children with no seen
dates are omitted from the Seen expansion; the top-level undated notice is not
a count of every such child field.

The event was created on 16 November 2026 in an isolated MISP 3.0_wip instance,
with organization-only distribution and publication disabled. Its Seen response
had three dated top-level rows, two dated children of the file and one undated
standalone attribute. Modified and Created each had four top-level rows.

The native UI was used to expand the file, filter by its object type, open the
Seen editor and switch bases. A separate editor check changed only the synthetic
IP's first_seen to 10:01 and restored 10:00, preserving the missing last_seen.
The domain editor pictured in the chapter was cancelled. Imported ADTimeline
and PCAP observations were not modified for this exercise.

`provenance.json` records input hashes, API verification, source implementation
hashes and the screenshot checks. A separate view of the ADTimeline fixture
confirms three undated objects under Seen despite its preserved source dates.

Importing `event-input.json` into another MISP instance creates that instance's
creation/modification timestamps; those clocks are intentionally absent from the
fixture and will differ from the screenshots. Preserve the distinction between
the authored observation dates and the time at which this file is imported.

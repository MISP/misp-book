# Geographic examples

`Morning_Walk.gpx` is the user-supplied example, byte-identical to the public
[MISP/misp-modules fixture](https://github.com/MISP/misp-modules/blob/47eb69eab4ab1da6f6464992bd8e470e602ac800/tests/fixtures/gpx/Morning_Walk.gpx).
Credit: the fixture's contributors to MISP/misp-modules; retained under that
repository's [license](https://github.com/MISP/misp-modules/blob/47eb69eab4ab1da6f6464992bd8e470e602ac800/LICENSE).
SHA-256: `77e36202f8bb56cbc31c5bf5cc1ab104841a368c0c9e206853a9110f1b6170a8`.

`Morning_Walk.geojson` is a teaching derivative: a Point for the first observation
and a LineString containing all 606 track positions, with elevation retained.
It does not transfer GPX sensor extensions, segment semantics or all timestamps.
It demonstrates GeoJSON import behavior, rather than a lossless format conversion.
Properties identify the source and first timestamp; GeoJSON import keeps those
properties as text and does not infer MISP datetime relations from them.

The files illustrate representation, not a security incident or attribution.

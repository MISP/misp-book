# Synthetic PCAP import and analysis case

`download-example.pcap` contains 12 authored Ethernet/IPv4 packets, not a live network capture.
The example uses reserved IP addresses and the `updates.example` documentation name.
It includes one DNS query/response and a complete TCP handshake, plaintext HTTP transfer and teardown.
The only reconstructed content is harmless 49-byte text in `notice.txt`.
No generator or analysis step transmits the generated packets or fetches the example URL.

Run the generator from the book root to reproduce the exact PCAP bytes:

```sh
python dfir/examples/pcap/generate_capture.py work/dfir-pcap/regenerated.pcap
cmp dfir/examples/pcap/download-example.pcap work/dfir-pcap/regenerated.pcap
```

The assigned packet window is 2026-11-16T10:00:00Z through 10:00:01.900000Z.
`packet-summary.txt` and `conversations.txt` are actual TShark 4.4.19 outputs, with trailing display padding removed for storage in the repository.
`notice.txt` is the actual HTTP object recovered by the handler and independently by TShark's HTTP exporter.
Hashes, versions and verification details are recorded in `provenance.json` and `../../screenshots.json`.

`module-response.json` is a serialized, otherwise unedited module API result from a separate offline analysis of this capture before the UI import.
It retains the original reference comments and the file template's default IDS settings.
The saved MISP exercise cleared seven file IDS flags through the review UI and contains four objects, ten standalone attributes, 53 total attributes and 29 references.
Join results across runs by capture hash, transport/stream index and payload hash rather than by generated UUIDs.
The pinned MISP import review retains reference targets/types but omits reference comments; keep the source result when those details are needed.

MISP stores the reconstructed file using its sample-packaging convention.
The downloaded encrypted ZIP was unpacked with the normal MISP sample password and its content verified byte-for-byte against `notice.txt`.
The `malware-sample` representation does not establish a malicious verdict.
Capture bounds, flow bounds and payload-completion time are distinct observations, as explained in the chapter.

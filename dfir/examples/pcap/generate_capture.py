#!/usr/bin/env python3
"""Write a synthetic DNS/HTTP PCAP without opening any network connections."""
import argparse
import hashlib
import ipaddress
import struct
from datetime import datetime, timezone
from pathlib import Path

PAYLOAD = b'PCAP documentation fixture. This is not malware.\n'
CLIENT = '192.0.2.10'
SERVER = '198.51.100.20'
RESOLVER = '192.0.2.53'


def checksum(data):
    data += b'\0' * (len(data) % 2)
    total = sum(struct.unpack('!' + 'H' * (len(data) // 2), data))
    while total >> 16:
        total = (total & 65535) + (total >> 16)
    return ~total & 65535


def ethernet_ip(payload, protocol, source, destination, identifier):
    mac = {CLIENT: '020000000010', SERVER: '020000000020', RESOLVER: '020000000053'}
    ethernet = bytes.fromhex(mac[destination] + mac[source]) + b'\x08\x00'
    src, dst = ipaddress.ip_address(source).packed, ipaddress.ip_address(destination).packed
    header = struct.pack('!BBHHHBBH4s4s', 0x45, 0, 20 + len(payload), identifier, 0x4000, 64, protocol, 0, src, dst)
    header = header[:10] + struct.pack('!H', checksum(header)) + header[12:]
    return ethernet + header + payload


def create_capture():
    frames = []

    def udp(payload, source, destination, source_port, destination_port, microseconds):
        header = struct.pack('!HHHH', source_port, destination_port, 8 + len(payload), 0)
        frames.append((microseconds, ethernet_ip(header + payload, 17, source, destination, len(frames) + 1)))

    name = b'\x07updates\x07example\0'
    question = name + struct.pack('!HH', 1, 1)
    query = struct.pack('!HHHHHH', 0x4D49, 0x0100, 1, 0, 0, 0) + question
    answer = struct.pack('!HHHHHH', 0x4D49, 0x8180, 1, 1, 0, 0) + question
    answer += b'\xc0\x0c' + struct.pack('!HHIH', 1, 1, 60, 4) + ipaddress.ip_address(SERVER).packed
    udp(query, CLIENT, RESOLVER, 49153, 53, 0)
    udp(answer, RESOLVER, CLIENT, 53, 49153, 100000)
    sequences = [1000, 5000]
    tcp_index = 0

    def tcp(payload=b'', server=False, flags=0x10):
        nonlocal tcp_index
        side = int(server)
        source, destination = (SERVER, CLIENT) if server else (CLIENT, SERVER)
        ports = (80, 49152) if server else (49152, 80)
        header = struct.pack('!HHIIBBHHH', *ports, sequences[side], sequences[1-side], 0x50, flags, 65535, 0, 0)
        pseudo = ipaddress.ip_address(source).packed + ipaddress.ip_address(destination).packed
        check = checksum(pseudo + struct.pack('!BBH', 0, 6, len(header) + len(payload)) + header + payload)
        header = header[:16] + struct.pack('!H', check) + header[18:]
        frames.append((1000000 + 100000 * tcp_index,
                       ethernet_ip(header + payload, 6, source, destination, len(frames) + 1)))
        sequences[side] += len(payload) + bool(flags & 3)
        tcp_index += 1

    tcp(flags=0x02)
    tcp(server=True, flags=0x12)
    tcp()
    tcp(b'GET /case/notice.txt HTTP/1.1\r\nHost: updates.example\r\n'
        b'User-Agent: MISP-DFIR-Example/1.0\r\nAccept: text/plain\r\nConnection: close\r\n\r\n', flags=0x18)
    response = (b'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: '
                + str(len(PAYLOAD)).encode() + b'\r\nConnection: close\r\n\r\n' + PAYLOAD)
    tcp(response, server=True, flags=0x18)
    tcp()
    tcp(flags=0x11)
    tcp(server=True)
    tcp(server=True, flags=0x11)
    tcp()
    epoch = int(datetime(2026, 11, 16, 10, 0, tzinfo=timezone.utc).timestamp())
    output = bytearray(struct.pack('<IHHIIII', 0xA1B2C3D4, 2, 4, 0, 0, 65535, 1))
    for offset, frame in frames:
        seconds, micros = divmod(offset, 1000000)
        output.extend(struct.pack('<IIII', epoch + seconds, micros, len(frame), len(frame)))
        output.extend(frame)
    return bytes(output)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    data = create_capture()
    args.output.write_bytes(data)
    print(hashlib.sha256(data).hexdigest() + '  ' + str(args.output))


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""Export one selected MISP JSON event through a local/approved module service.

Usage: python export_timeline.py selected-event.json observations.jsonl
Requires requests. MISP_MODULES_URL defaults to http://127.0.0.1:6666.
Only the in-memory export copy is normalized; the input file is never rewritten.
"""
import base64
import json
import os
import re
import sys
from pathlib import Path

import requests


def main():
    if len(sys.argv) != 3:
        raise SystemExit('Usage: export_timeline.py selected-event.json observations.jsonl')
    source, destination = map(Path, sys.argv[1:])
    if source.resolve() == destination.resolve():
        raise SystemExit('Choose a separate output file to preserve the source export.')
    document = json.loads(source.read_text(encoding='utf-8'))
    if not isinstance(document, dict):
        raise SystemExit('Supply one standard MISP Event wrapper or one bare event object.')
    event = document.get('Event', document)
    if not isinstance(event, dict):
        raise SystemExit('The Event value must be an object.')
    attributes = list(event.get('Attribute', []))
    for obj in event.get('Object', []):
        attributes.extend(obj.get('Attribute', []))
    normalized = 0
    for attribute in attributes:
        value = attribute.get('value')
        if (attribute.get('type') == 'datetime' and isinstance(value, str)
                and re.search(r'[+-]\d{4}$', value) and not value.endswith('-0000')):
            attribute['value'] = value[:-2] + ':' + value[-2:]
            normalized += 1
    module_url = os.environ.get('MISP_MODULES_URL', 'http://127.0.0.1:6666').rstrip('/')
    response = requests.post(module_url + '/query', json={
        'module': 'timesketch_export', 'data': {'Event': event},
    }, timeout=60)
    response.raise_for_status()
    result = response.json()
    if result.get('error'):
        raise SystemExit(json.dumps(result, indent=2))
    payload = base64.b64decode(result['data'], validate=True)
    destination.write_bytes(payload)
    print(json.dumps({'normalized_explicit_offsets': normalized,
                      'observations': len(payload.splitlines()),
                      'summary': result.get('summary'),
                      'warnings': result.get('warnings', [])}, indent=2))


if __name__ == '__main__':
    main()

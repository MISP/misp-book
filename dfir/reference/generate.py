"""Snapshot source-declared module metadata without importing or executing handlers."""
import ast
import argparse
import csv
import hashlib
import io
import json
import re
import subprocess
from datetime import date
from collections import Counter
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('upstream', type=Path, help='Local MISP/misp-modules checkout to inventory')
parser.add_argument('--reviewed-on', default=date.today().isoformat(), help='Date of the source review, YYYY-MM-DD')
args = parser.parse_args()
upstream = args.upstream.resolve()
destination = Path(__file__).resolve().parents[1]
reference = destination / 'reference'
reference.mkdir(exist_ok=True)
commit = subprocess.check_output(['git', '-C', str(upstream), 'rev-parse', 'HEAD'], text=True).strip()
base = f'https://github.com/MISP/misp-modules/blob/{commit}/'
excluded = {'import_blueprint', 'testimport', 'testexport', 'testaction'}
families = {'import_mod': 'Import', 'expansion': 'Expansion', 'export_mod': 'Export', 'action_mod': 'Action'}

def value(node):
    try:
        return ast.literal_eval(node)
    except (ValueError, TypeError):
        if isinstance(node, ast.BinOp) and isinstance(node.op, ast.Add):
            left, right = value(node.left), value(node.right)
            if type(left) is type(right) and isinstance(left, (str, list, tuple)):
                return left + right
        if isinstance(node, ast.Dict):
            return {value(k): value(v) for k, v in zip(node.keys, node.values) if k is not None}
        return None

overrides = {
    'n8n_webhook': 'Deliver selected MISP data to a configured n8n webhook, with a preview option.',
    'shuffle_workflow_execute': 'Submit selected MISP data to an explicitly identified Shuffle workflow.',
    'tines_case_create': 'Create a Tines case in an explicitly identified team, or preview the request.',
    'torq_case_create': 'Create a Torq case with explicit reporter and severity, or preview the request.',
}
rows = []
for family in families:
    for source in sorted((upstream / 'misp_modules/modules' / family).glob('*.py')):
        if source.stem.startswith('_') or source.stem in excluded:
            continue
        tree = ast.parse(source.read_text())
        metadata = {}
        for node in tree.body:
            if isinstance(node, ast.Assign):
                for target in node.targets:
                    if isinstance(target, ast.Name) and target.id in {'moduleinfo', 'mispattributes', 'moduleconfig'}:
                        metadata[target.id] = value(node.value)
        info = metadata.get('moduleinfo') or {}
        attributes = metadata.get('mispattributes') or {}
        description = info.get('description') or overrides.get(source.stem) or ast.get_docstring(tree)
        if not description:
            raise ValueError(f'Missing purpose for {source}')
        description = re.sub(r'\s+', ' ', description).strip()
        row = {
            'family': families[family], 'module': source.stem,
            'name': info.get('name') or source.stem,
            'description': description,
            'declared_inputs': attributes.get('input') or attributes.get('inputSource') or info.get('input') or [],
            'declared_outputs': attributes.get('output') or info.get('output') or [],
            'requirements': info.get('requirements') or [],
            'configuration': metadata.get('moduleconfig') or [],
            'declared_data_source': info.get('data-source') or 'not declared',
            'source': str(source.relative_to(upstream)),
            'source_url': base + str(source.relative_to(upstream)),
            'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
        }
        rows.append(row)

output = io.StringIO()
writer = csv.DictWriter(output, fieldnames=rows[0].keys(), lineterminator='\n')
writer.writeheader()
for row in rows:
    writer.writerow({k: json.dumps(v, ensure_ascii=False) if isinstance(v, (dict, list)) else v for k, v in row.items()})
(reference / 'modules.csv').write_text(output.getvalue())
counts = dict(Counter(row['family'] for row in rows))
audit = {
    'repository': 'https://github.com/MISP/misp-modules', 'commit': commit,
    'reviewed_on': args.reviewed_on, 'total': len(rows), 'families': counts,
    'scope': 'Every production .py handler directly in expansion, import_mod, export_mod and action_mod; underscore-prefixed helpers and non-.py skeletons excluded.',
    'excluded_handlers': sorted(excluded),
    'method': 'Static AST extraction of source-declared metadata without executing handlers. Four dynamic action descriptions are manually summarized from the handler contract. Inputs/requirements may be incomplete when declarations are dynamic; follow the linked source. Source presence does not establish installed dependencies, compatibility, provider availability or organization enablement.',
    'csv_sha256': hashlib.sha256((reference / 'modules.csv').read_bytes()).hexdigest(),
    'modules': [{'family': r['family'], 'module': r['module'], 'source': r['source'], 'sha256': r['source_sha256']} for r in rows],
}
(reference / 'inventory.json').write_text(json.dumps(audit, indent=2) + '\n')

lines = ['<!-- Generated from the source snapshot recorded in reference/inventory.json. -->', '']
for label in families.values():
    members = [row for row in rows if row['family'] == label]
    lines += [f'### {label} modules ({len(members)}) {{#dfir-inventory-{label.lower()}}}', '',
              '::: {.table-responsive}', '', '| Module | Declared purpose |', '|---|---|']
    for row in members:
        description = row['description']
        if len(description) > 240:
            sentences = re.split(r'(?<=[.!?])\s+', description)
            first = sentences[0]
            description = first if len(first) <= 240 else description[:237].rsplit(' ', 1)[0] + '…'
        # Render source metadata as plain table prose, avoiding accidental Markdown/HTML.
        description = re.sub(r'<[^>]+>', '', description).replace('|', '\\|').replace('`', '').replace('*', '')
        lines.append(f'| [`{row["module"]}`]({row["source_url"]}) | {description} |')
    lines += ['', ':::', '']
(destination / '_module-reference.qmd').write_text('\n'.join(lines))
print(json.dumps({'total': len(rows), 'families': counts, 'commit': commit}))

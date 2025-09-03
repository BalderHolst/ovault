#!/usr/bin/env python3
import os
import subprocess
import pdoc

from os.path import join

ROOT = subprocess.run(
        ['git', 'rev-parse', '--show-toplevel'],
        check=True, capture_output=True, text=True
        ).stdout.strip()

DOCS_DIR = join(ROOT, 'docs')
OUTPUT_DIR = join(DOCS_DIR, 'html')

def run_txtx():
    res = subprocess.run([f'{ROOT}/scripts/txtx.py', f'{DOCS_DIR}/documentation.mdx'],
                   capture_output=True,
                   text=True)
    if res.returncode != 0:
        print("Error running txtx.py:")
        print(res.stderr)
        exit(1)

    with open(join(DOCS_DIR, 'documentation.md'), 'w') as f:
        f.write(res.stdout)


def build_package():
    subprocess.run(['maturin', 'develop', '--release', '--features', 'python'], cwd=ROOT, check=True)

def document():
    import ovault
    ctx = pdoc.Context()
    mod = pdoc.Module(ovault, context=ctx)

    # Don't document internal module `ovault.ovault`
    def filter(obj):
        if isinstance(obj, pdoc.Module) and obj.name == 'ovault.ovault':
            return False
        return True

    doc = pdoc.html(mod, docfilter=filter)

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    with open(os.path.join(OUTPUT_DIR, 'index.html'), 'w') as f:
        f.write(doc)

    print(f'Documentation generated in {OUTPUT_DIR}/index.html')


if __name__ == '__main__':
    run_txtx()
    build_package()
    document()

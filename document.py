#!/usr/bin/env python3
import os
import subprocess
import pdoc

OUTPUT_DIR = 'docs'

def build_package():
    subprocess.run(['maturin', 'develop', '--release', '--features', 'python'], check=True)

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
    build_package()
    document()

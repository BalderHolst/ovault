"""
Show a list of all utility modules included in `ovault`.
"""

from pathlib import Path
import importlib

BLUE = "\033[94m"
RESET = "\033[0m"

def main():

    dir = Path(__file__).parent
    modules = []
    for file in dir.iterdir():
        if file.suffix != ".py": continue
        if file.name == "__init__.py": continue
        if file.name == "__main__.py": continue
        module_name = file.stem
        module = importlib.import_module(f".{module_name}", package=__package__)
        modules.append((module_name, module.__doc__))

    max_len = max(len(name) for name, _ in modules)

    print(
        "OVault provies a few utilties out of the box.\n\n"
        "You can run them like so: `python3 -m ovault.<module>`\n"
    )

    print("Available modules:")

    for mod, doc in modules:
        doc = doc.strip().split("\n")[0] if doc else "No description."
        print(f"    {BLUE}ovault.{mod:{max_len}}{RESET} : {doc}")

if __name__ == "__main__":
    main()

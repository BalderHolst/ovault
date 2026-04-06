# For inspecting the actual module
import inspect
import ovault

# For inspecting the stub file
import ast

STUBFILE = "./ovault.pyi"

from dataclasses import dataclass, field

@dataclass
class Arg:
    name: str
    annotation: str | None

    def __hash__(self) -> int:
        return hash(self.name) + hash(self.annotation)

@dataclass
class Function:
    name: str
    args: list[Arg]

    def __hash__(self) -> int:
        h = hash(self.name)
        for arg in self.args:
            h += hash(arg)
        return h

@dataclass
class Class:
    name: str

    def __hash__(self) -> int:
        return hash(self.name)

@dataclass
class Module:
    objs: list[Function | Class] = field(default_factory=list)

    def purge_private_definitions(self):
        self.objs = [f for f in self.objs if not f.name.startswith("_")]

    def to_set(self) -> set:
        return set(self.objs)

def error(msg):
    print(msg) 
    exit(1)

def inspect_stub() -> Module:
    m = Module()

    with open(STUBFILE) as f:
        src = f.read()

    tree = ast.parse(src, filename=STUBFILE)

    for item in tree.body:
        match item:
            case ast.FunctionDef():
                args = []

                for arg in item.args.args:
                    args.append(Arg(
                        name=arg.arg,
                        annotation=arg.annotation.id))

                m.objs.append(Function(name=item.name, args=args))

            case ast.ClassDef():
                m.objs.append(Class(name=item.name))

            case ast.Assign():
                pass

            case ast.AnnAssign():
                pass

            case ast.Expr():
                pass

            case ast.ImportFrom():
                pass

            case other:
                error(f"{STUBFILE}:{other.lineno}: ERROR: Unexpected item type '{type(other)}': {ast.dump(other)}")

    return m


def inspect_module() -> Module:
    m = Module()

    for name, item in inspect.getmembers(ovault):

        # Functions
        if inspect.isfunction(item) or inspect.isbuiltin(item):
            sig = inspect.signature(item)
            args = []

            for k, v in sig.parameters.items():
                annotation = None
                if v.annotation.__name__ != "_empty":
                    annotation = v.annotation.__name__
                args.append(Arg(name=k, annotation=annotation))

            func = Function(name=name, args=args)
            m.objs.append(func)

        # Classes
        elif isinstance(item, type):
            m.objs.append(Class(name=name))

    return m


if __name__ == "__main__":
    stub_module = inspect_stub()
    real_module = inspect_module()

    stub_module.purge_private_definitions()
    real_module.purge_private_definitions()

    stub_set = stub_module.to_set()
    real_set = real_module.to_set()

    stub_only = stub_set - real_set
    real_only = real_set - stub_set

    fail = False

    if len(stub_only):
        fail = True
        print("Module does not define members defined in stub file:")
        for item in stub_only:
            print(f"- {item}")
        print()

    if len(real_only):
        fail = True
        print("Stub file does not define members defined in the module:")
        for item in real_only:
            print(f"- {item}")
        print()

    if fail: exit(1)

    print("Success!")


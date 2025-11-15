import os

class HtmlWriter:
    content: str
    level: int

    def __init__(self) -> None:
        self.content = ""
        self.level = 0

    def write_line(self, line: str, indent=False, dedent=False) -> None:
        line = line.removesuffix('\n')
        if dedent: self.dedent()
        self.content += "    " * self.level + line + "\n"
        if indent: self.indent()

    def indent(self) -> None:
        self.level += 1

    def dedent(self) -> None:
        self.level -= 1
        if self.level < 0:
            self.level = 0

    def save_to_file(self, path: str) -> None:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(self.content)

def h(level: int, heading: str) -> str:
    return f'<h{level}>{heading}</h{level}>'

def a(href: str, text: str) -> str:
    return f'<a href="{href}">{text}</a>'

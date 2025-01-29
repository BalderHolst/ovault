from typing import Any, Dict

class Note:
    vault_path: str
    path: str
    name: str
    tags: list[str]
    links: list[str]
    backlinks: list[str]

class Attachment:
    path: str

class Vault:
    path: str
    dangling_links: Dict[str, Any]

    def __init__(self, path: str) -> None: ...

    def notes(self) -> list[Note]: ...
    def attachments(self) -> list[Attachment]: ...
    def tags(self) -> list[str]: ...
    def index(self) -> None: ...

    def get_notes_by_name(self, name: str) -> list[Note]: ...
    def get_notes_by_tag(self, tag: str) -> list[Note]: ...

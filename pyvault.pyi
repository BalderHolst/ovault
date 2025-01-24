
class Note: pass
class Attachment: pass

class Vault:
    path: str

    def __init__(path: str) -> None: ...

    def notes(self) -> list[Note]: ...
    def attachments(self) -> list[Attachment]: ...

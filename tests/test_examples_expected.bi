:i count 41
:b shell 61
python3 examples/1_overview.py "test-vaults/Obsidian Sandbox"
:i returncode 0
:b stdout 100

path        : test-vaults/Obsidian Sandbox
notes       : 31
attachments : 0
tags        : ['tags']

:b shell 66
python3 examples/1_overview.py "test-vaults/BalderHolst_uni-notes"
:i returncode 0
:b stdout 731

path        : test-vaults/BalderHolst_uni-notes
notes       : 509
attachments : 365
tags        : ['TCP', 'ai', 'algorithms', 'approximation', 'c', 'computerarchitecture', 'controlsystems', 'cpp', 'datacommunication', 'differentialer', 'differentialligninger', 'distribution', 'elektronik', 'embedded', 'excalidraw', 'filter', 'forstærker', 'funktionafflerevariable', 'funktioner', 'fysik', 'integraler', 'intelligent', 'kinematics', 'komponent', 'linearalgebra', 'linux', 'matematik', 'matricer', 'microcontrolers', 'multivariablemath', 'notag', 'numerical', 'partialdiffequations', 'python', 'signalprocessing', 'signals', 'softwaredevelopment', 'sorting', 'statistics', 'subject', 'underactuated', 'vectorfields', 'vektorer']

:b shell 57
python3 examples/1_overview.py "test-vaults/simple_vault"
:i returncode 0
:b stdout 162

path        : test-vaults/simple_vault
notes       : 10
attachments : 0
tags        : ['callout4youtag', 'frontmatter-tag1', 'frontmatter-tag2', 'linksaregood']

:b shell 73
python3 examples/1_overview.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 0
:b stdout 141

path        : test-vaults/SoRobby_ObsidianStarterVault
notes       : 99
attachments : 44
tags        : ['dashboard', 'excalidraw', 'notes']

:b shell 62
python3 examples/1_overview.py "test-vaults/TheJoboReal_Noter"
:i returncode 0
:b stdout 495

path        : test-vaults/TheJoboReal_Noter
notes       : 874
attachments : 2207
tags        : ['Arbejde', 'ArcCos', 'ArcSin', 'ArcTan', 'Centripidalkraften', 'Faseforskydning', 'Fjeder', 'Friktion', 'Heap', 'Hooks', 'Inverterende', 'Lavplasfilter', 'Masseinertimoment', 'Parrallel', 'Phasor', 'SharedMemory', 'Split', 'Stacks', 'Terminalhastighed', 'algorithms', 'assignment', 'course', 'define', 'effekt', 'excalidraw', 'exercise', 'ikke', 'lecture-note', 'lecture-slide', 'semester', 'uni']

:b shell 66
python3 examples/2_find_tag.py "test-vaults/Obsidian Sandbox" math
:i returncode 0
:b stdout 68

Searching for notes with tag: math
No notes found with tag 'math'.

:b shell 71
python3 examples/2_find_tag.py "test-vaults/BalderHolst_uni-notes" math
:i returncode 0
:b stdout 68

Searching for notes with tag: math
No notes found with tag 'math'.

:b shell 62
python3 examples/2_find_tag.py "test-vaults/simple_vault" math
:i returncode 0
:b stdout 68

Searching for notes with tag: math
No notes found with tag 'math'.

:b shell 78
python3 examples/2_find_tag.py "test-vaults/SoRobby_ObsidianStarterVault" math
:i returncode 0
:b stdout 68

Searching for notes with tag: math
No notes found with tag 'math'.

:b shell 67
python3 examples/2_find_tag.py "test-vaults/TheJoboReal_Noter" math
:i returncode 0
:b stdout 68

Searching for notes with tag: math
No notes found with tag 'math'.

:b shell 71
python3 examples/2_find_tag.py "test-vaults/Obsidian Sandbox" matematik
:i returncode 0
:b stdout 78

Searching for notes with tag: matematik
No notes found with tag 'matematik'.

:b shell 76
python3 examples/2_find_tag.py "test-vaults/BalderHolst_uni-notes" matematik
:i returncode 1
:b stdout 41

Searching for notes with tag: matematik

:b shell 67
python3 examples/2_find_tag.py "test-vaults/simple_vault" matematik
:i returncode 0
:b stdout 78

Searching for notes with tag: matematik
No notes found with tag 'matematik'.

:b shell 83
python3 examples/2_find_tag.py "test-vaults/SoRobby_ObsidianStarterVault" matematik
:i returncode 0
:b stdout 78

Searching for notes with tag: matematik
No notes found with tag 'matematik'.

:b shell 72
python3 examples/2_find_tag.py "test-vaults/TheJoboReal_Noter" matematik
:i returncode 0
:b stdout 78

Searching for notes with tag: matematik
No notes found with tag 'matematik'.

:b shell 74
python3 examples/2_find_tag.py "test-vaults/Obsidian Sandbox" frontmatter1
:i returncode 0
:b stdout 84

Searching for notes with tag: frontmatter1
No notes found with tag 'frontmatter1'.

:b shell 79
python3 examples/2_find_tag.py "test-vaults/BalderHolst_uni-notes" frontmatter1
:i returncode 0
:b stdout 84

Searching for notes with tag: frontmatter1
No notes found with tag 'frontmatter1'.

:b shell 70
python3 examples/2_find_tag.py "test-vaults/simple_vault" frontmatter1
:i returncode 0
:b stdout 84

Searching for notes with tag: frontmatter1
No notes found with tag 'frontmatter1'.

:b shell 86
python3 examples/2_find_tag.py "test-vaults/SoRobby_ObsidianStarterVault" frontmatter1
:i returncode 0
:b stdout 84

Searching for notes with tag: frontmatter1
No notes found with tag 'frontmatter1'.

:b shell 75
python3 examples/2_find_tag.py "test-vaults/TheJoboReal_Noter" frontmatter1
:i returncode 0
:b stdout 84

Searching for notes with tag: frontmatter1
No notes found with tag 'frontmatter1'.

:b shell 35
python3 examples/3_find_headings.py
:i returncode 0
:b stdout 146
Found heading: I’m interested in Obsidian at level 2
Found heading: Official Help Site at level 2
Found heading: What is this place? at level 2

:b shell 71
python3 examples/4_check_external_links.py test-vaults/Obsidian Sandbox
:i returncode 1
:b stdout 53
Usage: python 4_check_external_links.py <vault_path>

:b shell 67
python3 examples/4_check_external_links.py test-vaults/simple_vault
:i returncode 0
:b stdout 30
All external links are valid!

:b shell 64
python3 examples/5_graph_image.py "test-vaults/Obsidian Sandbox"
:i returncode 1
:b stdout 0

:b shell 69
python3 examples/5_graph_image.py "test-vaults/BalderHolst_uni-notes"
:i returncode 1
:b stdout 0

:b shell 60
python3 examples/5_graph_image.py "test-vaults/simple_vault"
:i returncode 1
:b stdout 0

:b shell 76
python3 examples/5_graph_image.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 1
:b stdout 0

:b shell 65
python3 examples/5_graph_image.py "test-vaults/TheJoboReal_Noter"
:i returncode 1
:b stdout 0

:b shell 74
python3 examples/6_create_vault.py tmp_test_vault && rm -rf tmp_test_vault
:i returncode 0
:b stdout 921
Getting manual pages for utilities...
    Getting 'cat'
    Getting 'chmod'
    Getting 'clear'
    Getting 'cp'
    Getting 'curl'
    Getting 'date'
    Getting 'df'
    Getting 'du'
    Getting 'echo'
    Getting 'exit'
    Getting 'free'
    Getting 'grep'
    Getting 'gzip'
    Getting 'id'
    Getting 'kill'
    Getting 'less'
    Getting 'ls'
    Getting 'man'
    Getting 'mkdir'
    Getting 'more'
    Getting 'mount'
    Getting 'mv'
    Getting 'nano'
    Getting 'passwd'
    Getting 'ping'
    Getting 'ps'
    Getting 'pwd'
    Getting 'reboot'
    Getting 'rm'
    Getting 'ssh'
    Getting 'su'
    Getting 'sudo'
    Getting 'tar'
    Getting 'top'
    Getting 'touch'
    Getting 'uname'
    Getting 'wget'
    Getting 'zip'
Extracting descriptions from manual pages...
Creating notes...
Re-indexing vault...

Vault created successfully at '/home/balder/projects/ovault/tmp_test_vault' with 39 notes!

:b shell 77
python3 examples/7_rename_note.py test-vaults/simle_vault first_note    FIRST
:i returncode 1
:b stdout 0

:b shell 80
python3 examples/7_rename_note.py test-vaults/simle_vault first_note.md FIRST.md
:i returncode 1
:b stdout 0

:b shell 68
python3 examples/8_add_frontmatter.py "test-vaults/Obsidian Sandbox"
:i returncode 1
:b stdout 0

:b shell 73
python3 examples/8_add_frontmatter.py "test-vaults/BalderHolst_uni-notes"
:i returncode 1
:b stdout 0

:b shell 64
python3 examples/8_add_frontmatter.py "test-vaults/simple_vault"
:i returncode 1
:b stdout 0

:b shell 80
python3 examples/8_add_frontmatter.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 1
:b stdout 0

:b shell 69
python3 examples/8_add_frontmatter.py "test-vaults/TheJoboReal_Noter"
:i returncode 1
:b stdout 0

:b shell 62
python3 examples/9_formatter.py "test-vaults/Obsidian Sandbox"
:i returncode 1
:b stdout 99
Formatting note: test-vaults/Obsidian Sandbox
ERROR: 'test-vaults/Obsidian Sandbox' is not a file.

:b shell 67
python3 examples/9_formatter.py "test-vaults/BalderHolst_uni-notes"
:i returncode 1
:b stdout 109
Formatting note: test-vaults/BalderHolst_uni-notes
ERROR: 'test-vaults/BalderHolst_uni-notes' is not a file.

:b shell 58
python3 examples/9_formatter.py "test-vaults/simple_vault"
:i returncode 1
:b stdout 91
Formatting note: test-vaults/simple_vault
ERROR: 'test-vaults/simple_vault' is not a file.

:b shell 74
python3 examples/9_formatter.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 1
:b stdout 123
Formatting note: test-vaults/SoRobby_ObsidianStarterVault
ERROR: 'test-vaults/SoRobby_ObsidianStarterVault' is not a file.

:b shell 63
python3 examples/9_formatter.py "test-vaults/TheJoboReal_Noter"
:i returncode 1
:b stdout 101
Formatting note: test-vaults/TheJoboReal_Noter
ERROR: 'test-vaults/TheJoboReal_Noter' is not a file.


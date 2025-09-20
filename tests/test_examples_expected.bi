:i count 40
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
attachments : 377
tags        : ['TCP', 'ai', 'algorithms', 'approximation', 'c', 'computerarchitecture', 'controlsystems', 'cpp', 'datacommunication', 'differentialer', 'differentialligninger', 'distribution', 'elektronik', 'embedded', 'excalidraw', 'filter', 'forstærker', 'funktionafflerevariable', 'funktioner', 'fysik', 'integraler', 'intelligent', 'kinematics', 'komponent', 'linearalgebra', 'linux', 'matematik', 'matricer', 'microcontrolers', 'multivariablemath', 'notag', 'numerical', 'partialdiffequations', 'python', 'signalprocessing', 'signals', 'softwaredevelopment', 'sorting', 'statistics', 'subject', 'underactuated', 'vectorfields', 'vektorer']

:b shell 57
python3 examples/1_overview.py "test-vaults/simple_vault"
:i returncode 0
:b stdout 162

path        : test-vaults/simple_vault
notes       : 11
attachments : 3
tags        : ['callout4youtag', 'frontmatter-tag1', 'frontmatter-tag2', 'linksaregood']

:b shell 73
python3 examples/1_overview.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 0
:b stdout 142

path        : test-vaults/SoRobby_ObsidianStarterVault
notes       : 101
attachments : 27
tags        : ['dashboard', 'excalidraw', 'notes']

:b shell 62
python3 examples/1_overview.py "test-vaults/TheJoboReal_Noter"
:i returncode 0
:b stdout 495

path        : test-vaults/TheJoboReal_Noter
notes       : 971
attachments : 2261
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
:i returncode 0
:b stdout 5086

Searching for notes with tag: matematik
    Andengradspolynomier (1924 characters)
    Andenordens inhomogene differentialligninger (819 characters)
    Andenordensdifferentialligninger (677 characters)
    Antisymetrisk (185 characters)
    Approximation (180 characters)
    Arc Length (297 characters)
    At Gøre Prøve (829 characters)
    Bevis for 2. Løsningsformel (3204 characters)
    Bevis for Parameterfremstilling (646 characters)
    Bevis for den Gennerelle Løsningsformel til Linære Førsteordensdifferentialligninger (1322 characters)
    Beviser (1715 characters)
    Circles (155 characters)
    Cirklens Ligning (735 characters)
    Classification of Second order PDEs (695 characters)
    Cylindrical Coordinates (827 characters)
    Den retningsafledte (233 characters)
    Det Komplekse Plan (205 characters)
    Determinanen for Matricer (2828 characters)
    Diagonalmatrix (287 characters)
    Differential Equations (340 characters)
    Differentialregning - Basis (1433 characters)
    Differentialregning Regneregler (345 characters)
    Differentialregning (122 characters)
    Differentiation af funktioner med to variable (2564 characters)
    Dirac Delta Function (395 characters)
    Dæmpede Svingninger - Differentialligning 1 (1216 characters)
    Dæmpede Svingninger - Differentialligning (1204 characters)
    Eigen values and vectors (1262 characters)
    Eksponentielle Funktioner (561 characters)
    En-en-tydig Funktion (359 characters)
    Eulers Formel (164 characters)
    Fordoblings- og halveringkonstant (472 characters)
    Fourier-transformation (639 characters)
    Fourieseries (1000 characters)
    Frequency Response (124 characters)
    Fuldstændig og partikulær løsning (633 characters)
    Funktioner af flere Variable (3063 characters)
    Førsteordensdifferentialligninger (1205 characters)
    Gradient (409 characters)
    Grænser (633 characters)
    Halveringtid (383 characters)
    Harmoniske svingninger (2249 characters)
    Homogeneous Functions (196 characters)
    Hældningsfelt (351 characters)
    Identity Matrix (414 characters)
    Indre og Ydre Produkt (708 characters)
    Integral Table (13925 characters)
    Integraler Regneregler (228 characters)
    Integraler (192 characters)
    Integralregning - Basis (2645 characters)
    Integration med Substidution (799 characters)
    Inverse Matrix (1561 characters)
    Koblede Førsteordensdifferentialligninger (925 characters)
    Komplekse Tal (7826 characters)
    Koordinatsystem og Flader (704 characters)
    Kvadratkomplettering (256 characters)
    Laplace Transformation (1062 characters)
    Laplace's Equation (141 characters)
    Law of Cosines (260 characters)
    Ligninssystemer Uden Løsninger (749 characters)
    Linarisering (2666 characters)
    Line Integrals (785 characters)
    Linear Systems (450 characters)
    Linære Funktioner (295 characters)
    Linære førsteordensdifferentialligninger (7081 characters)
    Linært Afhængige Vektorer (625 characters)
    Logaritmer (555 characters)
    Logistisk vækst (2742 characters)
    Matricer - Regneregler (428 characters)
    Matrix (1752 characters)
    Middelværdisætningen (295 characters)
    Monotoniforhold (429 characters)
    Multivariable Math (276 characters)
    Newtons Afkølingslov (1849 characters)
    Niveaukurver (297 characters)
    Normal form of a PDE (4232 characters)
    Normalfordelingen (1092 characters)
    Omdrejningslegne (387 characters)
    Omvendt funktion (1318 characters)
    Partial Differential Equations (1013 characters)
    Partialbrøker (2341 characters)
    Partiel Integration (346 characters)
    Periodic Signal Analysis (72 characters)
    Planer (609 characters)
    Poisson's Equation (187 characters)
    Polar Coordinates (604 characters)
    Positive definite matrix (88 characters)
    Positive semi-definite matrix (94 characters)
    Potensregneregler (65 characters)
    QQ-plot (353 characters)
    Rank of Matrix (429 characters)
    Rationelle Funktioner (294 characters)
    Riemann Sum (310 characters)
    Rotational Matrices (1155 characters)
    Row Echelon Form (1041 characters)
    Række og Søjle vektorer (313 characters)
    Sekant (695 characters)
    Seperation of Variables (1012 characters)
    Små Integrationsbeviser (1594 characters)
    Snitkurver (404 characters)
    Spherical Coordinates (897 characters)
    Stationære punkter (566 characters)
    Surface Integrals (1587 characters)
    Symetric Matrices (192 characters)
    System of Linear Equations (2414 characters)
    Tangent Plane (1071 characters)
    Tangent (301 characters)
    Tangentplan (618 characters)
    Taylorpolynomium (2122 characters)
    The Heat Equation (535 characters)
    The Wave Equation (274 characters)
    Tretrinsraketten (1204 characters)
    Trigonometri (2236 characters)
    Triple Integrals (75 characters)
    Uegenlige Integraler (631 characters)
    Ulige Funktioner (116 characters)
    Vectors (2201 characters)
    Vektorfunktioner (66 characters)
    n-Space (403 characters)

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

:b shell 78
python3 examples/2_find_tag.py "test-vaults/Obsidian Sandbox" frontmatter-tag1
:i returncode 0
:b stdout 92

Searching for notes with tag: frontmatter-tag1
No notes found with tag 'frontmatter-tag1'.

:b shell 83
python3 examples/2_find_tag.py "test-vaults/BalderHolst_uni-notes" frontmatter-tag1
:i returncode 0
:b stdout 92

Searching for notes with tag: frontmatter-tag1
No notes found with tag 'frontmatter-tag1'.

:b shell 74
python3 examples/2_find_tag.py "test-vaults/simple_vault" frontmatter-tag1
:i returncode 0
:b stdout 81

Searching for notes with tag: frontmatter-tag1
    frontmatter (172 characters)

:b shell 90
python3 examples/2_find_tag.py "test-vaults/SoRobby_ObsidianStarterVault" frontmatter-tag1
:i returncode 0
:b stdout 92

Searching for notes with tag: frontmatter-tag1
No notes found with tag 'frontmatter-tag1'.

:b shell 79
python3 examples/2_find_tag.py "test-vaults/TheJoboReal_Noter" frontmatter-tag1
:i returncode 0
:b stdout 92

Searching for notes with tag: frontmatter-tag1
No notes found with tag 'frontmatter-tag1'.

:b shell 35
python3 examples/3_find_headings.py
:i returncode 0
:b stdout 146
Found heading: I’m interested in Obsidian at level 2
Found heading: Official Help Site at level 2
Found heading: What is this place? at level 2

:b shell 64
python3 examples/4_graph_image.py "test-vaults/Obsidian Sandbox"
:i returncode 0
:b stdout 2685
digraph {
    overlap=false;
    node [shape=box, style=filled, fillcolor="#0099FF25"];
    edge [color="#00000090"];

    "0adventurer/from-plain-text-note-taking" [label="adventurer/from-plain-text-note-taking"]
    "1adventurer/from-standard-note-taking" [label="adventurer/from-standard-note-taking"]
    "2adventurer/no-prior-experience" [label="adventurer/no-prior-experience"]
    "3formatting/blockquote" [label="formatting/blockquote"]
    "4formatting/callout" [label="formatting/callout"]
    "5formatting/code-block" [label="formatting/code-block"]
    "6formatting/comment" [label="formatting/comment"]
    "7formatting/diagram" [label="formatting/diagram"]
    "8formatting/embeds" [label="formatting/embeds"]
    "9formatting/emphasis" [label="formatting/emphasis"]
    "10formatting/footnote" [label="formatting/footnote"]
    "11formatting/format-your-notes" [label="formatting/format-your-notes"]
    "12formatting/heading" [label="formatting/heading"]
    "13formatting/highlighting" [label="formatting/highlighting"]
    "14formatting/horizontal-divider" [label="formatting/horizontal-divider"]
    "15formatting/images" [label="formatting/images"]
    "16formatting/inline-code" [label="formatting/inline-code"]
    "17formatting/internal-link" [label="formatting/internal-link"]
    "18formatting/links" [label="formatting/links"]
    "19formatting/lists" [label="formatting/lists"]
    "20formatting/math" [label="formatting/math"]
    "21formatting/strikethrough" [label="formatting/strikethrough"]
    "22formatting/table" [label="formatting/table"]
    "23formatting/task" [label="formatting/task"]
    "24guides/create-a-vault" [label="guides/create-a-vault"]
    "25guides/create-your-first-note" [label="guides/create-your-first-note"]
    "26guides/get-started-with-obsidian" [label="guides/get-started-with-obsidian"]
    "27guides/link-notes" [label="guides/link-notes"]
    "28plugins-make-obsidian-special-for-you" [label="plugins-make-obsidian-special-for-you"]
    "29start-here" [label="start-here"]
    "30vault-is-just-a-local-folder" [label="vault-is-just-a-local-folder"]

    "0adventurer/from-plain-text-note-taking" -> "28plugins-make-obsidian-special-for-you"
    "0adventurer/from-plain-text-note-taking" -> "30vault-is-just-a-local-folder"
    "1adventurer/from-standard-note-taking" -> "28plugins-make-obsidian-special-for-you"
    "1adventurer/from-standard-note-taking" -> "30vault-is-just-a-local-folder"
    "2adventurer/no-prior-experience" -> "28plugins-make-obsidian-special-for-you"
    "2adventurer/no-prior-experience" -> "30vault-is-just-a-local-folder"
    "8formatting/embeds" -> "28plugins-make-obsidian-special-for-you"
}

:b shell 69
python3 examples/4_graph_image.py "test-vaults/BalderHolst_uni-notes"
:i returncode 0
:b stdout 34607
digraph {
    overlap=false;
    node [shape=box, style=filled, fillcolor="#0099FF25"];
    edge [color="#00000090"];

    "0excalidraw/drawing-2022-11-17-12.34.37.excalidraw" [label="excalidraw/drawing-2022-11-17-12.34.37.excalidraw"]
    "1excalidraw/truth-table-to-mux" [label="excalidraw/truth-table-to-mux"]
    "2excalidraw/fysik-pa" [label="excalidraw/fysik-pa"]
    "3home" [label="home"]
    "4notes/ac" [label="notes/ac"]
    "5notes/adc" [label="notes/adc"]
    "6notes/alu" [label="notes/alu"]
    "7notes/arm" [label="notes/arm"]
    "8notes/arp-packet" [label="notes/arp-packet"]
    "9notes/avr-ports" [label="notes/avr-ports"]
    "10notes/abstract-classes-in-c++" [label="notes/abstract-classes-in-c++"]
    "11notes/acceleration-af-partikler" [label="notes/acceleration-af-partikler"]
    "12notes/algorithms-and-data-structures" [label="notes/algorithms-and-data-structures"]
    "13notes/amdahls-law" [label="notes/amdahls-law"]
    "14notes/andengradspolynomier" [label="notes/andengradspolynomier"]
    "15notes/andenordens-inhomogene-differentialligninger" [label="notes/andenordens-inhomogene-differentialligninger"]
    "16notes/andenordensdifferentialligninger" [label="notes/andenordensdifferentialligninger"]
    "17notes/angle-set-conventions" [label="notes/angle-set-conventions"]
    "18notes/anti-aliasering-filter" [label="notes/anti-aliasering-filter"]
    "19notes/anti-windup" [label="notes/anti-windup"]
    "20notes/antisymetrisk" [label="notes/antisymetrisk"]
    "21notes/approximation" [label="notes/approximation"]
    "22notes/arbejde" [label="notes/arbejde"]
    "23notes/arc-length" [label="notes/arc-length"]
    "24notes/arrays-in-c++" [label="notes/arrays-in-c++"]
    "25notes/artificial-intelligence" [label="notes/artificial-intelligence"]
    "26notes/assembly" [label="notes/assembly"]
    "27notes/assumptions-of-kinematics" [label="notes/assumptions-of-kinematics"]
    "28notes/asymptotic-relative-efficiency-(are)" [label="notes/asymptotic-relative-efficiency-(are)"]
    "29notes/at-gøre-prøve" [label="notes/at-gøre-prøve"]
    "30notes/axis-angle" [label="notes/axis-angle"]
    "31notes/bandwidth" [label="notes/bandwidth"]
    "32notes/basis" [label="notes/basis"]
    "33notes/bayesian-learning" [label="notes/bayesian-learning"]
    "34notes/bayesian-networks" [label="notes/bayesian-networks"]
    "35notes/bellman-ford*-algorithm" [label="notes/bellman-ford*-algorithm"]
    "36notes/bessel" [label="notes/bessel"]
    "37notes/bevis-for-2.-løsningsformel" [label="notes/bevis-for-2.-løsningsformel"]
    "38notes/bevis-for-parameterfremstilling" [label="notes/bevis-for-parameterfremstilling"]
    "39notes/bevis-for-den-gennerelle-løsningsformel-til-linære-førsteordensdifferentialligninger" [label="notes/bevis-for-den-gennerelle-løsningsformel-til-linære-førsteordensdifferentialligninger"]
    "40notes/beviser" [label="notes/beviser"]
    "41notes/bevægelse-på-skråplan" [label="notes/bevægelse-på-skråplan"]
    "42notes/bevægelsesmængde-(impuls)" [label="notes/bevægelsesmængde-(impuls)"]
    "43notes/bevægelsesmængdemoment" [label="notes/bevægelsesmængdemoment"]
    "44notes/bias" [label="notes/bias"]
    "45notes/big-o-notation" [label="notes/big-o-notation"]
    "46notes/bilineær-z-transformation" [label="notes/bilineær-z-transformation"]
    "47notes/binomial-distribution" [label="notes/binomial-distribution"]
    "48notes/bivariate-distribution" [label="notes/bivariate-distribution"]
    "49notes/bode-plot" [label="notes/bode-plot"]
    "50notes/bolzmanns-konstant" [label="notes/bolzmanns-konstant"]
    "51notes/boolean-algebra" [label="notes/boolean-algebra"]
    "52notes/breadth-first-search" [label="notes/breadth-first-search"]
    "53notes/butterworth-filter" [label="notes/butterworth-filter"]
    "54notes/bølgeformlen" [label="notes/bølgeformlen"]
    "55notes/c-libraries" [label="notes/c-libraries"]
    "56notes/c++-streams" [label="notes/c++-streams"]
    "57notes/cascade-control" [label="notes/cascade-control"]
    "58notes/central-limit-theorem" [label="notes/central-limit-theorem"]
    "59notes/centripetalacceleration" [label="notes/centripetalacceleration"]
    "60notes/centripetalkraft" [label="notes/centripetalkraft"]
    "61notes/change-of-variables" [label="notes/change-of-variables"]
    "62notes/chebyshev-filter" [label="notes/chebyshev-filter"]
    "63notes/cholesky-decomposition" [label="notes/cholesky-decomposition"]
    "64notes/circles" [label="notes/circles"]
    "65notes/cirklens-ligning" [label="notes/cirklens-ligning"]
    "66notes/classes-in-c++" [label="notes/classes-in-c++"]
    "67notes/classification-of-second-order-pdes" [label="notes/classification-of-second-order-pdes"]
    "68notes/common-mode-rejection-ratio" [label="notes/common-mode-rejection-ratio"]
    "69notes/confidence-interval" [label="notes/confidence-interval"]
    "70notes/control-system-performance" [label="notes/control-system-performance"]
    "71notes/control-systems" [label="notes/control-systems"]
    "72notes/controllability" [label="notes/controllability"]
    "73notes/controllable-canonical-form" [label="notes/controllable-canonical-form"]
    "74notes/convergence-of-random-variables" [label="notes/convergence-of-random-variables"]
    "75notes/coulumbs-lov" [label="notes/coulumbs-lov"]
    "76notes/coulumbs-konstant" [label="notes/coulumbs-konstant"]
    "77notes/covariance-and-correlation" [label="notes/covariance-and-correlation"]
    "78notes/covariance" [label="notes/covariance"]
    "79notes/craigs-notation" [label="notes/craigs-notation"]
    "80notes/critical-value" [label="notes/critical-value"]
    "81notes/curl" [label="notes/curl"]
    "82notes/cylindrical-coordinates" [label="notes/cylindrical-coordinates"]
    "83notes/d-latch" [label="notes/d-latch"]
    "84notes/dc-amplification" [label="notes/dc-amplification"]
    "85notes/dc" [label="notes/dc"]
    "86notes/dh-parameters" [label="notes/dh-parameters"]
    "87notes/dhcp" [label="notes/dhcp"]
    "88notes/data-communication" [label="notes/data-communication"]
    "89notes/data-link-layer" [label="notes/data-link-layer"]
    "90notes/de-kinematiske-ligninger" [label="notes/de-kinematiske-ligninger"]
    "91notes/decibel" [label="notes/decibel"]
    "92notes/deep-learning" [label="notes/deep-learning"]
    "93notes/degrees-of-freedom" [label="notes/degrees-of-freedom"]
    "94notes/delay-through-filter-(gruppeløstid)" [label="notes/delay-through-filter-(gruppeløstid)"]
    "95notes/delta-method" [label="notes/delta-method"]
    "96notes/den-retningsafledte" [label="notes/den-retningsafledte"]
    "97notes/densitet" [label="notes/densitet"]
    "98notes/depth-first-search" [label="notes/depth-first-search"]
    "99notes/det-komplekse-plan" [label="notes/det-komplekse-plan"]
    "100notes/determinanen-for-matricer" [label="notes/determinanen-for-matricer"]
    "101notes/diagonalization" [label="notes/diagonalization"]
    "102notes/diagonalmatrix" [label="notes/diagonalmatrix"]
    "103notes/differensligninger" [label="notes/differensligninger"]
    "104notes/differential-equations" [label="notes/differential-equations"]
    "105notes/differentialregning-basis" [label="notes/differentialregning-basis"]
    "106notes/differentialregning-regneregler" [label="notes/differentialregning-regneregler"]
    "107notes/differentialregning" [label="notes/differentialregning"]
    "108notes/differentiation-af-funktioner-med-to-variable" [label="notes/differentiation-af-funktioner-med-to-variable"]
    "109notes/differentiator" [label="notes/differentiator"]
    "110notes/digital-realisation-structures" [label="notes/digital-realisation-structures"]
    "111notes/digitization" [label="notes/digitization"]
    "112notes/dijkstra’s-algorithm" [label="notes/dijkstra’s-algorithm"]
    "113notes/dioder" [label="notes/dioder"]
    "114notes/dirac-delta-function" [label="notes/dirac-delta-function"]
    "115notes/direct-samling" [label="notes/direct-samling"]
    "116notes/directories-in-c" [label="notes/directories-in-c"]
    "117notes/diskret-fourier-transformation" [label="notes/diskret-fourier-transformation"]
    "118notes/distributions" [label="notes/distributions"]
    "119notes/disturbance-rejection" [label="notes/disturbance-rejection"]
    "120notes/divergence" [label="notes/divergence"]
    "121notes/dynamic-bayesian-networks" [label="notes/dynamic-bayesian-networks"]
    "122notes/dynamic-compensation" [label="notes/dynamic-compensation"]
    "123notes/dynamic-inference" [label="notes/dynamic-inference"]
    "124notes/dynamic-memory-allocation" [label="notes/dynamic-memory-allocation"]
    "125notes/dæmpede-svingninger-differentialligning-1" [label="notes/dæmpede-svingninger-differentialligning-1"]
    "126notes/dæmpede-svingninger-differentialligning" [label="notes/dæmpede-svingninger-differentialligning"]
    "127notes/edmonds-karp-algorithm" [label="notes/edmonds-karp-algorithm"]
    "128notes/effekt" [label="notes/effekt"]
    "129notes/eigen-values-and-vectors" [label="notes/eigen-values-and-vectors"]
    "130notes/eigendecomposition" [label="notes/eigendecomposition"]
    "131notes/einsteins-fotoelektriske-lov" [label="notes/einsteins-fotoelektriske-lov"]
    "132notes/eksponentielle-funktioner" [label="notes/eksponentielle-funktioner"]
    "133notes/elektrisk-resonans" [label="notes/elektrisk-resonans"]
    "134notes/elektroner" [label="notes/elektroner"]
    "135notes/elementarladningen" [label="notes/elementarladningen"]
    "136notes/elementarpartiklers-bølgeegenskaber" [label="notes/elementarpartiklers-bølgeegenskaber"]
    "137notes/embedded" [label="notes/embedded"]
    "138notes/emperical-cdf" [label="notes/emperical-cdf"]
    "139notes/en-en-tydig-funktion" [label="notes/en-en-tydig-funktion"]
    "140notes/energi" [label="notes/energi"]
    "141notes/error-analysis" [label="notes/error-analysis"]
    "142notes/ethernet" [label="notes/ethernet"]
    "143notes/euler-lagrange-modelling" [label="notes/euler-lagrange-modelling"]
    "144notes/eulers-formel" [label="notes/eulers-formel"]
    "145notes/expectation" [label="notes/expectation"]
    "146notes/exponential-distribution" [label="notes/exponential-distribution"]
    "147notes/fan-out" [label="notes/fan-out"]
    "148notes/fir-filtre" [label="notes/fir-filtre"]
    "149notes/fast-fourier-transformation-(fft)" [label="notes/fast-fourier-transformation-(fft)"]
    "150notes/feed-forward" [label="notes/feed-forward"]
    "151notes/feedback-control" [label="notes/feedback-control"]
    "152notes/fejlberegning-på-operationsforstærker" [label="notes/fejlberegning-på-operationsforstærker"]
    "153notes/file-metadata" [label="notes/file-metadata"]
    "154notes/files" [label="notes/files"]
    "155notes/filter-transformations" [label="notes/filter-transformations"]
    "156notes/filters" [label="notes/filters"]
    "157notes/first-order-logic" [label="notes/first-order-logic"]
    "158notes/fisher-information" [label="notes/fisher-information"]
    "159notes/fjederkraft" [label="notes/fjederkraft"]
    "160notes/flytningsformlen" [label="notes/flytningsformlen"]
    "161notes/foldningssum" [label="notes/foldningssum"]
    "162notes/ford-fulkerson-algorithm" [label="notes/ford-fulkerson-algorithm"]
    "163notes/fordampningsenergi" [label="notes/fordampningsenergi"]
    "164notes/fordoblings-og-halveringkonstant" [label="notes/fordoblings-og-halveringkonstant"]
    "165notes/forward-kinematics" [label="notes/forward-kinematics"]
    "166notes/forwarding-table" [label="notes/forwarding-table"]
    "167notes/fotoelektrisk-effekt" [label="notes/fotoelektrisk-effekt"]
    "168notes/fotoner" [label="notes/fotoner"]
    "169notes/fourier-transformation" [label="notes/fourier-transformation"]
    "170notes/fourieseries" [label="notes/fourieseries"]
    "171notes/frames" [label="notes/frames"]
    "172notes/frekvens" [label="notes/frekvens"]
    "173notes/frequency-response" [label="notes/frequency-response"]
    "174notes/friktion" [label="notes/friktion"]
    "175notes/fuldstændig-og-partikulær-løsning" [label="notes/fuldstændig-og-partikulær-løsning"]
    "176notes/full-adder" [label="notes/full-adder"]
    "177notes/funktioner-af-flere-variable" [label="notes/funktioner-af-flere-variable"]
    "178notes/førsteordensdifferentialligninger" [label="notes/førsteordensdifferentialligninger"]
    "179notes/gain-margins" [label="notes/gain-margins"]
    "180notes/gates" [label="notes/gates"]
    "181notes/gausss-divergence-theorem" [label="notes/gausss-divergence-theorem"]
    "182notes/gaussian-distribution" [label="notes/gaussian-distribution"]
    "183notes/generalized-coordinates" [label="notes/generalized-coordinates"]
    "184notes/gimbal-lock" [label="notes/gimbal-lock"]
    "185notes/gnidning" [label="notes/gnidning"]
    "186notes/gnidningsmordstand-gennem-luft" [label="notes/gnidningsmordstand-gennem-luft"]
    "187notes/gradient" [label="notes/gradient"]
    "188notes/gravitation" [label="notes/gravitation"]
    "189notes/gray-codes" [label="notes/gray-codes"]
    "190notes/greens-theorem" [label="notes/greens-theorem"]
    "191notes/grænser" [label="notes/grænser"]
    "192notes/halveringtid" [label="notes/halveringtid"]
    "193notes/hamming-distance" [label="notes/hamming-distance"]
    "194notes/harmoniske-svingninger" [label="notes/harmoniske-svingninger"]
    "195notes/hastighed-og-fart" [label="notes/hastighed-og-fart"]
    "196notes/hello-world-in-c++" [label="notes/hello-world-in-c++"]
    "197notes/hidden-markov-models" [label="notes/hidden-markov-models"]
    "198notes/homogeneous-functions" [label="notes/homogeneous-functions"]
    "199notes/hvordan-skriver-man-en-videnskabelig-artikel" [label="notes/hvordan-skriver-man-en-videnskabelig-artikel"]
    "200notes/hypothesis-testing" [label="notes/hypothesis-testing"]
    "201notes/hældningsfelt" [label="notes/hældningsfelt"]
    "202notes/iid" [label="notes/iid"]
    "203notes/iir-filters" [label="notes/iir-filters"]
    "204notes/ipv4" [label="notes/ipv4"]
    "205notes/ipv6" [label="notes/ipv6"]
    "206notes/identity-matrix" [label="notes/identity-matrix"]
    "207notes/impedans" [label="notes/impedans"]
    "208notes/impule-inveriant-z-transformation" [label="notes/impule-inveriant-z-transformation"]
    "209notes/impulse-response" [label="notes/impulse-response"]
    "210notes/impulse-sampling" [label="notes/impulse-sampling"]
    "211notes/impulsmoment" [label="notes/impulsmoment"]
    "212notes/indre-og-ydre-produkt" [label="notes/indre-og-ydre-produkt"]
    "213notes/inertimoment" [label="notes/inertimoment"]
    "214notes/insertion-sort" [label="notes/insertion-sort"]
    "215notes/integral-control" [label="notes/integral-control"]
    "216notes/integral-table" [label="notes/integral-table"]
    "217notes/integraler-regneregler" [label="notes/integraler-regneregler"]
    "218notes/integraler" [label="notes/integraler"]
    "219notes/integralregning-basis" [label="notes/integralregning-basis"]
    "220notes/integration-med-substidution" [label="notes/integration-med-substidution"]
    "221notes/integrator" [label="notes/integrator"]
    "222notes/intel-x86-architecture" [label="notes/intel-x86-architecture"]
    "223notes/intelligent-systems" [label="notes/intelligent-systems"]
    "224notes/interfaces-in-c++" [label="notes/interfaces-in-c++"]
    "225notes/interupts" [label="notes/interupts"]
    "226notes/inverse-kinematics" [label="notes/inverse-kinematics"]
    "227notes/inverse-matrix" [label="notes/inverse-matrix"]
    "228notes/jacobian-matrix-for-robotics" [label="notes/jacobian-matrix-for-robotics"]
    "229notes/jacobian-matrix" [label="notes/jacobian-matrix"]
    "230notes/jævn-cirkelbevægelse" [label="notes/jævn-cirkelbevægelse"]
    "231notes/kcl" [label="notes/kcl"]
    "232notes/kvl" [label="notes/kvl"]
    "233notes/kalman-filter" [label="notes/kalman-filter"]
    "234notes/karatsuba-algorithm" [label="notes/karatsuba-algorithm"]
    "235notes/karnaugh-map" [label="notes/karnaugh-map"]
    "236notes/keplers-lov" [label="notes/keplers-lov"]
    "237notes/kinematrics" [label="notes/kinematrics"]
    "238notes/kinetic-energy" [label="notes/kinetic-energy"]
    "239notes/kinetisk-energi" [label="notes/kinetisk-energi"]
    "240notes/knudepunktsmetoden" [label="notes/knudepunktsmetoden"]
    "241notes/koblede-førsteordensdifferentialligninger" [label="notes/koblede-førsteordensdifferentialligninger"]
    "242notes/komparator" [label="notes/komparator"]
    "243notes/komplekse-tal" [label="notes/komplekse-tal"]
    "244notes/kondensator" [label="notes/kondensator"]
    "245notes/konduktans" [label="notes/konduktans"]
    "246notes/konservative-og-ikke-konservative-kræfter" [label="notes/konservative-og-ikke-konservative-kræfter"]
    "247notes/koordinatsystem-og-flader" [label="notes/koordinatsystem-og-flader"]
    "248notes/kosaraju’s-algorithm" [label="notes/kosaraju’s-algorithm"]
    "249notes/kraftmoment" [label="notes/kraftmoment"]
    "250notes/kredsløb" [label="notes/kredsløb"]
    "251notes/kvadratkomplettering" [label="notes/kvadratkomplettering"]
    "252notes/lu-decomposition" [label="notes/lu-decomposition"]
    "253notes/ladning-i-en-kugle" [label="notes/ladning-i-en-kugle"]
    "254notes/ladningers-bevægelse-i-et-kuglesymmetrisk-felt" [label="notes/ladningers-bevægelse-i-et-kuglesymmetrisk-felt"]
    "255notes/laplace-transformation" [label="notes/laplace-transformation"]
    "256notes/laplaces-equation" [label="notes/laplaces-equation"]
    "257notes/laplaces-lov" [label="notes/laplaces-lov"]
    "258notes/laplacian-operator" [label="notes/laplacian-operator"]
    "259notes/latch" [label="notes/latch"]
    "260notes/law-of-cosines" [label="notes/law-of-cosines"]
    "261notes/law-of-large-number" [label="notes/law-of-large-number"]
    "262notes/least-squared-problem" [label="notes/least-squared-problem"]
    "263notes/ledere-og-isolatorer" [label="notes/ledere-og-isolatorer"]
    "264notes/libraries-in-c++" [label="notes/libraries-in-c++"]
    "265notes/library-interpositioning" [label="notes/library-interpositioning"]
    "266notes/ligninssystemer-uden-løsninger" [label="notes/ligninssystemer-uden-løsninger"]
    "267notes/linarisering" [label="notes/linarisering"]
    "268notes/line-coding" [label="notes/line-coding"]
    "269notes/line-integrals" [label="notes/line-integrals"]
    "270notes/linear-algebra" [label="notes/linear-algebra"]
    "271notes/linear-classification" [label="notes/linear-classification"]
    "272notes/linear-systems" [label="notes/linear-systems"]
    "273notes/lineært-tidsinvariant-system" [label="notes/lineært-tidsinvariant-system"]
    "274notes/links" [label="notes/links"]
    "275notes/linux-processes" [label="notes/linux-processes"]
    "276notes/linære-funktioner" [label="notes/linære-funktioner"]
    "277notes/linære-førsteordensdifferentialligninger" [label="notes/linære-førsteordensdifferentialligninger"]
    "278notes/linært-afhængige-vektorer" [label="notes/linært-afhængige-vektorer"]
    "279notes/log-likelihood-test" [label="notes/log-likelihood-test"]
    "280notes/logaritmer" [label="notes/logaritmer"]
    "281notes/logistisk-vækst" [label="notes/logistisk-vækst"]
    "282notes/loops-in-c++" [label="notes/loops-in-c++"]
    "283notes/lysets-hastighed" [label="notes/lysets-hastighed"]
    "284notes/mic-architecture" [label="notes/mic-architecture"]
    "285notes/machine-learning" [label="notes/machine-learning"]
    "286notes/maps" [label="notes/maps"]
    "287notes/marginal-distribution" [label="notes/marginal-distribution"]
    "288notes/maskemetoden" [label="notes/maskemetoden"]
    "289notes/massemidtpunkt" [label="notes/massemidtpunkt"]
    "290notes/master-theorem" [label="notes/master-theorem"]
    "291notes/matched-z-transformation" [label="notes/matched-z-transformation"]
    "292notes/matricer-regneregler" [label="notes/matricer-regneregler"]
    "293notes/matrix-image" [label="notes/matrix-image"]
    "294notes/matrix-kernel" [label="notes/matrix-kernel"]
    "295notes/matrix" [label="notes/matrix"]
    "296notes/max-flow" [label="notes/max-flow"]
    "297notes/maximum-likelihood-estimation-(mle)" [label="notes/maximum-likelihood-estimation-(mle)"]
    "298notes/mean-square-error-(mse)" [label="notes/mean-square-error-(mse)"]
    "299notes/media-access-control" [label="notes/media-access-control"]
    "300notes/mekanisk-effekt" [label="notes/mekanisk-effekt"]
    "301notes/mekanisk-energi-i-centralbevægelser" [label="notes/mekanisk-energi-i-centralbevægelser"]
    "302notes/mekanisk-energi" [label="notes/mekanisk-energi"]
    "303notes/memory-management-in-c++" [label="notes/memory-management-in-c++"]
    "304notes/memory-management" [label="notes/memory-management"]
    "305notes/mergesort" [label="notes/mergesort"]
    "306notes/microcontrolers" [label="notes/microcontrolers"]
    "307notes/middelværdisætningen" [label="notes/middelværdisætningen"]
    "308notes/mixture-models" [label="notes/mixture-models"]
    "309notes/modstande" [label="notes/modstande"]
    "310notes/monotoniforhold" [label="notes/monotoniforhold"]
    "311notes/morgans-law" [label="notes/morgans-law"]
    "312notes/multiplexer" [label="notes/multiplexer"]
    "313notes/multivariable-math" [label="notes/multivariable-math"]
    "314notes/multivariate-random-variables" [label="notes/multivariate-random-variables"]
    "315notes/nat" [label="notes/nat"]
    "316notes/network-layer" [label="notes/network-layer"]
    "317notes/neutral-stability" [label="notes/neutral-stability"]
    "318notes/newtons-afkølingslov" [label="notes/newtons-afkølingslov"]
    "319notes/newtons-love" [label="notes/newtons-love"]
    "320notes/niveaukurver" [label="notes/niveaukurver"]
    "321notes/normal-distribution" [label="notes/normal-distribution"]
    "322notes/normal-form-of-a-pde" [label="notes/normal-form-of-a-pde"]
    "323notes/normalfordelingen" [label="notes/normalfordelingen"]
    "324notes/normalkraft" [label="notes/normalkraft"]
    "325notes/norton-ækvivalens" [label="notes/norton-ækvivalens"]
    "326notes/numbering-systems" [label="notes/numbering-systems"]
    "327notes/numerical-methods" [label="notes/numerical-methods"]
    "328notes/nyquist-formula" [label="notes/nyquist-formula"]
    "329notes/nyquist-stability" [label="notes/nyquist-stability"]
    "330notes/nyquist-shannon" [label="notes/nyquist-shannon"]
    "331notes/observers" [label="notes/observers"]
    "332notes/ohms-lov" [label="notes/ohms-lov"]
    "333notes/omdrejningslegne" [label="notes/omdrejningslegne"]
    "334notes/omvendt-funktion" [label="notes/omvendt-funktion"]
    "335notes/operationsforstærker" [label="notes/operationsforstærker"]
    "336notes/optimal-control" [label="notes/optimal-control"]
    "337notes/orientation" [label="notes/orientation"]
    "338notes/orthogonal-matrix" [label="notes/orthogonal-matrix"]
    "339notes/p-value" [label="notes/p-value"]
    "340notes/pid-controller" [label="notes/pid-controller"]
    "341notes/parallelforbindelser" [label="notes/parallelforbindelser"]
    "342notes/parity-check-code" [label="notes/parity-check-code"]
    "343notes/partial-differential-equations" [label="notes/partial-differential-equations"]
    "344notes/partialbrøker" [label="notes/partialbrøker"]
    "345notes/particle-filtering" [label="notes/particle-filtering"]
    "346notes/partiel-integration" [label="notes/partiel-integration"]
    "347notes/penduler" [label="notes/penduler"]
    "348notes/periodic-signal-analysis" [label="notes/periodic-signal-analysis"]
    "349notes/phasor-representation" [label="notes/phasor-representation"]
    "350notes/planck-konstanten" [label="notes/planck-konstanten"]
    "351notes/plane-kredsløb" [label="notes/plane-kredsløb"]
    "352notes/planer" [label="notes/planer"]
    "353notes/plug-in-estimator" [label="notes/plug-in-estimator"]
    "354notes/pointers" [label="notes/pointers"]
    "355notes/poisson-distribution" [label="notes/poisson-distribution"]
    "356notes/poissons-equation" [label="notes/poissons-equation"]
    "357notes/polar-coordinates" [label="notes/polar-coordinates"]
    "358notes/pooling" [label="notes/pooling"]
    "359notes/positive-definite-matrix" [label="notes/positive-definite-matrix"]
    "360notes/positive-semi-definite-matrix" [label="notes/positive-semi-definite-matrix"]
    "361notes/potensregneregler" [label="notes/potensregneregler"]
    "362notes/potential-energy" [label="notes/potential-energy"]
    "363notes/potentiel-energi" [label="notes/potentiel-energi"]
    "364notes/predict-cpu-burst" [label="notes/predict-cpu-burst"]
    "365notes/probability-vs-likelihood" [label="notes/probability-vs-likelihood"]
    "366notes/process" [label="notes/process"]
    "367notes/projection" [label="notes/projection"]
    "368notes/propability-space" [label="notes/propability-space"]
    "369notes/pulse-sampling" [label="notes/pulse-sampling"]
    "370notes/python-web-scraping" [label="notes/python-web-scraping"]
    "371notes/qq-plot" [label="notes/qq-plot"]
    "372notes/quicksort" [label="notes/quicksort"]
    "373notes/risc-vs.-cisc-architecture" [label="notes/risc-vs.-cisc-architecture"]
    "374notes/rms-værdien" [label="notes/rms-værdien"]
    "375notes/radix-sort" [label="notes/radix-sort"]
    "376notes/raketligningen" [label="notes/raketligningen"]
    "377notes/random-variables" [label="notes/random-variables"]
    "378notes/rank-of-matrix" [label="notes/rank-of-matrix"]
    "379notes/rationelle-funktioner" [label="notes/rationelle-funktioner"]
    "380notes/references-in-c++" [label="notes/references-in-c++"]
    "381notes/registers" [label="notes/registers"]
    "382notes/relativitetsteorien" [label="notes/relativitetsteorien"]
    "383notes/riemann-sum" [label="notes/riemann-sum"]
    "384notes/root-locus-tuning" [label="notes/root-locus-tuning"]
    "385notes/rotation" [label="notes/rotation"]
    "386notes/rotational-matrices" [label="notes/rotational-matrices"]
    "387notes/row-echelon-form" [label="notes/row-echelon-form"]
    "388notes/rulning" [label="notes/rulning"]
    "389notes/række-og-søjle-vektorer" [label="notes/række-og-søjle-vektorer"]
    "390notes/røntgenrør" [label="notes/røntgenrør"]
    "391notes/røntgenstråling" [label="notes/røntgenstråling"]
    "392notes/safe-state" [label="notes/safe-state"]
    "393notes/sample-mean-and-variance" [label="notes/sample-mean-and-variance"]
    "394notes/schmitt-trigger" [label="notes/schmitt-trigger"]
    "395notes/score-function" [label="notes/score-function"]
    "396notes/score-test" [label="notes/score-test"]
    "397notes/scrum" [label="notes/scrum"]
    "398notes/sekant" [label="notes/sekant"]
    "399notes/seperation-of-variables" [label="notes/seperation-of-variables"]
    "400notes/sequences" [label="notes/sequences"]
    "401notes/serieforbindelser" [label="notes/serieforbindelser"]
    "402notes/shannon-formula" [label="notes/shannon-formula"]
    "403notes/signal-bandwidth" [label="notes/signal-bandwidth"]
    "404notes/signal-processing" [label="notes/signal-processing"]
    "405notes/signal-reconstruction" [label="notes/signal-reconstruction"]
    "406notes/signal-element" [label="notes/signal-element"]
    "407notes/signals" [label="notes/signals"]
    "408notes/simulation-of-robot-dynamics" [label="notes/simulation-of-robot-dynamics"]
    "409notes/singular-value-decomposition" [label="notes/singular-value-decomposition"]
    "410notes/skrå-kast" [label="notes/skrå-kast"]
    "411notes/sliding-mode-control" [label="notes/sliding-mode-control"]
    "412notes/smart-pointers-in-c++" [label="notes/smart-pointers-in-c++"]
    "413notes/små-integrationsbeviser" [label="notes/små-integrationsbeviser"]
    "414notes/snitkurver" [label="notes/snitkurver"]
    "415notes/software-development" [label="notes/software-development"]
    "416notes/sorting-algorithms" [label="notes/sorting-algorithms"]
    "417notes/specifik-fordampningsvarme" [label="notes/specifik-fordampningsvarme"]
    "418notes/specifik-smeltevarme" [label="notes/specifik-smeltevarme"]
    "419notes/spectral-theorem" [label="notes/spectral-theorem"]
    "420notes/spherical-coordinates" [label="notes/spherical-coordinates"]
    "421notes/spoler" [label="notes/spoler"]
    "422notes/spænding" [label="notes/spænding"]
    "423notes/spændingsdeler" [label="notes/spændingsdeler"]
    "424notes/stability" [label="notes/stability"]
    "425notes/stable-sorting" [label="notes/stable-sorting"]
    "426notes/standard-error" [label="notes/standard-error"]
    "427notes/standard-io" [label="notes/standard-io"]
    "428notes/standard-teorien" [label="notes/standard-teorien"]
    "429notes/state-feedback" [label="notes/state-feedback"]
    "430notes/state-machines" [label="notes/state-machines"]
    "431notes/state-space-models" [label="notes/state-space-models"]
    "432notes/stationære-punkter" [label="notes/stationære-punkter"]
    "433notes/statistics" [label="notes/statistics"]
    "434notes/steady-state-tracking" [label="notes/steady-state-tracking"]
    "435notes/steady-state-value-of-time-function" [label="notes/steady-state-value-of-time-function"]
    "436notes/step-response" [label="notes/step-response"]
    "437notes/stokes-gnidningslov" [label="notes/stokes-gnidningslov"]
    "438notes/strongly-connected-components" [label="notes/strongly-connected-components"]
    "439notes/strøm" [label="notes/strøm"]
    "440notes/strømdeler" [label="notes/strømdeler"]
    "441notes/stående-cirkelbølger" [label="notes/stående-cirkelbølger"]
    "442notes/stød" [label="notes/stød"]
    "443notes/subtractor" [label="notes/subtractor"]
    "444notes/sum-of-products" [label="notes/sum-of-products"]
    "445notes/supervised-learning" [label="notes/supervised-learning"]
    "446notes/surface-integrals" [label="notes/surface-integrals"]
    "447notes/symetric-matrices" [label="notes/symetric-matrices"]
    "448notes/system-of-linear-equations" [label="notes/system-of-linear-equations"]
    "449notes/tcp-ip" [label="notes/tcp-ip"]
    "450notes/tangent-plane" [label="notes/tangent-plane"]
    "451notes/tangent" [label="notes/tangent"]
    "452notes/tangentplan" [label="notes/tangentplan"]
    "453notes/tarjans-algorithm" [label="notes/tarjans-algorithm"]
    "454notes/taylorpolynomium" [label="notes/taylorpolynomium"]
    "455notes/terminalhastighed" [label="notes/terminalhastighed"]
    "456notes/the-bootstrap" [label="notes/the-bootstrap"]
    "457notes/the-c++-preprocessor" [label="notes/the-c++-preprocessor"]
    "458notes/the-heat-equation" [label="notes/the-heat-equation"]
    "459notes/the-osi-model" [label="notes/the-osi-model"]
    "460notes/the-state-of-a-system" [label="notes/the-state-of-a-system"]
    "461notes/the-wave-equation" [label="notes/the-wave-equation"]
    "462notes/thevenin-ækvivalens" [label="notes/thevenin-ækvivalens"]
    "463notes/thread-deadlocks" [label="notes/thread-deadlocks"]
    "464notes/trace" [label="notes/trace"]
    "465notes/transformation-matrices" [label="notes/transformation-matrices"]
    "466notes/transient-respons" [label="notes/transient-respons"]
    "467notes/transistorer" [label="notes/transistorer"]
    "468notes/transmission" [label="notes/transmission"]
    "469notes/transport-layer" [label="notes/transport-layer"]
    "470notes/tretrinsraketten" [label="notes/tretrinsraketten"]
    "471notes/tri-state-buffer" [label="notes/tri-state-buffer"]
    "472notes/trigonometri" [label="notes/trigonometri"]
    "473notes/triple-integrals" [label="notes/triple-integrals"]
    "474notes/tyngdeaccelerationen" [label="notes/tyngdeaccelerationen"]
    "475notes/tyngdekraften" [label="notes/tyngdekraften"]
    "476notes/types-of-microcontrolers" [label="notes/types-of-microcontrolers"]
    "477notes/uart-protocol" [label="notes/uart-protocol"]
    "478notes/uegenlige-integraler" [label="notes/uegenlige-integraler"]
    "479notes/ulige-funktioner" [label="notes/ulige-funktioner"]
    "480notes/underactuated-robots" [label="notes/underactuated-robots"]
    "481notes/unified-process" [label="notes/unified-process"]
    "482notes/unit-sample" [label="notes/unit-sample"]
    "483notes/unix-files" [label="notes/unix-files"]
    "484notes/unix-io" [label="notes/unix-io"]
    "485notes/variance" [label="notes/variance"]
    "486notes/varmekapacitet" [label="notes/varmekapacitet"]
    "487notes/vector-fields" [label="notes/vector-fields"]
    "488notes/vectors" [label="notes/vectors"]
    "489notes/vektorfunktioner" [label="notes/vektorfunktioner"]
    "490notes/velocity-curves" [label="notes/velocity-curves"]
    "491notes/vinkelfrekvens" [label="notes/vinkelfrekvens"]
    "492notes/viskositet" [label="notes/viskositet"]
    "493notes/viterbi-algorithm" [label="notes/viterbi-algorithm"]
    "494notes/vnodes-and-inodes" [label="notes/vnodes-and-inodes"]
    "495notes/wald-test" [label="notes/wald-test"]
    "496notes/window-functions" [label="notes/window-functions"]
    "497notes/x2-distribution" [label="notes/x2-distribution"]
    "498notes/z-distribution" [label="notes/z-distribution"]
    "499notes/zeigler-nichols-tuning-method" [label="notes/zeigler-nichols-tuning-method"]
    "500notes/gravitationskraft" [label="notes/gravitationskraft"]
    "501notes/impulstog" [label="notes/impulstog"]
    "502notes/n-space" [label="notes/n-space"]
    "503notes/z-transformation" [label="notes/z-transformation"]
    "504notes/ækvivalente-kredsløb" [label="notes/ækvivalente-kredsløb"]
    "505readme" [label="readme"]
    "506templates/insert-title" [label="templates/insert-title"]
    "507templates/distribution" [label="templates/distribution"]
    "508templates/subject" [label="templates/subject"]

    "110notes/digital-realisation-structures" -> "503notes/z-transformation"
    "111notes/digitization" -> "46notes/bilineær-z-transformation"
    "111notes/digitization" -> "503notes/z-transformation"
    "179notes/gain-margins" -> "49notes/bode-plot"
    "195notes/hastighed-og-fart" -> "488notes/vectors"
    "203notes/iir-filters" -> "46notes/bilineær-z-transformation"
    "203notes/iir-filters" -> "291notes/matched-z-transformation"
    "208notes/impule-inveriant-z-transformation" -> "344notes/partialbrøker"
    "212notes/indre-og-ydre-produkt" -> "488notes/vectors"
    "230notes/jævn-cirkelbevægelse" -> "488notes/vectors"
    "327notes/numerical-methods" -> "409notes/singular-value-decomposition"
    "331notes/observers" -> "429notes/state-feedback"
}

:b shell 60
python3 examples/4_graph_image.py "test-vaults/simple_vault"
:i returncode 0
:b stdout 660
digraph {
    overlap=false;
    node [shape=box, style=filled, fillcolor="#0099FF25"];
    edge [color="#00000090"];

    "0callout" [label="callout"]
    "1code" [label="code"]
    "2first_note" [label="first_note"]
    "3frontmatter" [label="frontmatter"]
    "4list" [label="list"]
    "5quote" [label="quote"]
    "6second_note" [label="second_note"]
    "7sub/sub-note" [label="sub/sub-note"]
    "8sub/todo" [label="sub/todo"]
    "9todo" [label="todo"]
    "10websites" [label="websites"]

    "0callout" -> "2first_note"
    "2first_note" -> "6second_note"
    "2first_note" -> "8sub/todo"
    "6second_note" -> "2first_note"
    "9todo" -> "4list"
}

:b shell 76
python3 examples/4_graph_image.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 0
:b stdout 10819
digraph {
    overlap=false;
    node [shape=box, style=filled, fillcolor="#0099FF25"];
    edge [color="#00000090"];

    "0readme" [label="readme"]
    "1vault/concept-board/concept-board" [label="vault/concept-board/concept-board"]
    "2vault/concept-board/concepts/vertical-hydroponics" [label="vault/concept-board/concepts/vertical-hydroponics"]
    "3vault/concept-board/drawings/satellite-concept-drawing" [label="vault/concept-board/drawings/satellite-concept-drawing"]
    "4vault/dashboard" [label="vault/dashboard"]
    "5vault/element-structure-and-formats" [label="vault/element-structure-and-formats"]
    "6vault/inbox/inbox" [label="vault/inbox/inbox"]
    "7vault/journal/entries/2023-07-21" [label="vault/journal/entries/2023-07-21"]
    "8vault/journal/journal-dashboard" [label="vault/journal/journal-dashboard"]
    "9vault/learning/learning-dashboard" [label="vault/learning/learning-dashboard"]
    "10vault/notes/enceladus-geysers-potential-causes" [label="vault/notes/enceladus-geysers-potential-causes"]
    "11vault/notes/enceladus-ice-thickness" [label="vault/notes/enceladus-ice-thickness"]
    "12vault/notes/notes-dashboard" [label="vault/notes/notes-dashboard"]
    "13vault/notes/radiation-belt-locations" [label="vault/notes/radiation-belt-locations"]
    "14vault/notes/solar-cycle-duration" [label="vault/notes/solar-cycle-duration"]
    "15vault/personal/personal-dashboard" [label="vault/personal/personal-dashboard"]
    "16vault/projects/projects" [label="vault/projects/projects"]
    "17vault/projects/top-secret-project/home" [label="vault/projects/top-secret-project/home"]
    "18vault/projects/top-secret-project/meetings/2023-10-29-example-meeting-note" [label="vault/projects/top-secret-project/meetings/2023-10-29-example-meeting-note"]
    "19vault/projects/top-secret-project/meetings/all-meetings" [label="vault/projects/top-secret-project/meetings/all-meetings"]
    "20vault/projects/top-secret-project/notes/all-notes" [label="vault/projects/top-secret-project/notes/all-notes"]
    "21vault/projects/top-secret-project/references" [label="vault/projects/top-secret-project/references"]
    "22vault/projects/top-secret-project/tasks" [label="vault/projects/top-secret-project/tasks"]
    "23vault/readme" [label="vault/readme"]
    "24vault/resources/resources-dashboard" [label="vault/resources/resources-dashboard"]
    "25vault/spaces/books/books-dashboard" [label="vault/spaces/books/books-dashboard"]
    "26vault/spaces/contacts/example-contact" [label="vault/spaces/contacts/example-contact"]
    "27vault/spaces/definitions/periapsis" [label="vault/spaces/definitions/periapsis"]
    "28vault/spaces/formulas/all-formulas" [label="vault/spaces/formulas/all-formulas"]
    "29vault/spaces/formulas/tsiolkovsky-rocket-equation" [label="vault/spaces/formulas/tsiolkovsky-rocket-equation"]
    "30vault/spaces/obsidian-development/navigation-with-dataview-and-customjs" [label="vault/spaces/obsidian-development/navigation-with-dataview-and-customjs"]
    "31vault/spaces/obsidian-development/navigation-with-dataviewjs" [label="vault/spaces/obsidian-development/navigation-with-dataviewjs"]
    "32vault/spaces/obsidian-development/obsidian-development-dashboard" [label="vault/spaces/obsidian-development/obsidian-development-dashboard"]
    "33vault/spaces/spaces-dashboard" [label="vault/spaces/spaces-dashboard"]
    "34vault/spaces/trips/trips-dashboard" [label="vault/spaces/trips/trips-dashboard"]
    "35vault/_data_/pinned/sidebar-navigation" [label="vault/_data_/pinned/sidebar-navigation"]
    "36vault/_data_/pinned/tasks" [label="vault/_data_/pinned/tasks"]
    "37vault/_data_/templates/callouts/abstract-callout" [label="vault/_data_/templates/callouts/abstract-callout"]
    "38vault/_data_/templates/callouts/bug-callout" [label="vault/_data_/templates/callouts/bug-callout"]
    "39vault/_data_/templates/callouts/caution-callout" [label="vault/_data_/templates/callouts/caution-callout"]
    "40vault/_data_/templates/callouts/danger-callout" [label="vault/_data_/templates/callouts/danger-callout"]
    "41vault/_data_/templates/callouts/done-callout" [label="vault/_data_/templates/callouts/done-callout"]
    "42vault/_data_/templates/callouts/error-callout" [label="vault/_data_/templates/callouts/error-callout"]
    "43vault/_data_/templates/callouts/example-callout" [label="vault/_data_/templates/callouts/example-callout"]
    "44vault/_data_/templates/callouts/faq-callout" [label="vault/_data_/templates/callouts/faq-callout"]
    "45vault/_data_/templates/callouts/failure-callout" [label="vault/_data_/templates/callouts/failure-callout"]
    "46vault/_data_/templates/callouts/help-callout" [label="vault/_data_/templates/callouts/help-callout"]
    "47vault/_data_/templates/callouts/important-callout" [label="vault/_data_/templates/callouts/important-callout"]
    "48vault/_data_/templates/callouts/info-callout" [label="vault/_data_/templates/callouts/info-callout"]
    "49vault/_data_/templates/callouts/missing-callout" [label="vault/_data_/templates/callouts/missing-callout"]
    "50vault/_data_/templates/callouts/note-callout" [label="vault/_data_/templates/callouts/note-callout"]
    "51vault/_data_/templates/callouts/question-callout" [label="vault/_data_/templates/callouts/question-callout"]
    "52vault/_data_/templates/callouts/quote-callout" [label="vault/_data_/templates/callouts/quote-callout"]
    "53vault/_data_/templates/callouts/success-callout" [label="vault/_data_/templates/callouts/success-callout"]
    "54vault/_data_/templates/callouts/summary-callout" [label="vault/_data_/templates/callouts/summary-callout"]
    "55vault/_data_/templates/callouts/tip-callout" [label="vault/_data_/templates/callouts/tip-callout"]
    "56vault/_data_/templates/callouts/todo-callout" [label="vault/_data_/templates/callouts/todo-callout"]
    "57vault/_data_/templates/callouts/warning-callout" [label="vault/_data_/templates/callouts/warning-callout"]
    "58vault/_data_/templates/dataview/dataview-flat-table" [label="vault/_data_/templates/dataview/dataview-flat-table"]
    "59vault/_data_/templates/dataview/dataview-nested-table" [label="vault/_data_/templates/dataview/dataview-nested-table"]
    "60vault/_data_/templates/dataview/insert-navigation-bar" [label="vault/_data_/templates/dataview/insert-navigation-bar"]
    "61vault/_data_/templates/dataview/list-installed-plugins" [label="vault/_data_/templates/dataview/list-installed-plugins"]
    "62vault/_data_/templates/general/blank-page" [label="vault/_data_/templates/general/blank-page"]
    "63vault/_data_/templates/general/boilerplate" [label="vault/_data_/templates/general/boilerplate"]
    "64vault/_data_/templates/general/book" [label="vault/_data_/templates/general/book"]
    "65vault/_data_/templates/general/concept" [label="vault/_data_/templates/general/concept"]
    "66vault/_data_/templates/general/contact" [label="vault/_data_/templates/general/contact"]
    "67vault/_data_/templates/general/definition" [label="vault/_data_/templates/general/definition"]
    "68vault/_data_/templates/general/empty-page" [label="vault/_data_/templates/general/empty-page"]
    "69vault/_data_/templates/general/insert-code-block" [label="vault/_data_/templates/general/insert-code-block"]
    "70vault/_data_/templates/general/insert-columns" [label="vault/_data_/templates/general/insert-columns"]
    "71vault/_data_/templates/general/insert-external-link" [label="vault/_data_/templates/general/insert-external-link"]
    "72vault/_data_/templates/general/insert-formula-variable-definition" [label="vault/_data_/templates/general/insert-formula-variable-definition"]
    "73vault/_data_/templates/general/insert-header-1" [label="vault/_data_/templates/general/insert-header-1"]
    "74vault/_data_/templates/general/insert-header-2" [label="vault/_data_/templates/general/insert-header-2"]
    "75vault/_data_/templates/general/insert-header-3" [label="vault/_data_/templates/general/insert-header-3"]
    "76vault/_data_/templates/general/insert-header-4" [label="vault/_data_/templates/general/insert-header-4"]
    "77vault/_data_/templates/general/insert-header-5" [label="vault/_data_/templates/general/insert-header-5"]
    "78vault/_data_/templates/general/insert-header-6" [label="vault/_data_/templates/general/insert-header-6"]
    "79vault/_data_/templates/general/insert-table-of-contents" [label="vault/_data_/templates/general/insert-table-of-contents"]
    "80vault/_data_/templates/general/journal-entry" [label="vault/_data_/templates/general/journal-entry"]
    "81vault/_data_/templates/general/math-constant" [label="vault/_data_/templates/general/math-constant"]
    "82vault/_data_/templates/general/math-formula" [label="vault/_data_/templates/general/math-formula"]
    "83vault/_data_/templates/general/note-page" [label="vault/_data_/templates/general/note-page"]
    "84vault/_data_/templates/general/travel-and-trip" [label="vault/_data_/templates/general/travel-and-trip"]
    "85vault/_data_/templates/learning/course-assignment" [label="vault/_data_/templates/learning/course-assignment"]
    "86vault/_data_/templates/learning/course-lecture" [label="vault/_data_/templates/learning/course-lecture"]
    "87vault/_data_/templates/learning/course-note" [label="vault/_data_/templates/learning/course-note"]
    "88vault/_data_/templates/learning/course-setup" [label="vault/_data_/templates/learning/course-setup"]
    "89vault/_data_/templates/project/project-boilerplate-page" [label="vault/_data_/templates/project/project-boilerplate-page"]
    "90vault/_data_/templates/project/project-feature" [label="vault/_data_/templates/project/project-feature"]
    "91vault/_data_/templates/project/project-meeting" [label="vault/_data_/templates/project/project-meeting"]
    "92vault/_data_/templates/project/project-note" [label="vault/_data_/templates/project/project-note"]
    "93vault/_data_/templates/project/project-setup-meetings" [label="vault/_data_/templates/project/project-setup-meetings"]
    "94vault/_data_/templates/project/project-setup-notes" [label="vault/_data_/templates/project/project-setup-notes"]
    "95vault/_data_/templates/project/project-setup-references" [label="vault/_data_/templates/project/project-setup-references"]
    "96vault/_data_/templates/project/project-setup-tasks" [label="vault/_data_/templates/project/project-setup-tasks"]
    "97vault/_data_/templates/project/project-setup" [label="vault/_data_/templates/project/project-setup"]
    "98vault/_data_/templates/project/project-task" [label="vault/_data_/templates/project/project-task"]
    "99vault/_data_/templates/resources/resource" [label="vault/_data_/templates/resources/resource"]
    "100vault/_data_/templates/spaces/space-home" [label="vault/_data_/templates/spaces/space-home"]

}

:b shell 65
python3 examples/4_graph_image.py "test-vaults/TheJoboReal_Noter"
:i returncode 0
:b stdout 128757
digraph {
    overlap=false;
    node [shape=box, style=filled, fillcolor="#0099FF25"];
    edge [color="#00000090"];

    "0calendar/03-01-2025" [label="calendar/03-01-2025"]
    "1calendar/19-11-2024" [label="calendar/19-11-2024"]
    "2calendar/2024-19-12" [label="calendar/2024-19-12"]
    "3calendar/2024-20-12" [label="calendar/2024-20-12"]
    "4calendar/2025-06-01" [label="calendar/2025-06-01"]
    "5calendar/2025-12-01" [label="calendar/2025-12-01"]
    "6calendar/21-11-2024" [label="calendar/21-11-2024"]
    "7calendar/22-01-2025" [label="calendar/22-01-2025"]
    "8calendar/24-11-2024" [label="calendar/24-11-2024"]
    "9calendar/26-01-2025" [label="calendar/26-01-2025"]
    "10calendar/26-12-2024" [label="calendar/26-12-2024"]
    "11calendar/27-11-2024" [label="calendar/27-11-2024"]
    "12calendar/29-11-2024" [label="calendar/29-11-2024"]
    "13calendar/29-12-2024" [label="calendar/29-12-2024"]
    "14calendar/30-12-2024" [label="calendar/30-12-2024"]
    "15dashboard" [label="dashboard"]
    "16excalidraw/drawing-2024-01-02-20.35.25.excalidraw" [label="excalidraw/drawing-2024-01-02-20.35.25.excalidraw"]
    "17excalidraw/drawing-2024-01-03-12.17.25.excalidraw" [label="excalidraw/drawing-2024-01-03-12.17.25.excalidraw"]
    "18excalidraw/drawing-2024-06-01-11.11.40.excalidraw" [label="excalidraw/drawing-2024-06-01-11.11.40.excalidraw"]
    "19excalidraw/drawing-2024-09-08-22.21.12.excalidraw" [label="excalidraw/drawing-2024-09-08-22.21.12.excalidraw"]
    "20excalidraw/drawing-2024-09-12-14.08.07.excalidraw" [label="excalidraw/drawing-2024-09-12-14.08.07.excalidraw"]
    "21excalidraw/drawing-2024-09-16-16.37.56.excalidraw" [label="excalidraw/drawing-2024-09-16-16.37.56.excalidraw"]
    "22excalidraw/drawing-2024-09-26-09.37.59.excalidraw" [label="excalidraw/drawing-2024-09-26-09.37.59.excalidraw"]
    "23excalidraw/drawing-2024-09-26-10.01.34.excalidraw" [label="excalidraw/drawing-2024-09-26-10.01.34.excalidraw"]
    "24excalidraw/drawing-2024-10-09-11.42.52.excalidraw" [label="excalidraw/drawing-2024-10-09-11.42.52.excalidraw"]
    "25excalidraw/drawing-2024-10-21-08.30.11.excalidraw" [label="excalidraw/drawing-2024-10-21-08.30.11.excalidraw"]
    "26excalidraw/drawing-2024-10-21-08.55.36.excalidraw" [label="excalidraw/drawing-2024-10-21-08.55.36.excalidraw"]
    "27formelsamling/auxiliary-conditions" [label="formelsamling/auxiliary-conditions"]
    "28formelsamling/classification-of-pde" [label="formelsamling/classification-of-pde"]
    "29formelsamling/differensligninger" [label="formelsamling/differensligninger"]
    "30formelsamling/differential-operators" [label="formelsamling/differential-operators"]
    "31formelsamling/dirac-delta-funktion" [label="formelsamling/dirac-delta-funktion"]
    "32formelsamling/direkte-type-1-og-2direkte-type-1direkte-type-1" [label="formelsamling/direkte-type-1-og-2direkte-type-1direkte-type-1"]
    "33formelsamling/direkte-type-1-og-2direkte-type-2direkte-type-2" [label="formelsamling/direkte-type-1-og-2direkte-type-2direkte-type-2"]
    "34formelsamling/diskret-fourier-transformation" [label="formelsamling/diskret-fourier-transformation"]
    "35formelsamling/distance-from-point-to-plane" [label="formelsamling/distance-from-point-to-plane"]
    "36formelsamling/domã¦ner-og-ranges" [label="formelsamling/domã¦ner-og-ranges"]
    "37formelsamling/double-integration" [label="formelsamling/double-integration"]
    "38formelsamling/dã¦mpede-svingninger" [label="formelsamling/dã¦mpede-svingninger"]
    "39formelsamling/enheds-step-funktion" [label="formelsamling/enheds-step-funktion"]
    "40formelsamling/fast-fourier-transformation" [label="formelsamling/fast-fourier-transformation"]
    "41formelsamling/fourier-koefficienter" [label="formelsamling/fourier-koefficienter"]
    "42formelsamling/fourier-rã¦kker" [label="formelsamling/fourier-rã¦kker"]
    "43formelsamling/fourier-tabeller" [label="formelsamling/fourier-tabeller"]
    "44formelsamling/fourier-transform" [label="formelsamling/fourier-transform"]
    "45formelsamling/fourier-function" [label="formelsamling/fourier-function"]
    "46formelsamling/frekvensrespons" [label="formelsamling/frekvensrespons"]
    "47formelsamling/greens-theorem" [label="formelsamling/greens-theorem"]
    "48formelsamling/heat-equation" [label="formelsamling/heat-equation"]
    "49formelsamling/higher-order-derivatives" [label="formelsamling/higher-order-derivatives"]
    "50formelsamling/impulsrespons" [label="formelsamling/impulsrespons"]
    "51formelsamling/invers-diskret-fourier-transformation" [label="formelsamling/invers-diskret-fourier-transformation"]
    "52formelsamling/invers-laplace-transformation" [label="formelsamling/invers-laplace-transformation"]
    "53formelsamling/koordinatsystemer" [label="formelsamling/koordinatsystemer"]
    "54formelsamling/laplace-transformation" [label="formelsamling/laplace-transformation"]
    "55formelsamling/level-curves" [label="formelsamling/level-curves"]
    "56formelsamling/limits-on-multivariable-functions" [label="formelsamling/limits-on-multivariable-functions"]
    "57formelsamling/line-or-curve-integral" [label="formelsamling/line-or-curve-integral"]
    "58formelsamling/lineã¦r-algebra" [label="formelsamling/lineã¦r-algebra"]
    "59formelsamling/lineã¦r-approximation" [label="formelsamling/lineã¦r-approximation"]
    "60formelsamling/matched-z-transformation" [label="formelsamling/matched-z-transformation"]
    "61formelsamling/middelvã¦rdier" [label="formelsamling/middelvã¦rdier"]
    "62formelsamling/overfã¸ringsfunktion" [label="formelsamling/overfã¸ringsfunktion"]
    "63formelsamling/rationelle-funktioner" [label="formelsamling/rationelle-funktioner"]
    "64formelsamling/regler" [label="formelsamling/regler"]
    "65formelsamling/stabilitet-i-et-system" [label="formelsamling/stabilitet-i-et-system"]
    "66formelsamling/superpositionsintegralet" [label="formelsamling/superpositionsintegralet"]
    "67formelsamling/surface-integrals" [label="formelsamling/surface-integrals"]
    "68formelsamling/tangent-plane" [label="formelsamling/tangent-plane"]
    "69formelsamling/taylor" [label="formelsamling/taylor"]
    "70formelsamling/triple-integration" [label="formelsamling/triple-integration"]
    "71formelsamling/vector-fields" [label="formelsamling/vector-fields"]
    "72formelsamling/vinduesfunktion" [label="formelsamling/vinduesfunktion"]
    "73formelsamling/wave-equation" [label="formelsamling/wave-equation"]
    "74formelsamling/z-transformation" [label="formelsamling/z-transformation"]
    "75misc/excalidraw/anden-ordens-differentiale-ligning" [label="misc/excalidraw/anden-ordens-differentiale-ligning"]
    "76misc/excalidraw/dh.excalidraw" [label="misc/excalidraw/dh.excalidraw"]
    "77misc/excalidraw/drawing-2022-12-24-16.19.33.excalidraw" [label="misc/excalidraw/drawing-2022-12-24-16.19.33.excalidraw"]
    "78misc/excalidraw/drawing-2023-01-04-11.51.19.excalidraw" [label="misc/excalidraw/drawing-2023-01-04-11.51.19.excalidraw"]
    "79misc/excalidraw/drawing-2023-01-04-12.45.14.excalidraw" [label="misc/excalidraw/drawing-2023-01-04-12.45.14.excalidraw"]
    "80misc/excalidraw/drawing-2023-01-04-13.36.23.excalidraw" [label="misc/excalidraw/drawing-2023-01-04-13.36.23.excalidraw"]
    "81misc/excalidraw/drawing-2023-01-07-13.36.12.excalidraw" [label="misc/excalidraw/drawing-2023-01-07-13.36.12.excalidraw"]
    "82misc/excalidraw/drawing-2023-01-08-11.58.53.excalidraw" [label="misc/excalidraw/drawing-2023-01-08-11.58.53.excalidraw"]
    "83misc/excalidraw/drawing-2023-01-17-16.10.09.excalidraw" [label="misc/excalidraw/drawing-2023-01-17-16.10.09.excalidraw"]
    "84misc/excalidraw/drawing-2023-02-08-15.30.46.excalidraw" [label="misc/excalidraw/drawing-2023-02-08-15.30.46.excalidraw"]
    "85misc/excalidraw/drawing-2023-03-21-11.32.24.excalidraw" [label="misc/excalidraw/drawing-2023-03-21-11.32.24.excalidraw"]
    "86misc/excalidraw/drawing-2023-04-12-16.12.54.excalidraw" [label="misc/excalidraw/drawing-2023-04-12-16.12.54.excalidraw"]
    "87misc/excalidraw/drawing-2023-04-24-12.22.17.excalidraw" [label="misc/excalidraw/drawing-2023-04-24-12.22.17.excalidraw"]
    "88misc/excalidraw/drawing-2023-04-24-12.37.17.excalidraw" [label="misc/excalidraw/drawing-2023-04-24-12.37.17.excalidraw"]
    "89misc/excalidraw/fysisk-pendul" [label="misc/excalidraw/fysisk-pendul"]
    "90misc/excalidraw/inertimoment-pã¥-pendul" [label="misc/excalidraw/inertimoment-pã¥-pendul"]
    "91misc/excalidraw/karnaugh-maps.excalidraw" [label="misc/excalidraw/karnaugh-maps.excalidraw"]
    "92misc/excalidraw/matematisk-pendul.excalidraw" [label="misc/excalidraw/matematisk-pendul.excalidraw"]
    "93misc/excalidraw/partialbrã¸ker" [label="misc/excalidraw/partialbrã¸ker"]
    "94misc/excalidraw/partielle-brã¸ker.excalidraw" [label="misc/excalidraw/partielle-brã¸ker.excalidraw"]
    "95misc/excalidraw/rotations-matrix-om-x-akse.excalidraw" [label="misc/excalidraw/rotations-matrix-om-x-akse.excalidraw"]
    "96misc/excalidraw/scripts/downloaded/set-dimensions" [label="misc/excalidraw/scripts/downloaded/set-dimensions"]
    "97misc/four-value-functions-2024-10-31-12.30.10.excalidraw" [label="misc/four-value-functions-2024-10-31-12.30.10.excalidraw"]
    "98projects/airmon-wifi-bruteforce" [label="projects/airmon-wifi-bruteforce"]
    "99projects/eink-calendar" [label="projects/eink-calendar"]
    "100readme" [label="readme"]
    "101templates/assignmenttemp" [label="templates/assignmenttemp"]
    "102templates/coursetemp" [label="templates/coursetemp"]
    "103templates/exercisetemp" [label="templates/exercisetemp"]
    "104templates/lectureslidetemp" [label="templates/lectureslidetemp"]
    "105templates/notetemp" [label="templates/notetemp"]
    "106templates/semestertemp" [label="templates/semestertemp"]
    "107templates/todo" [label="templates/todo"]
    "108templates/untitled" [label="templates/untitled"]
    "109todo/todo" [label="todo/todo"]
    "110uni/assignments/assignment-5-num" [label="uni/assignments/assignment-5-num"]
    "111uni/assignments/num-exercise-4" [label="uni/assignments/num-exercise-4"]
    "112uni/assignments/numerical-assignment-1" [label="uni/assignments/numerical-assignment-1"]
    "113uni/assignments/numerisk-assignment-2" [label="uni/assignments/numerisk-assignment-2"]
    "114uni/assignments/port3-numerisk" [label="uni/assignments/port3-numerisk"]
    "115uni/assignments/portfolio-1" [label="uni/assignments/portfolio-1"]
    "116uni/assignments/portfolio-2" [label="uni/assignments/portfolio-2"]
    "117uni/courses/algoritmer-og-datastruktur" [label="uni/courses/algoritmer-og-datastruktur"]
    "118uni/courses/bachelor" [label="uni/courses/bachelor"]
    "119uni/courses/c++" [label="uni/courses/c++"]
    "120uni/courses/calculus" [label="uni/courses/calculus"]
    "121uni/courses/computer-arkitektur" [label="uni/courses/computer-arkitektur"]
    "122uni/courses/computer-vision" [label="uni/courses/computer-vision"]
    "123uni/courses/control-of-autonomous-systems" [label="uni/courses/control-of-autonomous-systems"]
    "124uni/courses/data-kommunikation" [label="uni/courses/data-kommunikation"]
    "125uni/courses/datateknik" [label="uni/courses/datateknik"]
    "126uni/courses/digital-programmerbar-elektronik" [label="uni/courses/digital-programmerbar-elektronik"]
    "127uni/courses/droner" [label="uni/courses/droner"]
    "128uni/courses/elektro-fysik" [label="uni/courses/elektro-fysik"]
    "129uni/courses/embedded-systems" [label="uni/courses/embedded-systems"]
    "130uni/courses/forstaerkningsteknik" [label="uni/courses/forstaerkningsteknik"]
    "131uni/courses/freertos" [label="uni/courses/freertos"]
    "132uni/courses/individuel-studieaktivitet" [label="uni/courses/individuel-studieaktivitet"]
    "133uni/courses/indlejret-programmering" [label="uni/courses/indlejret-programmering"]
    "134uni/courses/introduction-to-embodied-artificial-intelligence" [label="uni/courses/introduction-to-embodied-artificial-intelligence"]
    "135uni/courses/kinematik" [label="uni/courses/kinematik"]
    "136uni/courses/kunstig-inteligens" [label="uni/courses/kunstig-inteligens"]
    "137uni/courses/linux-querks" [label="uni/courses/linux-querks"]
    "138uni/courses/matlab-&-mathematica" [label="uni/courses/matlab-&-mathematica"]
    "139uni/courses/multivariable-calculus" [label="uni/courses/multivariable-calculus"]
    "140uni/courses/multivariat-statistik" [label="uni/courses/multivariat-statistik"]
    "141uni/courses/numeriske-metoder" [label="uni/courses/numeriske-metoder"]
    "142uni/courses/reguleringsteknik" [label="uni/courses/reguleringsteknik"]
    "143uni/courses/robotics" [label="uni/courses/robotics"]
    "144uni/courses/robotters-fysik" [label="uni/courses/robotters-fysik"]
    "145uni/courses/scientific-method" [label="uni/courses/scientific-method"]
    "146uni/courses/signalbehandling" [label="uni/courses/signalbehandling"]
    "147uni/courses/softwareudvikling" [label="uni/courses/softwareudvikling"]
    "148uni/courses/statistik" [label="uni/courses/statistik"]
    "149uni/courses/untitled" [label="uni/courses/untitled"]
    "150uni/courses/videnskabsteori" [label="uni/courses/videnskabsteori"]
    "151uni/exercises/cholesky-&-lu-exercise" [label="uni/exercises/cholesky-&-lu-exercise"]
    "152uni/exercises/exercise-7-newton" [label="uni/exercises/exercise-7-newton"]
    "153uni/exercises/lu-decomposition-og-gaussian" [label="uni/exercises/lu-decomposition-og-gaussian"]
    "154uni/exercises/lecture-4-error-estimate" [label="uni/exercises/lecture-4-error-estimate"]
    "155uni/exercises/lecture-8-numerical-integration" [label="uni/exercises/lecture-8-numerical-integration"]
    "156uni/exercises/lecture1_task" [label="uni/exercises/lecture1_task"]
    "157uni/exercises/richardson-extrapolation-exercise" [label="uni/exercises/richardson-extrapolation-exercise"]
    "158uni/exercises/root-finding-exercise" [label="uni/exercises/root-finding-exercise"]
    "159uni/exercises/svd-exercise" [label="uni/exercises/svd-exercise"]
    "160uni/exercises/add-c-and-e" [label="uni/exercises/add-c-and-e"]
    "161uni/notes/1-formelsamlinger/c++-cheatsheet" [label="uni/notes/1-formelsamlinger/c++-cheatsheet"]
    "162uni/notes/1-formelsamlinger/elektro-formelsamling" [label="uni/notes/1-formelsamlinger/elektro-formelsamling"]
    "163uni/notes/1-formelsamlinger/formelsamling-calculus" [label="uni/notes/1-formelsamlinger/formelsamling-calculus"]
    "164uni/notes/1-formelsamlinger/formelsamling-fysik" [label="uni/notes/1-formelsamlinger/formelsamling-fysik"]
    "165uni/notes/1-formelsamlinger/formelsamling-kinematik" [label="uni/notes/1-formelsamlinger/formelsamling-kinematik"]
    "166uni/notes/1-formelsamlinger/matlab-addons" [label="uni/notes/1-formelsamlinger/matlab-addons"]
    "167uni/notes/1-formelsamlinger/sql-cheatsheet" [label="uni/notes/1-formelsamlinger/sql-cheatsheet"]
    "168uni/notes/algoritmer-og-datastruktur/assignments/stack-queue-and-balpar" [label="uni/notes/algoritmer-og-datastruktur/assignments/stack-queue-and-balpar"]
    "169uni/notes/algoritmer-og-datastruktur/eksamen" [label="uni/notes/algoritmer-og-datastruktur/eksamen"]
    "170uni/notes/algoritmer-og-datastruktur/gammel-eksamen/eksamen-1" [label="uni/notes/algoritmer-og-datastruktur/gammel-eksamen/eksamen-1"]
    "171uni/notes/algoritmer-og-datastruktur/gammel-eksamen/eksamen-2" [label="uni/notes/algoritmer-og-datastruktur/gammel-eksamen/eksamen-2"]
    "172uni/notes/algoritmer-og-datastruktur/lecture-notes/big-o-notation" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/big-o-notation"]
    "173uni/notes/algoritmer-og-datastruktur/lecture-notes/binary-tree" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/binary-tree"]
    "174uni/notes/algoritmer-og-datastruktur/lecture-notes/binary-trees-traversal" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/binary-trees-traversal"]
    "175uni/notes/algoritmer-og-datastruktur/lecture-notes/dijkstra-method" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/dijkstra-method"]
    "176uni/notes/algoritmer-og-datastruktur/lecture-notes/graphs" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/graphs"]
    "177uni/notes/algoritmer-og-datastruktur/lecture-notes/hashing" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/hashing"]
    "178uni/notes/algoritmer-og-datastruktur/lecture-notes/induktionsbeviser" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/induktionsbeviser"]
    "179uni/notes/algoritmer-og-datastruktur/lecture-notes/linked-lists" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/linked-lists"]
    "180uni/notes/algoritmer-og-datastruktur/lecture-notes/priorityqueing" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/priorityqueing"]
    "181uni/notes/algoritmer-og-datastruktur/lecture-notes/sorting" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/sorting"]
    "182uni/notes/algoritmer-og-datastruktur/lecture-notes/spanning-tree" [label="uni/notes/algoritmer-og-datastruktur/lecture-notes/spanning-tree"]
    "183uni/notes/bachelor/cbba-consensus-based-bundle-algorithm" [label="uni/notes/bachelor/cbba-consensus-based-bundle-algorithm"]
    "184uni/notes/bachelor/untitled" [label="uni/notes/bachelor/untitled"]
    "185uni/notes/c/arithmetic-operations" [label="uni/notes/c/arithmetic-operations"]
    "186uni/notes/c/arrays" [label="uni/notes/c/arrays"]
    "187uni/notes/c/bit-wise-logical-operations" [label="uni/notes/c/bit-wise-logical-operations"]
    "188uni/notes/c/data-types(variables)" [label="uni/notes/c/data-types(variables)"]
    "189uni/notes/c/interrupt/avr-interrupt" [label="uni/notes/c/interrupt/avr-interrupt"]
    "190uni/notes/c/interrupt/external-interrupt-register" [label="uni/notes/c/interrupt/external-interrupt-register"]
    "191uni/notes/c/interrupt/global-interrupt-enable" [label="uni/notes/c/interrupt/global-interrupt-enable"]
    "192uni/notes/c/interrupt/interrupt-addresses" [label="uni/notes/c/interrupt/interrupt-addresses"]
    "193uni/notes/c/interrupt/interrupt-example" [label="uni/notes/c/interrupt/interrupt-example"]
    "194uni/notes/c/interrupt/timer0-interrupt" [label="uni/notes/c/interrupt/timer0-interrupt"]
    "195uni/notes/c/interrupt/timer0" [label="uni/notes/c/interrupt/timer0"]
    "196uni/notes/c/pin-reader" [label="uni/notes/c/pin-reader"]
    "197uni/notes/c/structure-and-compilation" [label="uni/notes/c/structure-and-compilation"]
    "198uni/notes/c/tccr0-timer-counter-control-register" [label="uni/notes/c/tccr0-timer-counter-control-register"]
    "199uni/notes/c++/abstract-classes/abstract-classes" [label="uni/notes/c++/abstract-classes/abstract-classes"]
    "200uni/notes/c++/functions-and-stuff/arrays" [label="uni/notes/c++/functions-and-stuff/arrays"]
    "201uni/notes/c++/functions-and-stuff/boolean-operators" [label="uni/notes/c++/functions-and-stuff/boolean-operators"]
    "202uni/notes/c++/functions-and-stuff/casting" [label="uni/notes/c++/functions-and-stuff/casting"]
    "203uni/notes/c++/functions-and-stuff/classes" [label="uni/notes/c++/functions-and-stuff/classes"]
    "204uni/notes/c++/functions-and-stuff/const" [label="uni/notes/c++/functions-and-stuff/const"]
    "205uni/notes/c++/functions-and-stuff/header-guard" [label="uni/notes/c++/functions-and-stuff/header-guard"]
    "206uni/notes/c++/functions-and-stuff/hello-world" [label="uni/notes/c++/functions-and-stuff/hello-world"]
    "207uni/notes/c++/functions-and-stuff/if-while-for-loops" [label="uni/notes/c++/functions-and-stuff/if-while-for-loops"]
    "208uni/notes/c++/functions-and-stuff/memory(heap-and-stacks)" [label="uni/notes/c++/functions-and-stuff/memory(heap-and-stacks)"]
    "209uni/notes/c++/functions-and-stuff/namespace" [label="uni/notes/c++/functions-and-stuff/namespace"]
    "210uni/notes/c++/functions-and-stuff/pointers" [label="uni/notes/c++/functions-and-stuff/pointers"]
    "211uni/notes/c++/functions-and-stuff/reference-operator" [label="uni/notes/c++/functions-and-stuff/reference-operator"]
    "212uni/notes/c++/functions-and-stuff/references" [label="uni/notes/c++/functions-and-stuff/references"]
    "213uni/notes/c++/functions-and-stuff/smart-pointers" [label="uni/notes/c++/functions-and-stuff/smart-pointers"]
    "214uni/notes/c++/functions-and-stuff/streams" [label="uni/notes/c++/functions-and-stuff/streams"]
    "215uni/notes/c++/functions-and-stuff/strings" [label="uni/notes/c++/functions-and-stuff/strings"]
    "216uni/notes/c++/functions-and-stuff/struct" [label="uni/notes/c++/functions-and-stuff/struct"]
    "217uni/notes/c++/functions-and-stuff/enum-and-enum-class" [label="uni/notes/c++/functions-and-stuff/enum-and-enum-class"]
    "218uni/notes/c++/inheritance/derived-constructers" [label="uni/notes/c++/inheritance/derived-constructers"]
    "219uni/notes/c++/inheritance/inheritance" [label="uni/notes/c++/inheritance/inheritance"]
    "220uni/notes/c++/inheritance/virtual" [label="uni/notes/c++/inheritance/virtual"]
    "221uni/notes/c++/libraries/compile" [label="uni/notes/c++/libraries/compile"]
    "222uni/notes/c++/modbus/intro" [label="uni/notes/c++/modbus/intro"]
    "223uni/notes/c++/opencv/intro" [label="uni/notes/c++/opencv/intro"]
    "224uni/notes/c++/read-&-write-to-file/read-and-write-class-to-file-example" [label="uni/notes/c++/read-&-write-to-file/read-and-write-class-to-file-example"]
    "225uni/notes/c++/read-&-write-to-file/read-and-write-string-to-file-example" [label="uni/notes/c++/read-&-write-to-file/read-and-write-string-to-file-example"]
    "226uni/notes/calculus/eksamens-opgaver/februar-2021-opg-4.excalidraw" [label="uni/notes/calculus/eksamens-opgaver/februar-2021-opg-4.excalidraw"]
    "227uni/notes/calculus/eksamens-opgaver/maj-2021.excalidraw" [label="uni/notes/calculus/eksamens-opgaver/maj-2021.excalidraw"]
    "228uni/notes/calculus/exercises/de-moivre-w4-81" [label="uni/notes/calculus/exercises/de-moivre-w4-81"]
    "229uni/notes/calculus/exercises/de-moivre.excalidraw" [label="uni/notes/calculus/exercises/de-moivre.excalidraw"]
    "230uni/notes/calculus/exercises/drawing-2022-12-02-12.37.17.excalidraw" [label="uni/notes/calculus/exercises/drawing-2022-12-02-12.37.17.excalidraw"]
    "231uni/notes/calculus/exercises/drawing-2022-12-20-13.05.59.excalidraw" [label="uni/notes/calculus/exercises/drawing-2022-12-20-13.05.59.excalidraw"]
    "232uni/notes/calculus/exercises/drawing-2022-12-20-23.04.31.excalidraw" [label="uni/notes/calculus/exercises/drawing-2022-12-20-23.04.31.excalidraw"]
    "233uni/notes/calculus/exercises/eksamensopgaver.excalidraw" [label="uni/notes/calculus/exercises/eksamensopgaver.excalidraw"]
    "234uni/notes/calculus/exercises/plottes" [label="uni/notes/calculus/exercises/plottes"]
    "235uni/notes/calculus/lecture-notes/1.-ordens-differentialeligninger" [label="uni/notes/calculus/lecture-notes/1.-ordens-differentialeligninger"]
    "236uni/notes/calculus/lecture-notes/calculus-noter" [label="uni/notes/calculus/lecture-notes/calculus-noter"]
    "237uni/notes/calculus/lecture-notes/differensligninger-og-dæmpede-svingninger" [label="uni/notes/calculus/lecture-notes/differensligninger-og-dæmpede-svingninger"]
    "238uni/notes/calculus/lecture-notes/gauss-elimination" [label="uni/notes/calculus/lecture-notes/gauss-elimination"]
    "239uni/notes/calculus/lecture-notes/generelle-formler" [label="uni/notes/calculus/lecture-notes/generelle-formler"]
    "240uni/notes/calculus/lecture-notes/koblede-diff-ligninger" [label="uni/notes/calculus/lecture-notes/koblede-diff-ligninger"]
    "241uni/notes/calculus/lecture-notes/kordinatsystemer/cylendrical-cordinates" [label="uni/notes/calculus/lecture-notes/kordinatsystemer/cylendrical-cordinates"]
    "242uni/notes/calculus/lecture-notes/kordinatsystemer/polar-cordinates" [label="uni/notes/calculus/lecture-notes/kordinatsystemer/polar-cordinates"]
    "243uni/notes/calculus/lecture-notes/kordinatsystemer/spherical-cordinates" [label="uni/notes/calculus/lecture-notes/kordinatsystemer/spherical-cordinates"]
    "244uni/notes/calculus/lecture-notes/ligningssystemer" [label="uni/notes/calculus/lecture-notes/ligningssystemer"]
    "245uni/notes/calculus/lecture-notes/linear-algebra-og-matrice-opgaver" [label="uni/notes/calculus/lecture-notes/linear-algebra-og-matrice-opgaver"]
    "246uni/notes/calculus/lecture-notes/matricer" [label="uni/notes/calculus/lecture-notes/matricer"]
    "247uni/notes/calculus/lecture-notes/middelvã¦rdier" [label="uni/notes/calculus/lecture-notes/middelvã¦rdier"]
    "248uni/notes/calculus/lecture-notes/partial-differential-equations" [label="uni/notes/calculus/lecture-notes/partial-differential-equations"]
    "249uni/notes/calculus/lecture-notes/specielle-matricer" [label="uni/notes/calculus/lecture-notes/specielle-matricer"]
    "250uni/notes/calculus/lecture-notes/ulige-funktioner" [label="uni/notes/calculus/lecture-notes/ulige-funktioner"]
    "251uni/notes/computer-arkitektur/noter/deadlocks/bankers-algorithm" [label="uni/notes/computer-arkitektur/noter/deadlocks/bankers-algorithm"]
    "252uni/notes/computer-arkitektur/noter/deadlocks/deadlock-detection" [label="uni/notes/computer-arkitektur/noter/deadlocks/deadlock-detection"]
    "253uni/notes/computer-arkitektur/noter/deadlocks/deadlock-prevention" [label="uni/notes/computer-arkitektur/noter/deadlocks/deadlock-prevention"]
    "254uni/notes/computer-arkitektur/noter/deadlocks/deadlock-recovery" [label="uni/notes/computer-arkitektur/noter/deadlocks/deadlock-recovery"]
    "255uni/notes/computer-arkitektur/noter/deadlocks/deadlock-situations" [label="uni/notes/computer-arkitektur/noter/deadlocks/deadlock-situations"]
    "256uni/notes/computer-arkitektur/noter/deadlocks/managing-deadlocks" [label="uni/notes/computer-arkitektur/noter/deadlocks/managing-deadlocks"]
    "257uni/notes/computer-arkitektur/noter/deadlocks/resource-allocation-algorithm" [label="uni/notes/computer-arkitektur/noter/deadlocks/resource-allocation-algorithm"]
    "258uni/notes/computer-arkitektur/noter/deadlocks/resource-allocation" [label="uni/notes/computer-arkitektur/noter/deadlocks/resource-allocation"]
    "259uni/notes/computer-arkitektur/noter/deadlocks/safe-state" [label="uni/notes/computer-arkitektur/noter/deadlocks/safe-state"]
    "260uni/notes/computer-arkitektur/noter/ijvm/ijvm-implementation" [label="uni/notes/computer-arkitektur/noter/ijvm/ijvm-implementation"]
    "261uni/notes/computer-arkitektur/noter/ijvm/ijvm-implementation-in-mic-1" [label="uni/notes/computer-arkitektur/noter/ijvm/ijvm-implementation-in-mic-1"]
    "262uni/notes/computer-arkitektur/noter/ijvm/ijvm-instruction-set" [label="uni/notes/computer-arkitektur/noter/ijvm/ijvm-instruction-set"]
    "263uni/notes/computer-arkitektur/noter/mal-(micro-assembly-language)/mal-(micro-assembly-language)" [label="uni/notes/computer-arkitektur/noter/mal-(micro-assembly-language)/mal-(micro-assembly-language)"]
    "264uni/notes/computer-arkitektur/noter/mal-(micro-assembly-language)/modification-of-the-data-path" [label="uni/notes/computer-arkitektur/noter/mal-(micro-assembly-language)/modification-of-the-data-path"]
    "265uni/notes/computer-arkitektur/noter/mal-(micro-assembly-language)/optimization-of-the-microcode" [label="uni/notes/computer-arkitektur/noter/mal-(micro-assembly-language)/optimization-of-the-microcode"]
    "266uni/notes/computer-arkitektur/noter/memory/address-binding" [label="uni/notes/computer-arkitektur/noter/memory/address-binding"]
    "267uni/notes/computer-arkitektur/noter/memory/basic-hardware" [label="uni/notes/computer-arkitektur/noter/memory/basic-hardware"]
    "268uni/notes/computer-arkitektur/noter/memory/logical-and-physical-address-space" [label="uni/notes/computer-arkitektur/noter/memory/logical-and-physical-address-space"]
    "269uni/notes/computer-arkitektur/noter/memory/memory-interface/amd-processor-16-bit-(am186em)" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/amd-processor-16-bit-(am186em)"]
    "270uni/notes/computer-arkitektur/noter/memory/memory-interface/atmega128l-external-memory" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/atmega128l-external-memory"]
    "271uni/notes/computer-arkitektur/noter/memory/memory-interface/address-demultiplexer" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/address-demultiplexer"]
    "272uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface-16-bit" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface-16-bit"]
    "273uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface-8-bit" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface-8-bit"]
    "274uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface-wait-state" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface-wait-state"]
    "275uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface" [label="uni/notes/computer-arkitektur/noter/memory/memory-interface/memory-interface"]
    "276uni/notes/computer-arkitektur/noter/memory/memory-management-optimization" [label="uni/notes/computer-arkitektur/noter/memory/memory-management-optimization"]
    "277uni/notes/computer-arkitektur/noter/memory/non-uniform-memory-access-(numa)" [label="uni/notes/computer-arkitektur/noter/memory/non-uniform-memory-access-(numa)"]
    "278uni/notes/computer-arkitektur/noter/memory/paging" [label="uni/notes/computer-arkitektur/noter/memory/paging"]
    "279uni/notes/computer-arkitektur/noter/memory/protection" [label="uni/notes/computer-arkitektur/noter/memory/protection"]
    "280uni/notes/computer-arkitektur/noter/memory/round-robin" [label="uni/notes/computer-arkitektur/noter/memory/round-robin"]
    "281uni/notes/computer-arkitektur/noter/memory/segmentation" [label="uni/notes/computer-arkitektur/noter/memory/segmentation"]
    "282uni/notes/computer-arkitektur/noter/micro-architecture-level/cache" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/cache"]
    "283uni/notes/computer-arkitektur/noter/micro-architecture-level/data-path-timing" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/data-path-timing"]
    "284uni/notes/computer-arkitektur/noter/micro-architecture-level/ifu-(instruction-fetch-unit)" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/ifu-(instruction-fetch-unit)"]
    "285uni/notes/computer-arkitektur/noter/micro-architecture-level/ijvm-instruction-set" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/ijvm-instruction-set"]
    "286uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-1" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-1"]
    "287uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-2" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-2"]
    "288uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-3" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-3"]
    "289uni/notes/computer-arkitektur/noter/micro-architecture-level/mir-(micro-instructions-register)" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/mir-(micro-instructions-register)"]
    "290uni/notes/computer-arkitektur/noter/micro-architecture-level/memory-access-timing" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/memory-access-timing"]
    "291uni/notes/computer-arkitektur/noter/micro-architecture-level/memory-operation" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/memory-operation"]
    "292uni/notes/computer-arkitektur/noter/micro-architecture-level/micro-architecture-level" [label="uni/notes/computer-arkitektur/noter/micro-architecture-level/micro-architecture-level"]
    "293uni/notes/computer-arkitektur/noter/paging/allocation-of-frames" [label="uni/notes/computer-arkitektur/noter/paging/allocation-of-frames"]
    "294uni/notes/computer-arkitektur/noter/paging/copy-on-write" [label="uni/notes/computer-arkitektur/noter/paging/copy-on-write"]
    "295uni/notes/computer-arkitektur/noter/paging/demand-paging" [label="uni/notes/computer-arkitektur/noter/paging/demand-paging"]
    "296uni/notes/computer-arkitektur/noter/paging/loaclity" [label="uni/notes/computer-arkitektur/noter/paging/loaclity"]
    "297uni/notes/computer-arkitektur/noter/paging/page-buffering-algorithm" [label="uni/notes/computer-arkitektur/noter/paging/page-buffering-algorithm"]
    "298uni/notes/computer-arkitektur/noter/paging/page-fault-frequency" [label="uni/notes/computer-arkitektur/noter/paging/page-fault-frequency"]
    "299uni/notes/computer-arkitektur/noter/paging/page-replacing" [label="uni/notes/computer-arkitektur/noter/paging/page-replacing"]
    "300uni/notes/computer-arkitektur/noter/paging/thrashing" [label="uni/notes/computer-arkitektur/noter/paging/thrashing"]
    "301uni/notes/computer-arkitektur/noter/process-synchronization/atomic-acces" [label="uni/notes/computer-arkitektur/noter/process-synchronization/atomic-acces"]
    "302uni/notes/computer-arkitektur/noter/process-synchronization/bounded-buffer" [label="uni/notes/computer-arkitektur/noter/process-synchronization/bounded-buffer"]
    "303uni/notes/computer-arkitektur/noter/process-synchronization/condition-variable" [label="uni/notes/computer-arkitektur/noter/process-synchronization/condition-variable"]
    "304uni/notes/computer-arkitektur/noter/process-synchronization/consumer" [label="uni/notes/computer-arkitektur/noter/process-synchronization/consumer"]
    "305uni/notes/computer-arkitektur/noter/process-synchronization/deadlock" [label="uni/notes/computer-arkitektur/noter/process-synchronization/deadlock"]
    "306uni/notes/computer-arkitektur/noter/process-synchronization/dining-philosophers-problem" [label="uni/notes/computer-arkitektur/noter/process-synchronization/dining-philosophers-problem"]
    "307uni/notes/computer-arkitektur/noter/process-synchronization/monitors" [label="uni/notes/computer-arkitektur/noter/process-synchronization/monitors"]
    "308uni/notes/computer-arkitektur/noter/process-synchronization/process-synchronization" [label="uni/notes/computer-arkitektur/noter/process-synchronization/process-synchronization"]
    "309uni/notes/computer-arkitektur/noter/process-synchronization/producer" [label="uni/notes/computer-arkitektur/noter/process-synchronization/producer"]
    "310uni/notes/computer-arkitektur/noter/process-synchronization/race-condition" [label="uni/notes/computer-arkitektur/noter/process-synchronization/race-condition"]
    "311uni/notes/computer-arkitektur/noter/process-synchronization/readers-writers-problem" [label="uni/notes/computer-arkitektur/noter/process-synchronization/readers-writers-problem"]
    "312uni/notes/computer-arkitektur/noter/process-synchronization/semaphore" [label="uni/notes/computer-arkitektur/noter/process-synchronization/semaphore"]
    "313uni/notes/computer-arkitektur/noter/spi/spi-protocol" [label="uni/notes/computer-arkitektur/noter/spi/spi-protocol"]
    "314uni/notes/computer-arkitektur/noter/spi/spi-registers" [label="uni/notes/computer-arkitektur/noter/spi/spi-registers"]
    "315uni/notes/computer-arkitektur/noter/spi/spi-setup" [label="uni/notes/computer-arkitektur/noter/spi/spi-setup"]
    "316uni/notes/computer-arkitektur/noter/simple-computer-model/cisc" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/cisc"]
    "317uni/notes/computer-arkitektur/noter/simple-computer-model/designs-of-instruction-load" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/designs-of-instruction-load"]
    "318uni/notes/computer-arkitektur/noter/simple-computer-model/instruction-on-set-design" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/instruction-on-set-design"]
    "319uni/notes/computer-arkitektur/noter/simple-computer-model/program-execution-of-the-load-instruction" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/program-execution-of-the-load-instruction"]
    "320uni/notes/computer-arkitektur/noter/simple-computer-model/simple-computer-model-instructions" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/simple-computer-model-instructions"]
    "321uni/notes/computer-arkitektur/noter/simple-computer-model/simple-computer-model" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/simple-computer-model"]
    "322uni/notes/computer-arkitektur/noter/simple-computer-model/simple-computer-model-(a-program-example)" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/simple-computer-model-(a-program-example)"]
    "323uni/notes/computer-arkitektur/noter/simple-computer-model/the-control-unit" [label="uni/notes/computer-arkitektur/noter/simple-computer-model/the-control-unit"]
    "324uni/notes/computer-arkitektur/noter/virtual-memory/virtual-memory-basics" [label="uni/notes/computer-arkitektur/noter/virtual-memory/virtual-memory-basics"]
    "325uni/notes/computer-arkitektur/noter/virtual-memory/virtual-space-address" [label="uni/notes/computer-arkitektur/noter/virtual-memory/virtual-space-address"]
    "326uni/notes/computer-arkitektur/noter/von-neumann-architecture/pentium-ii-motherboard" [label="uni/notes/computer-arkitektur/noter/von-neumann-architecture/pentium-ii-motherboard"]
    "327uni/notes/computer-arkitektur/noter/von-neumann-architecture/von-neumann-architecture" [label="uni/notes/computer-arkitektur/noter/von-neumann-architecture/von-neumann-architecture"]
    "328uni/notes/computer-vision/book" [label="uni/notes/computer-vision/book"]
    "329uni/notes/computer-vision/ground-sample-distance-(gsd)" [label="uni/notes/computer-vision/ground-sample-distance-(gsd)"]
    "330uni/notes/data-kommunikation/noter/access/controlled-access/channelization" [label="uni/notes/data-kommunikation/noter/access/controlled-access/channelization"]
    "331uni/notes/data-kommunikation/noter/access/controlled-access/polling" [label="uni/notes/data-kommunikation/noter/access/controlled-access/polling"]
    "332uni/notes/data-kommunikation/noter/access/controlled-access/reservation" [label="uni/notes/data-kommunikation/noter/access/controlled-access/reservation"]
    "333uni/notes/data-kommunikation/noter/access/controlled-access/untitled" [label="uni/notes/data-kommunikation/noter/access/controlled-access/untitled"]
    "334uni/notes/data-kommunikation/noter/access/media-access-control/aloha" [label="uni/notes/data-kommunikation/noter/access/media-access-control/aloha"]
    "335uni/notes/data-kommunikation/noter/access/media-access-control/csma-or-cd" [label="uni/notes/data-kommunikation/noter/access/media-access-control/csma-or-cd"]
    "336uni/notes/data-kommunikation/noter/access/media-access-control/csma" [label="uni/notes/data-kommunikation/noter/access/media-access-control/csma"]
    "337uni/notes/data-kommunikation/noter/access/media-access-control/media-access-control" [label="uni/notes/data-kommunikation/noter/access/media-access-control/media-access-control"]
    "338uni/notes/data-kommunikation/noter/access/media-access-control/random-access" [label="uni/notes/data-kommunikation/noter/access/media-access-control/random-access"]
    "339uni/notes/data-kommunikation/noter/can-networks/can-frames" [label="uni/notes/data-kommunikation/noter/can-networks/can-frames"]
    "340uni/notes/data-kommunikation/noter/can-networks/can-physical-and-data-link-layer" [label="uni/notes/data-kommunikation/noter/can-networks/can-physical-and-data-link-layer"]
    "341uni/notes/data-kommunikation/noter/can-networks/can-â-controller-area-network" [label="uni/notes/data-kommunikation/noter/can-networks/can-â-controller-area-network"]
    "342uni/notes/data-kommunikation/noter/can-networks/error-detection-mechanisms" [label="uni/notes/data-kommunikation/noter/can-networks/error-detection-mechanisms"]
    "343uni/notes/data-kommunikation/noter/data-links-layers/arp-address-resolution-protocol" [label="uni/notes/data-kommunikation/noter/data-links-layers/arp-address-resolution-protocol"]
    "344uni/notes/data-kommunikation/noter/data-links-layers/arp-request-reply-example" [label="uni/notes/data-kommunikation/noter/data-links-layers/arp-request-reply-example"]
    "345uni/notes/data-kommunikation/noter/data-links-layers/arp-package-format" [label="uni/notes/data-kommunikation/noter/data-links-layers/arp-package-format"]
    "346uni/notes/data-kommunikation/noter/data-links-layers/bit-error-detection" [label="uni/notes/data-kommunikation/noter/data-links-layers/bit-error-detection"]
    "347uni/notes/data-kommunikation/noter/data-links-layers/block-coding" [label="uni/notes/data-kommunikation/noter/data-links-layers/block-coding"]
    "348uni/notes/data-kommunikation/noter/data-links-layers/burst-error" [label="uni/notes/data-kommunikation/noter/data-links-layers/burst-error"]
    "349uni/notes/data-kommunikation/noter/data-links-layers/communication-example" [label="uni/notes/data-kommunikation/noter/data-links-layers/communication-example"]
    "350uni/notes/data-kommunikation/noter/data-links-layers/cyclic-codes" [label="uni/notes/data-kommunikation/noter/data-links-layers/cyclic-codes"]
    "351uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/bit-oriented-framing" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/bit-oriented-framing"]
    "352uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/character-oriented-framing" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/character-oriented-framing"]
    "353uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/data-link-control-dlc" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/data-link-control-dlc"]
    "354uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/finite-state-machine-(fsm)" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/finite-state-machine-(fsm)"]
    "355uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/flow-and-error-control" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/flow-and-error-control"]
    "356uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/framing" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-control-dlc/framing"]
    "357uni/notes/data-kommunikation/noter/data-links-layers/data-link-layer" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-link-layer"]
    "358uni/notes/data-kommunikation/noter/data-links-layers/data-polynomial" [label="uni/notes/data-kommunikation/noter/data-links-layers/data-polynomial"]
    "359uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/asynchronous-balanced-mode-(abm)" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/asynchronous-balanced-mode-(abm)"]
    "360uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/example-p-f-bit" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/example-p-f-bit"]
    "361uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/address-field" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/address-field"]
    "362uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/control-field" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/control-field"]
    "363uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/fcs-field" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/fcs-field"]
    "364uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/flag-fields" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/flag-fields"]
    "365uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/hdlc-connect-and-disconnect" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/hdlc-connect-and-disconnect"]
    "366uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/information-field" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-fields/information-field"]
    "367uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-frames-â-three-types" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/hdlc-frames-â-three-types"]
    "368uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/high-level-data-link-control-(hdlc)" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/high-level-data-link-control-(hdlc)"]
    "369uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/normal-response-mode-(nrm)" [label="uni/notes/data-kommunikation/noter/data-links-layers/high-level-data-link-control/normal-response-mode-(nrm)"]
    "370uni/notes/data-kommunikation/noter/data-links-layers/link-layer-addressing" [label="uni/notes/data-kommunikation/noter/data-links-layers/link-layer-addressing"]
    "371uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/link-control-protocol" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/link-control-protocol"]
    "372uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/multiplexing" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/multiplexing"]
    "373uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-data-from-the-network-layer" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-data-from-the-network-layer"]
    "374uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-example" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-example"]
    "375uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-frame-format" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-frame-format"]
    "376uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-multilink" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-multilink"]
    "377uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-network-control-protocols" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-network-control-protocols"]
    "378uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-transition-phases" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/ppp-transition-phases"]
    "379uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/point-topoint-protocol-(ppp)" [label="uni/notes/data-kommunikation/noter/data-links-layers/point-to-point-protocol-(ppp)/point-topoint-protocol-(ppp)"]
    "380uni/notes/data-kommunikation/noter/data-links-layers/protocols/piggybacking" [label="uni/notes/data-kommunikation/noter/data-links-layers/protocols/piggybacking"]
    "381uni/notes/data-kommunikation/noter/data-links-layers/protocols/simple-protocol" [label="uni/notes/data-kommunikation/noter/data-links-layers/protocols/simple-protocol"]
    "382uni/notes/data-kommunikation/noter/data-links-layers/protocols/stop-and-wait" [label="uni/notes/data-kommunikation/noter/data-links-layers/protocols/stop-and-wait"]
    "383uni/notes/data-kommunikation/noter/data-links-layers/services" [label="uni/notes/data-kommunikation/noter/data-links-layers/services"]
    "384uni/notes/data-kommunikation/noter/data-links-layers/single-bit-error" [label="uni/notes/data-kommunikation/noter/data-links-layers/single-bit-error"]
    "385uni/notes/data-kommunikation/noter/data-links-layers/three-types-of-addresses" [label="uni/notes/data-kommunikation/noter/data-links-layers/three-types-of-addresses"]
    "386uni/notes/data-kommunikation/noter/data-links-layers/two-categories-of-links" [label="uni/notes/data-kommunikation/noter/data-links-layers/two-categories-of-links"]
    "387uni/notes/data-kommunikation/noter/ethernet/addressing" [label="uni/notes/data-kommunikation/noter/ethernet/addressing"]
    "388uni/notes/data-kommunikation/noter/ethernet/brigdet-ethernet" [label="uni/notes/data-kommunikation/noter/ethernet/brigdet-ethernet"]
    "389uni/notes/data-kommunikation/noter/ethernet/encoding" [label="uni/notes/data-kommunikation/noter/ethernet/encoding"]
    "390uni/notes/data-kommunikation/noter/ethernet/fast-ethernet" [label="uni/notes/data-kommunikation/noter/ethernet/fast-ethernet"]
    "391uni/notes/data-kommunikation/noter/ethernet/full-duplex-switched-ethernet" [label="uni/notes/data-kommunikation/noter/ethernet/full-duplex-switched-ethernet"]
    "392uni/notes/data-kommunikation/noter/ethernet/gigabit-ethernet-encoding" [label="uni/notes/data-kommunikation/noter/ethernet/gigabit-ethernet-encoding"]
    "393uni/notes/data-kommunikation/noter/ethernet/gigabit-ethernet" [label="uni/notes/data-kommunikation/noter/ethernet/gigabit-ethernet"]
    "394uni/notes/data-kommunikation/noter/ethernet/gigabit-physical-layer" [label="uni/notes/data-kommunikation/noter/ethernet/gigabit-physical-layer"]
    "395uni/notes/data-kommunikation/noter/ethernet/ieee-standard-ethernet" [label="uni/notes/data-kommunikation/noter/ethernet/ieee-standard-ethernet"]
    "396uni/notes/data-kommunikation/noter/ethernet/mac" [label="uni/notes/data-kommunikation/noter/ethernet/mac"]
    "397uni/notes/data-kommunikation/noter/ethernet/physical-layer" [label="uni/notes/data-kommunikation/noter/ethernet/physical-layer"]
    "398uni/notes/data-kommunikation/noter/ethernet/switched-ethernet" [label="uni/notes/data-kommunikation/noter/ethernet/switched-ethernet"]
    "399uni/notes/data-kommunikation/noter/ethernet/unicast-multicast-and-broadcast-addresses" [label="uni/notes/data-kommunikation/noter/ethernet/unicast-multicast-and-broadcast-addresses"]
    "400uni/notes/data-kommunikation/noter/line-coding/bipolar-ami-&-pseudoternary" [label="uni/notes/data-kommunikation/noter/line-coding/bipolar-ami-&-pseudoternary"]
    "401uni/notes/data-kommunikation/noter/line-coding/line-coding-schemes" [label="uni/notes/data-kommunikation/noter/line-coding/line-coding-schemes"]
    "402uni/notes/data-kommunikation/noter/line-coding/line-coding" [label="uni/notes/data-kommunikation/noter/line-coding/line-coding"]
    "403uni/notes/data-kommunikation/noter/line-coding/multilevel/4d-pam5" [label="uni/notes/data-kommunikation/noter/line-coding/multilevel/4d-pam5"]
    "404uni/notes/data-kommunikation/noter/line-coding/multilevel/8b6t" [label="uni/notes/data-kommunikation/noter/line-coding/multilevel/8b6t"]
    "405uni/notes/data-kommunikation/noter/line-coding/multilevel/definittion-2b1q" [label="uni/notes/data-kommunikation/noter/line-coding/multilevel/definittion-2b1q"]
    "406uni/notes/data-kommunikation/noter/line-coding/multilevel/multitransition-mlt-3" [label="uni/notes/data-kommunikation/noter/line-coding/multilevel/multitransition-mlt-3"]
    "407uni/notes/data-kommunikation/noter/line-coding/polar-manchester-and-differentiel-manchester" [label="uni/notes/data-kommunikation/noter/line-coding/polar-manchester-and-differentiel-manchester"]
    "408uni/notes/data-kommunikation/noter/line-coding/polar-nrz" [label="uni/notes/data-kommunikation/noter/line-coding/polar-nrz"]
    "409uni/notes/data-kommunikation/noter/line-coding/polar-rz" [label="uni/notes/data-kommunikation/noter/line-coding/polar-rz"]
    "410uni/notes/data-kommunikation/noter/line-coding/unipolar-nrz" [label="uni/notes/data-kommunikation/noter/line-coding/unipolar-nrz"]
    "411uni/notes/data-kommunikation/noter/network-layer/address-aggregation" [label="uni/notes/data-kommunikation/noter/network-layer/address-aggregation"]
    "412uni/notes/data-kommunikation/noter/network-layer/connectionless-service" [label="uni/notes/data-kommunikation/noter/network-layer/connectionless-service"]
    "413uni/notes/data-kommunikation/noter/network-layer/dhcp-dynamic-host-configuration-protocol" [label="uni/notes/data-kommunikation/noter/network-layer/dhcp-dynamic-host-configuration-protocol"]
    "414uni/notes/data-kommunikation/noter/network-layer/debuggin-tools" [label="uni/notes/data-kommunikation/noter/network-layer/debuggin-tools"]
    "415uni/notes/data-kommunikation/noter/network-layer/forwarding-of-ip-packets" [label="uni/notes/data-kommunikation/noter/network-layer/forwarding-of-ip-packets"]
    "416uni/notes/data-kommunikation/noter/network-layer/fragmentation" [label="uni/notes/data-kommunikation/noter/network-layer/fragmentation"]
    "417uni/notes/data-kommunikation/noter/network-layer/geographical-routing" [label="uni/notes/data-kommunikation/noter/network-layer/geographical-routing"]
    "418uni/notes/data-kommunikation/noter/network-layer/hop-and-ttl" [label="uni/notes/data-kommunikation/noter/network-layer/hop-and-ttl"]
    "419uni/notes/data-kommunikation/noter/network-layer/hierarchical-routing" [label="uni/notes/data-kommunikation/noter/network-layer/hierarchical-routing"]
    "420uni/notes/data-kommunikation/noter/network-layer/icmpv4-query-messages" [label="uni/notes/data-kommunikation/noter/network-layer/icmpv4-query-messages"]
    "421uni/notes/data-kommunikation/noter/network-layer/icmpv4" [label="uni/notes/data-kommunikation/noter/network-layer/icmpv4"]
    "422uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-addressing" [label="uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-addressing"]
    "423uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-cecksum" [label="uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-cecksum"]
    "424uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-datagrams" [label="uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-datagrams"]
    "425uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-network-addressing" [label="uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4-network-addressing"]
    "426uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4" [label="uni/notes/data-kommunikation/noter/network-layer/ipv4/ipv4"]
    "427uni/notes/data-kommunikation/noter/network-layer/ipv6/icmpv6-protocol" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/icmpv6-protocol"]
    "428uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv4-to-ipv6" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv4-to-ipv6"]
    "429uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-address-mapping" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-address-mapping"]
    "430uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-addressing" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-addressing"]
    "431uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-autoconfiguration" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-autoconfiguration"]
    "432uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-blocks" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-blocks"]
    "433uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-extension-headers" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-extension-headers"]
    "434uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-flow-label" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-flow-label"]
    "435uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-protocol" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-protocol"]
    "436uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-special-addresses" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6-special-addresses"]
    "437uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6" [label="uni/notes/data-kommunikation/noter/network-layer/ipv6/ipv6"]
    "438uni/notes/data-kommunikation/noter/network-layer/logical-addressing" [label="uni/notes/data-kommunikation/noter/network-layer/logical-addressing"]
    "439uni/notes/data-kommunikation/noter/network-layer/multi-protocol-label-switching-(mpls)" [label="uni/notes/data-kommunikation/noter/network-layer/multi-protocol-label-switching-(mpls)"]
    "440uni/notes/data-kommunikation/noter/network-layer/network-address-translation-nat" [label="uni/notes/data-kommunikation/noter/network-layer/network-address-translation-nat"]
    "441uni/notes/data-kommunikation/noter/network-layer/network-congestion-control" [label="uni/notes/data-kommunikation/noter/network-layer/network-congestion-control"]
    "442uni/notes/data-kommunikation/noter/network-layer/network-connection-oriented-service" [label="uni/notes/data-kommunikation/noter/network-layer/network-connection-oriented-service"]
    "443uni/notes/data-kommunikation/noter/network-layer/network-error-control" [label="uni/notes/data-kommunikation/noter/network-layer/network-error-control"]
    "444uni/notes/data-kommunikation/noter/network-layer/network-flow-control" [label="uni/notes/data-kommunikation/noter/network-layer/network-flow-control"]
    "445uni/notes/data-kommunikation/noter/network-layer/network-forwarding-mechanism" [label="uni/notes/data-kommunikation/noter/network-layer/network-forwarding-mechanism"]
    "446uni/notes/data-kommunikation/noter/network-layer/network-layer" [label="uni/notes/data-kommunikation/noter/network-layer/network-layer"]
    "447uni/notes/data-kommunikation/noter/network-layer/network-perfomance" [label="uni/notes/data-kommunikation/noter/network-layer/network-perfomance"]
    "448uni/notes/data-kommunikation/noter/network-layer/network-quality-of-service-(qos)" [label="uni/notes/data-kommunikation/noter/network-layer/network-quality-of-service-(qos)"]
    "449uni/notes/data-kommunikation/noter/network-layer/network-security" [label="uni/notes/data-kommunikation/noter/network-layer/network-security"]
    "450uni/notes/data-kommunikation/noter/network-layer/routing-and-forwarding" [label="uni/notes/data-kommunikation/noter/network-layer/routing-and-forwarding"]
    "451uni/notes/data-kommunikation/noter/network-layer/tcp-(transmission-control-protocol)" [label="uni/notes/data-kommunikation/noter/network-layer/tcp-(transmission-control-protocol)"]
    "452uni/notes/data-kommunikation/noter/network-layer/udp-(user-datagram-protocol)" [label="uni/notes/data-kommunikation/noter/network-layer/udp-(user-datagram-protocol)"]
    "453uni/notes/data-kommunikation/noter/noise/noiseless-channel" [label="uni/notes/data-kommunikation/noter/noise/noiseless-channel"]
    "454uni/notes/data-kommunikation/noter/noise/noisy-channel-shannon-capacity" [label="uni/notes/data-kommunikation/noter/noise/noisy-channel-shannon-capacity"]
    "455uni/notes/data-kommunikation/noter/noise/snr-signal-to-noice-ratio" [label="uni/notes/data-kommunikation/noter/noise/snr-signal-to-noice-ratio"]
    "456uni/notes/data-kommunikation/noter/noise/signal-rate" [label="uni/notes/data-kommunikation/noter/noise/signal-rate"]
    "457uni/notes/data-kommunikation/noter/noise/transmission-distrortion" [label="uni/notes/data-kommunikation/noter/noise/transmission-distrortion"]
    "458uni/notes/data-kommunikation/noter/osi-model" [label="uni/notes/data-kommunikation/noter/osi-model"]
    "459uni/notes/data-kommunikation/noter/protocols" [label="uni/notes/data-kommunikation/noter/protocols"]
    "460uni/notes/data-kommunikation/noter/transmission-impairment/attenuation" [label="uni/notes/data-kommunikation/noter/transmission-impairment/attenuation"]
    "461uni/notes/data-kommunikation/noter/transport-layer/bidirectional-protocols" [label="uni/notes/data-kommunikation/noter/transport-layer/bidirectional-protocols"]
    "462uni/notes/data-kommunikation/noter/transport-layer/connectionless-and-connectionâoriented-service" [label="uni/notes/data-kommunikation/noter/transport-layer/connectionless-and-connectionâoriented-service"]
    "463uni/notes/data-kommunikation/noter/transport-layer/go-back-n-protocol" [label="uni/notes/data-kommunikation/noter/transport-layer/go-back-n-protocol"]
    "464uni/notes/data-kommunikation/noter/transport-layer/protocols" [label="uni/notes/data-kommunikation/noter/transport-layer/protocols"]
    "465uni/notes/data-kommunikation/noter/transport-layer/sctp-(stream-control-transmission-protocol)" [label="uni/notes/data-kommunikation/noter/transport-layer/sctp-(stream-control-transmission-protocol)"]
    "466uni/notes/data-kommunikation/noter/transport-layer/snmp-(simple-network-management-protocol)" [label="uni/notes/data-kommunikation/noter/transport-layer/snmp-(simple-network-management-protocol)"]
    "467uni/notes/data-kommunikation/noter/transport-layer/selective-repeat-protocol" [label="uni/notes/data-kommunikation/noter/transport-layer/selective-repeat-protocol"]
    "468uni/notes/data-kommunikation/noter/transport-layer/simple-protocol" [label="uni/notes/data-kommunikation/noter/transport-layer/simple-protocol"]
    "469uni/notes/data-kommunikation/noter/transport-layer/stop-and-wait-protocol" [label="uni/notes/data-kommunikation/noter/transport-layer/stop-and-wait-protocol"]
    "470uni/notes/data-kommunikation/noter/transport-layer/transport-layer-addressing" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-addressing"]
    "471uni/notes/data-kommunikation/noter/transport-layer/transport-layer-congestion-control" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-congestion-control"]
    "472uni/notes/data-kommunikation/noter/transport-layer/transport-layer-encapsulation-and-decapsulation" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-encapsulation-and-decapsulation"]
    "473uni/notes/data-kommunikation/noter/transport-layer/transport-layer-error-control" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-error-control"]
    "474uni/notes/data-kommunikation/noter/transport-layer/transport-layer-flow-control" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-flow-control"]
    "475uni/notes/data-kommunikation/noter/transport-layer/transport-layer-icann-range" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-icann-range"]
    "476uni/notes/data-kommunikation/noter/transport-layer/transport-layer-multiplexing-and-demultiplexing" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-multiplexing-and-demultiplexing"]
    "477uni/notes/data-kommunikation/noter/transport-layer/transport-layer-service" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-service"]
    "478uni/notes/data-kommunikation/noter/transport-layer/transport-layer-socket-address" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer-socket-address"]
    "479uni/notes/data-kommunikation/noter/transport-layer/transport-layer" [label="uni/notes/data-kommunikation/noter/transport-layer/transport-layer"]
    "480uni/notes/data-kommunikation/opgaver/lektion-2" [label="uni/notes/data-kommunikation/opgaver/lektion-2"]
    "481uni/notes/datateknik/atmega32/add-or-multiply-function" [label="uni/notes/datateknik/atmega32/add-or-multiply-function"]
    "482uni/notes/datateknik/atmega32/ctc-example" [label="uni/notes/datateknik/atmega32/ctc-example"]
    "483uni/notes/datateknik/atmega32/display-schematic" [label="uni/notes/datateknik/atmega32/display-schematic"]
    "484uni/notes/datateknik/atmega32/io-ports" [label="uni/notes/datateknik/atmega32/io-ports"]
    "485uni/notes/datateknik/atmega32/inside-of-avr-port" [label="uni/notes/datateknik/atmega32/inside-of-avr-port"]
    "486uni/notes/datateknik/atmega32/schematic" [label="uni/notes/datateknik/atmega32/schematic"]
    "487uni/notes/datateknik/atmega32/timers-in-atmega32" [label="uni/notes/datateknik/atmega32/timers-in-atmega32"]
    "488uni/notes/datateknik/analog-to-digital/adc" [label="uni/notes/datateknik/analog-to-digital/adc"]
    "489uni/notes/datateknik/analog-to-digital/adch-or-adcl-result-register" [label="uni/notes/datateknik/analog-to-digital/adch-or-adcl-result-register"]
    "490uni/notes/datateknik/analog-to-digital/adcsra-register" [label="uni/notes/datateknik/analog-to-digital/adcsra-register"]
    "491uni/notes/datateknik/analog-to-digital/admux" [label="uni/notes/datateknik/analog-to-digital/admux"]
    "492uni/notes/datateknik/analog-to-digital/example" [label="uni/notes/datateknik/analog-to-digital/example"]
    "493uni/notes/datateknik/analog-to-digital/how-to-use-adc" [label="uni/notes/datateknik/analog-to-digital/how-to-use-adc"]
    "494uni/notes/datateknik/analog-to-digital/pwm-signal" [label="uni/notes/datateknik/analog-to-digital/pwm-signal"]
    "495uni/notes/datateknik/analog-to-digital/ucsra-control-and-register-status" [label="uni/notes/datateknik/analog-to-digital/ucsra-control-and-register-status"]
    "496uni/notes/datateknik/assembly/directives/def" [label="uni/notes/datateknik/assembly/directives/def"]
    "497uni/notes/datateknik/assembly/directives/directives" [label="uni/notes/datateknik/assembly/directives/directives"]
    "498uni/notes/datateknik/assembly/directives/equ" [label="uni/notes/datateknik/assembly/directives/equ"]
    "499uni/notes/datateknik/assembly/directives/include" [label="uni/notes/datateknik/assembly/directives/include"]
    "500uni/notes/datateknik/assembly/directives/org" [label="uni/notes/datateknik/assembly/directives/org"]
    "501uni/notes/datateknik/assembly/directives/set" [label="uni/notes/datateknik/assembly/directives/set"]
    "502uni/notes/datateknik/assembly/instructions/adc" [label="uni/notes/datateknik/assembly/instructions/adc"]
    "503uni/notes/datateknik/assembly/instructions/add" [label="uni/notes/datateknik/assembly/instructions/add"]
    "504uni/notes/datateknik/assembly/instructions/bit-manipulation" [label="uni/notes/datateknik/assembly/instructions/bit-manipulation"]
    "505uni/notes/datateknik/assembly/instructions/com" [label="uni/notes/datateknik/assembly/instructions/com"]
    "506uni/notes/datateknik/assembly/instructions/conditional-jump-(cp-&-cpi)" [label="uni/notes/datateknik/assembly/instructions/conditional-jump-(cp-&-cpi)"]
    "507uni/notes/datateknik/assembly/instructions/dec" [label="uni/notes/datateknik/assembly/instructions/dec"]
    "508uni/notes/datateknik/assembly/instructions/division" [label="uni/notes/datateknik/assembly/instructions/division"]
    "509uni/notes/datateknik/assembly/instructions/in-&-out" [label="uni/notes/datateknik/assembly/instructions/in-&-out"]
    "510uni/notes/datateknik/assembly/instructions/in-(from-io)" [label="uni/notes/datateknik/assembly/instructions/in-(from-io)"]
    "511uni/notes/datateknik/assembly/instructions/inc" [label="uni/notes/datateknik/assembly/instructions/inc"]
    "512uni/notes/datateknik/assembly/instructions/instructions" [label="uni/notes/datateknik/assembly/instructions/instructions"]
    "513uni/notes/datateknik/assembly/instructions/lds-and-ldi" [label="uni/notes/datateknik/assembly/instructions/lds-and-ldi"]
    "514uni/notes/datateknik/assembly/instructions/logical-shift" [label="uni/notes/datateknik/assembly/instructions/logical-shift"]
    "515uni/notes/datateknik/assembly/instructions/loops" [label="uni/notes/datateknik/assembly/instructions/loops"]
    "516uni/notes/datateknik/assembly/instructions/mov" [label="uni/notes/datateknik/assembly/instructions/mov"]
    "517uni/notes/datateknik/assembly/instructions/multiplication" [label="uni/notes/datateknik/assembly/instructions/multiplication"]
    "518uni/notes/datateknik/assembly/instructions/no-operation(nop)" [label="uni/notes/datateknik/assembly/instructions/no-operation(nop)"]
    "519uni/notes/datateknik/assembly/instructions/out-(from-io)" [label="uni/notes/datateknik/assembly/instructions/out-(from-io)"]
    "520uni/notes/datateknik/assembly/instructions/sbc" [label="uni/notes/datateknik/assembly/instructions/sbc"]
    "521uni/notes/datateknik/assembly/instructions/sts" [label="uni/notes/datateknik/assembly/instructions/sts"]
    "522uni/notes/datateknik/assembly/instructions/subi" [label="uni/notes/datateknik/assembly/instructions/subi"]
    "523uni/notes/datateknik/assembly/instructions/setup-port-as-input-or-output" [label="uni/notes/datateknik/assembly/instructions/setup-port-as-input-or-output"]
    "524uni/notes/datateknik/assembly/instructions/sub(subtract)" [label="uni/notes/datateknik/assembly/instructions/sub(subtract)"]
    "525uni/notes/datateknik/assembly/stacks/push-pop" [label="uni/notes/datateknik/assembly/stacks/push-pop"]
    "526uni/notes/datateknik/assembly/stacks/stack-pointer-set" [label="uni/notes/datateknik/assembly/stacks/stack-pointer-set"]
    "527uni/notes/datateknik/assembly/stacks/stacks" [label="uni/notes/datateknik/assembly/stacks/stacks"]
    "528uni/notes/datateknik/assembly/subroutine/call-rcall" [label="uni/notes/datateknik/assembly/subroutine/call-rcall"]
    "529uni/notes/datateknik/assembly/subroutine/ret" [label="uni/notes/datateknik/assembly/subroutine/ret"]
    "530uni/notes/datateknik/assembly/subroutine/subroutines" [label="uni/notes/datateknik/assembly/subroutine/subroutines"]
    "531uni/notes/datateknik/boolean-algebra" [label="uni/notes/datateknik/boolean-algebra"]
    "532uni/notes/datateknik/counters" [label="uni/notes/datateknik/counters"]
    "533uni/notes/datateknik/microcontrollers/atmega32/add-or-multiply-function" [label="uni/notes/datateknik/microcontrollers/atmega32/add-or-multiply-function"]
    "534uni/notes/datateknik/microcontrollers/atmega32/ctc-example" [label="uni/notes/datateknik/microcontrollers/atmega32/ctc-example"]
    "535uni/notes/datateknik/microcontrollers/atmega32/display-schematic" [label="uni/notes/datateknik/microcontrollers/atmega32/display-schematic"]
    "536uni/notes/datateknik/microcontrollers/atmega32/io-ports" [label="uni/notes/datateknik/microcontrollers/atmega32/io-ports"]
    "537uni/notes/datateknik/microcontrollers/atmega32/inside-of-avr-port" [label="uni/notes/datateknik/microcontrollers/atmega32/inside-of-avr-port"]
    "538uni/notes/datateknik/microcontrollers/atmega32/pwm-example" [label="uni/notes/datateknik/microcontrollers/atmega32/pwm-example"]
    "539uni/notes/datateknik/microcontrollers/atmega32/schematic" [label="uni/notes/datateknik/microcontrollers/atmega32/schematic"]
    "540uni/notes/datateknik/microcontrollers/atmega32/timers-in-atmega32" [label="uni/notes/datateknik/microcontrollers/atmega32/timers-in-atmega32"]
    "541uni/notes/datateknik/microcontrollers/analog-to-digital/adc" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/adc"]
    "542uni/notes/datateknik/microcontrollers/analog-to-digital/adch-or-adcl-result-register" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/adch-or-adcl-result-register"]
    "543uni/notes/datateknik/microcontrollers/analog-to-digital/adcsra-register" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/adcsra-register"]
    "544uni/notes/datateknik/microcontrollers/analog-to-digital/admux" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/admux"]
    "545uni/notes/datateknik/microcontrollers/analog-to-digital/example" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/example"]
    "546uni/notes/datateknik/microcontrollers/analog-to-digital/how-to-use-adc" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/how-to-use-adc"]
    "547uni/notes/datateknik/microcontrollers/analog-to-digital/ucsra-control-and-register-status" [label="uni/notes/datateknik/microcontrollers/analog-to-digital/ucsra-control-and-register-status"]
    "548uni/notes/datateknik/microcontrollers/assembly/directives/def" [label="uni/notes/datateknik/microcontrollers/assembly/directives/def"]
    "549uni/notes/datateknik/microcontrollers/assembly/directives/directives" [label="uni/notes/datateknik/microcontrollers/assembly/directives/directives"]
    "550uni/notes/datateknik/microcontrollers/assembly/directives/equ" [label="uni/notes/datateknik/microcontrollers/assembly/directives/equ"]
    "551uni/notes/datateknik/microcontrollers/assembly/directives/include" [label="uni/notes/datateknik/microcontrollers/assembly/directives/include"]
    "552uni/notes/datateknik/microcontrollers/assembly/directives/org" [label="uni/notes/datateknik/microcontrollers/assembly/directives/org"]
    "553uni/notes/datateknik/microcontrollers/assembly/directives/set" [label="uni/notes/datateknik/microcontrollers/assembly/directives/set"]
    "554uni/notes/datateknik/microcontrollers/assembly/instructions/adc" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/adc"]
    "555uni/notes/datateknik/microcontrollers/assembly/instructions/add" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/add"]
    "556uni/notes/datateknik/microcontrollers/assembly/instructions/bit-manipulation" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/bit-manipulation"]
    "557uni/notes/datateknik/microcontrollers/assembly/instructions/com" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/com"]
    "558uni/notes/datateknik/microcontrollers/assembly/instructions/conditional-jump-(cp-&-cpi)" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/conditional-jump-(cp-&-cpi)"]
    "559uni/notes/datateknik/microcontrollers/assembly/instructions/dec" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/dec"]
    "560uni/notes/datateknik/microcontrollers/assembly/instructions/division" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/division"]
    "561uni/notes/datateknik/microcontrollers/assembly/instructions/in-&-out" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/in-&-out"]
    "562uni/notes/datateknik/microcontrollers/assembly/instructions/in-(from-io)" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/in-(from-io)"]
    "563uni/notes/datateknik/microcontrollers/assembly/instructions/inc" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/inc"]
    "564uni/notes/datateknik/microcontrollers/assembly/instructions/instructions" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/instructions"]
    "565uni/notes/datateknik/microcontrollers/assembly/instructions/lds-and-ldi" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/lds-and-ldi"]
    "566uni/notes/datateknik/microcontrollers/assembly/instructions/logical-shift" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/logical-shift"]
    "567uni/notes/datateknik/microcontrollers/assembly/instructions/loops" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/loops"]
    "568uni/notes/datateknik/microcontrollers/assembly/instructions/mov" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/mov"]
    "569uni/notes/datateknik/microcontrollers/assembly/instructions/multiplication" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/multiplication"]
    "570uni/notes/datateknik/microcontrollers/assembly/instructions/no-operation(nop)" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/no-operation(nop)"]
    "571uni/notes/datateknik/microcontrollers/assembly/instructions/out-(from-io)" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/out-(from-io)"]
    "572uni/notes/datateknik/microcontrollers/assembly/instructions/sbc" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/sbc"]
    "573uni/notes/datateknik/microcontrollers/assembly/instructions/sts" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/sts"]
    "574uni/notes/datateknik/microcontrollers/assembly/instructions/subi" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/subi"]
    "575uni/notes/datateknik/microcontrollers/assembly/instructions/setup-port-as-input-or-output" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/setup-port-as-input-or-output"]
    "576uni/notes/datateknik/microcontrollers/assembly/instructions/sub(subtract)" [label="uni/notes/datateknik/microcontrollers/assembly/instructions/sub(subtract)"]
    "577uni/notes/datateknik/microcontrollers/assembly/stacks/push-pop" [label="uni/notes/datateknik/microcontrollers/assembly/stacks/push-pop"]
    "578uni/notes/datateknik/microcontrollers/assembly/stacks/stack-pointer-set" [label="uni/notes/datateknik/microcontrollers/assembly/stacks/stack-pointer-set"]
    "579uni/notes/datateknik/microcontrollers/assembly/stacks/stacks" [label="uni/notes/datateknik/microcontrollers/assembly/stacks/stacks"]
    "580uni/notes/datateknik/microcontrollers/assembly/subroutine/call-rcall" [label="uni/notes/datateknik/microcontrollers/assembly/subroutine/call-rcall"]
    "581uni/notes/datateknik/microcontrollers/assembly/subroutine/ret" [label="uni/notes/datateknik/microcontrollers/assembly/subroutine/ret"]
    "582uni/notes/datateknik/microcontrollers/assembly/subroutine/subroutines" [label="uni/notes/datateknik/microcontrollers/assembly/subroutine/subroutines"]
    "583uni/notes/datateknik/microcontrollers/boolean-algebra/boolean-algebra" [label="uni/notes/datateknik/microcontrollers/boolean-algebra/boolean-algebra"]
    "584uni/notes/datateknik/microcontrollers/boolean-algebra/counters" [label="uni/notes/datateknik/microcontrollers/boolean-algebra/counters"]
    "585uni/notes/datateknik/microcontrollers/boolean-algebra/nummereringssystemer" [label="uni/notes/datateknik/microcontrollers/boolean-algebra/nummereringssystemer"]
    "586uni/notes/datateknik/microcontrollers/boolean-algebra/python-converter" [label="uni/notes/datateknik/microcontrollers/boolean-algebra/python-converter"]
    "587uni/notes/datateknik/microcontrollers/c/arithmetic-operations" [label="uni/notes/datateknik/microcontrollers/c/arithmetic-operations"]
    "588uni/notes/datateknik/microcontrollers/c/arrays" [label="uni/notes/datateknik/microcontrollers/c/arrays"]
    "589uni/notes/datateknik/microcontrollers/c/bit-wise-logical-operations" [label="uni/notes/datateknik/microcontrollers/c/bit-wise-logical-operations"]
    "590uni/notes/datateknik/microcontrollers/c/data-types(variables)" [label="uni/notes/datateknik/microcontrollers/c/data-types(variables)"]
    "591uni/notes/datateknik/microcontrollers/c/interrupt/avr-interrupt" [label="uni/notes/datateknik/microcontrollers/c/interrupt/avr-interrupt"]
    "592uni/notes/datateknik/microcontrollers/c/interrupt/external-interrupt-register" [label="uni/notes/datateknik/microcontrollers/c/interrupt/external-interrupt-register"]
    "593uni/notes/datateknik/microcontrollers/c/interrupt/global-interrupt-enable" [label="uni/notes/datateknik/microcontrollers/c/interrupt/global-interrupt-enable"]
    "594uni/notes/datateknik/microcontrollers/c/interrupt/interrupt-addresses" [label="uni/notes/datateknik/microcontrollers/c/interrupt/interrupt-addresses"]
    "595uni/notes/datateknik/microcontrollers/c/interrupt/interrupt-example" [label="uni/notes/datateknik/microcontrollers/c/interrupt/interrupt-example"]
    "596uni/notes/datateknik/microcontrollers/c/interrupt/timer0-interrupt" [label="uni/notes/datateknik/microcontrollers/c/interrupt/timer0-interrupt"]
    "597uni/notes/datateknik/microcontrollers/c/interrupt/timer0" [label="uni/notes/datateknik/microcontrollers/c/interrupt/timer0"]
    "598uni/notes/datateknik/microcontrollers/c/pin-reader" [label="uni/notes/datateknik/microcontrollers/c/pin-reader"]
    "599uni/notes/datateknik/microcontrollers/c/structure-and-compilation" [label="uni/notes/datateknik/microcontrollers/c/structure-and-compilation"]
    "600uni/notes/datateknik/microcontrollers/c/tccr0-timer-counter-control-register" [label="uni/notes/datateknik/microcontrollers/c/tccr0-timer-counter-control-register"]
    "601uni/notes/datateknik/microcontrollers/microcontrollers/alu-(arithmetic-logic-unit)" [label="uni/notes/datateknik/microcontrollers/microcontrollers/alu-(arithmetic-logic-unit)"]
    "602uni/notes/datateknik/microcontrollers/microcontrollers/avr-microcontroller" [label="uni/notes/datateknik/microcontrollers/microcontrollers/avr-microcontroller"]
    "603uni/notes/datateknik/microcontrollers/microcontrollers/architecture" [label="uni/notes/datateknik/microcontrollers/microcontrollers/architecture"]
    "604uni/notes/datateknik/microcontrollers/microcontrollers/clock" [label="uni/notes/datateknik/microcontrollers/microcontrollers/clock"]
    "605uni/notes/datateknik/microcontrollers/microcontrollers/cpu" [label="uni/notes/datateknik/microcontrollers/microcontrollers/cpu"]
    "606uni/notes/datateknik/microcontrollers/microcontrollers/decoder" [label="uni/notes/datateknik/microcontrollers/microcontrollers/decoder"]
    "607uni/notes/datateknik/microcontrollers/microcontrollers/full-adder" [label="uni/notes/datateknik/microcontrollers/microcontrollers/full-adder"]
    "608uni/notes/datateknik/microcontrollers/microcontrollers/gates" [label="uni/notes/datateknik/microcontrollers/microcontrollers/gates"]
    "609uni/notes/datateknik/microcontrollers/microcontrollers/karnaugh-maps-(k-maps)" [label="uni/notes/datateknik/microcontrollers/microcontrollers/karnaugh-maps-(k-maps)"]
    "610uni/notes/datateknik/microcontrollers/microcontrollers/memory" [label="uni/notes/datateknik/microcontrollers/microcontrollers/memory"]
    "611uni/notes/datateknik/microcontrollers/microcontrollers/multiplexer-(mux)-or-selector" [label="uni/notes/datateknik/microcontrollers/microcontrollers/multiplexer-(mux)-or-selector"]
    "612uni/notes/datateknik/microcontrollers/microcontrollers/r-s-(reset-set)-latch" [label="uni/notes/datateknik/microcontrollers/microcontrollers/r-s-(reset-set)-latch"]
    "613uni/notes/datateknik/microcontrollers/microcontrollers/registers" [label="uni/notes/datateknik/microcontrollers/microcontrollers/registers"]
    "614uni/notes/datateknik/microcontrollers/microcontrollers/tri-state-buffer" [label="uni/notes/datateknik/microcontrollers/microcontrollers/tri-state-buffer"]
    "615uni/notes/datateknik/nummereringssystemer" [label="uni/notes/datateknik/nummereringssystemer"]
    "616uni/notes/datateknik/pwm-(pulse-width-modulation)" [label="uni/notes/datateknik/pwm-(pulse-width-modulation)"]
    "617uni/notes/datateknik/python-converter" [label="uni/notes/datateknik/python-converter"]
    "618uni/notes/digital-programmerbar-elektronik/assignment-2" [label="uni/notes/digital-programmerbar-elektronik/assignment-2"]
    "619uni/notes/digital-programmerbar-elektronik/digital-assignment" [label="uni/notes/digital-programmerbar-elektronik/digital-assignment"]
    "620uni/notes/digital-programmerbar-elektronik/noter/adders" [label="uni/notes/digital-programmerbar-elektronik/noter/adders"]
    "621uni/notes/digital-programmerbar-elektronik/noter/comparators" [label="uni/notes/digital-programmerbar-elektronik/noter/comparators"]
    "622uni/notes/digital-programmerbar-elektronik/noter/complex-comaparator" [label="uni/notes/digital-programmerbar-elektronik/noter/complex-comaparator"]
    "623uni/notes/digital-programmerbar-elektronik/noter/counter-vhdl" [label="uni/notes/digital-programmerbar-elektronik/noter/counter-vhdl"]
    "624uni/notes/digital-programmerbar-elektronik/noter/d-type-flip-flop" [label="uni/notes/digital-programmerbar-elektronik/noter/d-type-flip-flop"]
    "625uni/notes/digital-programmerbar-elektronik/noter/d-type-latch" [label="uni/notes/digital-programmerbar-elektronik/noter/d-type-latch"]
    "626uni/notes/digital-programmerbar-elektronik/noter/decoder" [label="uni/notes/digital-programmerbar-elektronik/noter/decoder"]
    "627uni/notes/digital-programmerbar-elektronik/noter/divider" [label="uni/notes/digital-programmerbar-elektronik/noter/divider"]
    "628uni/notes/digital-programmerbar-elektronik/noter/encoder" [label="uni/notes/digital-programmerbar-elektronik/noter/encoder"]
    "629uni/notes/digital-programmerbar-elektronik/noter/keypad-encoder" [label="uni/notes/digital-programmerbar-elektronik/noter/keypad-encoder"]
    "630uni/notes/digital-programmerbar-elektronik/noter/lcd-driver-fpga" [label="uni/notes/digital-programmerbar-elektronik/noter/lcd-driver-fpga"]
    "631uni/notes/digital-programmerbar-elektronik/noter/multiplication" [label="uni/notes/digital-programmerbar-elektronik/noter/multiplication"]
    "632uni/notes/digital-programmerbar-elektronik/noter/priority-encoder" [label="uni/notes/digital-programmerbar-elektronik/noter/priority-encoder"]
    "633uni/notes/digital-programmerbar-elektronik/noter/register-vhdl" [label="uni/notes/digital-programmerbar-elektronik/noter/register-vhdl"]
    "634uni/notes/digital-programmerbar-elektronik/noter/spi(serial-peripheral-interface-bus)" [label="uni/notes/digital-programmerbar-elektronik/noter/spi(serial-peripheral-interface-bus)"]
    "635uni/notes/digital-programmerbar-elektronik/noter/shift-registers-vhdl" [label="uni/notes/digital-programmerbar-elektronik/noter/shift-registers-vhdl"]
    "636uni/notes/digital-programmerbar-elektronik/noter/signals-and-variables" [label="uni/notes/digital-programmerbar-elektronik/noter/signals-and-variables"]
    "637uni/notes/digital-programmerbar-elektronik/noter/subtractors" [label="uni/notes/digital-programmerbar-elektronik/noter/subtractors"]
    "638uni/notes/droner/before-flight-checklist" [label="uni/notes/droner/before-flight-checklist"]
    "639uni/notes/droner/group-7-team-contract" [label="uni/notes/droner/group-7-team-contract"]
    "640uni/notes/elektro-fysik/ac-kredsloeb" [label="uni/notes/elektro-fysik/ac-kredsloeb"]
    "641uni/notes/elektro-fysik/bipolar-junction-transistor-(bjt)-fet-og-pnp" [label="uni/notes/elektro-fysik/bipolar-junction-transistor-(bjt)-fet-og-pnp"]
    "642uni/notes/elektro-fysik/effekt" [label="uni/notes/elektro-fysik/effekt"]
    "643uni/notes/elektro-fysik/eksamen/ac-kredslã¸b" [label="uni/notes/elektro-fysik/eksamen/ac-kredslã¸b"]
    "644uni/notes/elektro-fysik/eksamen/bass-forstã¦rker" [label="uni/notes/elektro-fysik/eksamen/bass-forstã¦rker"]
    "645uni/notes/elektro-fysik/eksamen/diode-pn" [label="uni/notes/elektro-fysik/eksamen/diode-pn"]
    "646uni/notes/elektro-fysik/eksamen/dioden" [label="uni/notes/elektro-fysik/eksamen/dioden"]
    "647uni/notes/elektro-fysik/eksamen/drawing-2023-01-14-18.43.16.excalidraw" [label="uni/notes/elektro-fysik/eksamen/drawing-2023-01-14-18.43.16.excalidraw"]
    "648uni/notes/elektro-fysik/eksamen/halvledere" [label="uni/notes/elektro-fysik/eksamen/halvledere"]
    "649uni/notes/elektro-fysik/eksamen/impedans-og-resonans" [label="uni/notes/elektro-fysik/eksamen/impedans-og-resonans"]
    "650uni/notes/elektro-fysik/eksamen/kirchoffs-strã¸m-lov" [label="uni/notes/elektro-fysik/eksamen/kirchoffs-strã¸m-lov"]
    "651uni/notes/elektro-fysik/eksamen/knudepunktmetode" [label="uni/notes/elektro-fysik/eksamen/knudepunktmetode"]
    "652uni/notes/elektro-fysik/eksamen/knudepunktmetoden" [label="uni/notes/elektro-fysik/eksamen/knudepunktmetoden"]
    "653uni/notes/elektro-fysik/eksamen/kondensator-formel" [label="uni/notes/elektro-fysik/eksamen/kondensator-formel"]
    "654uni/notes/elektro-fysik/eksamen/kondensator" [label="uni/notes/elektro-fysik/eksamen/kondensator"]
    "655uni/notes/elektro-fysik/eksamen/maskemetoden" [label="uni/notes/elektro-fysik/eksamen/maskemetoden"]
    "656uni/notes/elektro-fysik/eksamen/ohms-lov-serie-og-parallel" [label="uni/notes/elektro-fysik/eksamen/ohms-lov-serie-og-parallel"]
    "657uni/notes/elektro-fysik/eksamen/op-amp" [label="uni/notes/elektro-fysik/eksamen/op-amp"]
    "658uni/notes/elektro-fysik/eksamen/opafladning.excalidraw" [label="uni/notes/elektro-fysik/eksamen/opafladning.excalidraw"]
    "659uni/notes/elektro-fysik/eksamen/resonans" [label="uni/notes/elektro-fysik/eksamen/resonans"]
    "660uni/notes/elektro-fysik/eksamen/spole" [label="uni/notes/elektro-fysik/eksamen/spole"]
    "661uni/notes/elektro-fysik/eksamen/spã¦ndings-og-strã¸m-deler" [label="uni/notes/elektro-fysik/eksamen/spã¦ndings-og-strã¸m-deler"]
    "662uni/notes/elektro-fysik/eksamen/thevening" [label="uni/notes/elektro-fysik/eksamen/thevening"]
    "663uni/notes/elektro-fysik/eksamen/transistor" [label="uni/notes/elektro-fysik/eksamen/transistor"]
    "664uni/notes/elektro-fysik/elektro" [label="uni/notes/elektro-fysik/elektro"]
    "665uni/notes/elektro-fysik/frekvens-og-phasor" [label="uni/notes/elektro-fysik/frekvens-og-phasor"]
    "666uni/notes/elektro-fysik/fã¦lles-emitterkobling" [label="uni/notes/elektro-fysik/fã¦lles-emitterkobling"]
    "667uni/notes/elektro-fysik/halvledere" [label="uni/notes/elektro-fysik/halvledere"]
    "668uni/notes/elektro-fysik/impedans" [label="uni/notes/elektro-fysik/impedans"]
    "669uni/notes/elektro-fysik/komponenter-og-subcircuits" [label="uni/notes/elektro-fysik/komponenter-og-subcircuits"]
    "670uni/notes/elektro-fysik/kondensator" [label="uni/notes/elektro-fysik/kondensator"]
    "671uni/notes/elektro-fysik/ohms-lov" [label="uni/notes/elektro-fysik/ohms-lov"]
    "672uni/notes/elektro-fysik/op-og-afladning" [label="uni/notes/elektro-fysik/op-og-afladning"]
    "673uni/notes/elektro-fysik/operationsforstaerker" [label="uni/notes/elektro-fysik/operationsforstaerker"]
    "674uni/notes/elektro-fysik/operationsforstærker" [label="uni/notes/elektro-fysik/operationsforstærker"]
    "675uni/notes/elektro-fysik/opgaver/drawing-2022-12-01-10.18.34.excalidraw" [label="uni/notes/elektro-fysik/opgaver/drawing-2022-12-01-10.18.34.excalidraw"]
    "676uni/notes/elektro-fysik/parrallel-koblinger" [label="uni/notes/elektro-fysik/parrallel-koblinger"]
    "677uni/notes/elektro-fysik/rms-effekt" [label="uni/notes/elektro-fysik/rms-effekt"]
    "678uni/notes/elektro-fysik/resistor" [label="uni/notes/elektro-fysik/resistor"]
    "679uni/notes/elektro-fysik/sinusformet-signal" [label="uni/notes/elektro-fysik/sinusformet-signal"]
    "680uni/notes/elektro-fysik/spilt-power-supply" [label="uni/notes/elektro-fysik/spilt-power-supply"]
    "681uni/notes/elektro-fysik/spoler" [label="uni/notes/elektro-fysik/spoler"]
    "682uni/notes/elektro-fysik/superposition" [label="uni/notes/elektro-fysik/superposition"]
    "683uni/notes/elektro-fysik/tidsvarierende-signaler" [label="uni/notes/elektro-fysik/tidsvarierende-signaler"]
    "684uni/notes/elektro-fysik/ãkvivalentkredsloeb" [label="uni/notes/elektro-fysik/ãkvivalentkredsloeb"]
    "685uni/notes/forstaerkningsteknik/noter/biaskompensator-og-biasstrã¸m" [label="uni/notes/forstaerkningsteknik/noter/biaskompensator-og-biasstrã¸m"]
    "686uni/notes/forstaerkningsteknik/noter/common-mode-rejection-(cmr)" [label="uni/notes/forstaerkningsteknik/noter/common-mode-rejection-(cmr)"]
    "687uni/notes/forstaerkningsteknik/noter/feedback-tabel" [label="uni/notes/forstaerkningsteknik/noter/feedback-tabel"]
    "688uni/notes/forstaerkningsteknik/noter/maksimal-fejl-i-forstã¦rkning" [label="uni/notes/forstaerkningsteknik/noter/maksimal-fejl-i-forstã¦rkning"]
    "689uni/notes/freertos/contributing" [label="uni/notes/freertos/contributing"]
    "690uni/notes/freertos/readme" [label="uni/notes/freertos/readme"]
    "691uni/notes/freertos/security" [label="uni/notes/freertos/security"]
    "692uni/notes/freertos/abbreviations" [label="uni/notes/freertos/abbreviations"]
    "693uni/notes/freertos/booktitle" [label="uni/notes/freertos/booktitle"]
    "694uni/notes/freertos/ch01" [label="uni/notes/freertos/ch01"]
    "695uni/notes/freertos/ch02" [label="uni/notes/freertos/ch02"]
    "696uni/notes/freertos/ch03" [label="uni/notes/freertos/ch03"]
    "697uni/notes/freertos/ch04" [label="uni/notes/freertos/ch04"]
    "698uni/notes/freertos/ch05" [label="uni/notes/freertos/ch05"]
    "699uni/notes/freertos/ch06" [label="uni/notes/freertos/ch06"]
    "700uni/notes/freertos/ch07" [label="uni/notes/freertos/ch07"]
    "701uni/notes/freertos/ch08" [label="uni/notes/freertos/ch08"]
    "702uni/notes/freertos/ch09" [label="uni/notes/freertos/ch09"]
    "703uni/notes/freertos/ch10" [label="uni/notes/freertos/ch10"]
    "704uni/notes/freertos/ch11" [label="uni/notes/freertos/ch11"]
    "705uni/notes/freertos/ch12" [label="uni/notes/freertos/ch12"]
    "706uni/notes/freertos/ch13" [label="uni/notes/freertos/ch13"]
    "707uni/notes/freertos/copyright" [label="uni/notes/freertos/copyright"]
    "708uni/notes/freertos/dedication" [label="uni/notes/freertos/dedication"]
    "709uni/notes/freertos/toc" [label="uni/notes/freertos/toc"]
    "710uni/notes/indlejret-programmering/noter/cortex-m4/cortex-m4-nvic" [label="uni/notes/indlejret-programmering/noter/cortex-m4/cortex-m4-nvic"]
    "711uni/notes/indlejret-programmering/noter/cortex-m4/cortex-m4-registers" [label="uni/notes/indlejret-programmering/noter/cortex-m4/cortex-m4-registers"]
    "712uni/notes/indlejret-programmering/noter/cortex-m4/cortex-m4-timer0" [label="uni/notes/indlejret-programmering/noter/cortex-m4/cortex-m4-timer0"]
    "713uni/notes/indlejret-programmering/noter/drawing-2024-04-15-13.39.03.excalidraw" [label="uni/notes/indlejret-programmering/noter/drawing-2024-04-15-13.39.03.excalidraw"]
    "714uni/notes/indlejret-programmering/noter/freertos-(real-time-operating-system)" [label="uni/notes/indlejret-programmering/noter/freertos-(real-time-operating-system)"]
    "715uni/notes/indlejret-programmering/noter/rtcs-(run-to-complete-scheduling)" [label="uni/notes/indlejret-programmering/noter/rtcs-(run-to-complete-scheduling)"]
    "716uni/notes/indlejret-programmering/noter/rtcs-scheduler-api" [label="uni/notes/indlejret-programmering/noter/rtcs-scheduler-api"]
    "717uni/notes/indlejret-programmering/noter/printf()" [label="uni/notes/indlejret-programmering/noter/printf()"]
    "718uni/notes/kinematik/assignments/kinematik-opgaver.excalidraw" [label="uni/notes/kinematik/assignments/kinematik-opgaver.excalidraw"]
    "719uni/notes/kinematik/assignments/inverse-kinematics" [label="uni/notes/kinematik/assignments/inverse-kinematics"]
    "720uni/notes/kinematik/lecture-notes/building-robots-in-matlab/2-axis-2d-planar-robot" [label="uni/notes/kinematik/lecture-notes/building-robots-in-matlab/2-axis-2d-planar-robot"]
    "721uni/notes/kinematik/lecture-notes/eksamen/dh-parameters" [label="uni/notes/kinematik/lecture-notes/eksamen/dh-parameters"]
    "722uni/notes/kinematik/lecture-notes/eksamen/euler-and-fixed-angles" [label="uni/notes/kinematik/lecture-notes/eksamen/euler-and-fixed-angles"]
    "723uni/notes/kinematik/lecture-notes/eksamen/forward-kinematics.excalidraw" [label="uni/notes/kinematik/lecture-notes/eksamen/forward-kinematics.excalidraw"]
    "724uni/notes/kinematik/lecture-notes/eksamen/joints" [label="uni/notes/kinematik/lecture-notes/eksamen/joints"]
    "725uni/notes/kinematik/lecture-notes/eksamen/rotationmatrices.excalidraw" [label="uni/notes/kinematik/lecture-notes/eksamen/rotationmatrices.excalidraw"]
    "726uni/notes/kinematik/lecture-notes/eksamen/rotationsmatrices" [label="uni/notes/kinematik/lecture-notes/eksamen/rotationsmatrices"]
    "727uni/notes/kinematik/lecture-notes/eksamen/transformation-matrix.excalidraw" [label="uni/notes/kinematik/lecture-notes/eksamen/transformation-matrix.excalidraw"]
    "728uni/notes/kinematik/lecture-notes/eksamen/translationsmatrices" [label="uni/notes/kinematik/lecture-notes/eksamen/translationsmatrices"]
    "729uni/notes/kinematik/lecture-notes/eksamen/inverse-kinematics.excalidraw" [label="uni/notes/kinematik/lecture-notes/eksamen/inverse-kinematics.excalidraw"]
    "730uni/notes/kinematik/lecture-notes/inverse-kinematics/choice-of-solution" [label="uni/notes/kinematik/lecture-notes/inverse-kinematics/choice-of-solution"]
    "731uni/notes/kinematik/lecture-notes/inverse-kinematics/example" [label="uni/notes/kinematik/lecture-notes/inverse-kinematics/example"]
    "732uni/notes/kinematik/lecture-notes/inverse-kinematics/general" [label="uni/notes/kinematik/lecture-notes/inverse-kinematics/general"]
    "733uni/notes/kinematik/lecture-notes/inverse-kinematics/planar-inverse-kinematics" [label="uni/notes/kinematik/lecture-notes/inverse-kinematics/planar-inverse-kinematics"]
    "734uni/notes/kinematik/lecture-notes/joints-and-links/dh-parameters" [label="uni/notes/kinematik/lecture-notes/joints-and-links/dh-parameters"]
    "735uni/notes/kinematik/lecture-notes/joints-and-links/joints-and-links" [label="uni/notes/kinematik/lecture-notes/joints-and-links/joints-and-links"]
    "736uni/notes/kinematik/lecture-notes/mappings/cases" [label="uni/notes/kinematik/lecture-notes/mappings/cases"]
    "737uni/notes/kinematik/lecture-notes/notation" [label="uni/notes/kinematik/lecture-notes/notation"]
    "738uni/notes/kinematik/lecture-notes/orientation/mapping" [label="uni/notes/kinematik/lecture-notes/orientation/mapping"]
    "739uni/notes/kinematik/lecture-notes/orientation/mere-rotation" [label="uni/notes/kinematik/lecture-notes/orientation/mere-rotation"]
    "740uni/notes/kinematik/lecture-notes/orientation/rotation" [label="uni/notes/kinematik/lecture-notes/orientation/rotation"]
    "741uni/notes/kinematik/lecture-notes/orientation/translation" [label="uni/notes/kinematik/lecture-notes/orientation/translation"]
    "742uni/notes/kinematik/lecture-notes/pa/pa-1-opg1" [label="uni/notes/kinematik/lecture-notes/pa/pa-1-opg1"]
    "743uni/notes/kinematik/lecture-notes/pa/pa-1" [label="uni/notes/kinematik/lecture-notes/pa/pa-1"]
    "744uni/notes/kinematik/lecture-notes/velocity/angular-velocity" [label="uni/notes/kinematik/lecture-notes/velocity/angular-velocity"]
    "745uni/notes/kinematik/lecture-notes/velocity/linear-velocity-of-rigid-bodies" [label="uni/notes/kinematik/lecture-notes/velocity/linear-velocity-of-rigid-bodies"]
    "746uni/notes/kinematik/lecture-notes/velocity/point-velocity-in-frame" [label="uni/notes/kinematik/lecture-notes/velocity/point-velocity-in-frame"]
    "747uni/notes/kunstig-inteligens/exercises/exercise-1-fuzzy-control" [label="uni/notes/kunstig-inteligens/exercises/exercise-1-fuzzy-control"]
    "748uni/notes/kunstig-inteligens/lecture-notes/basics" [label="uni/notes/kunstig-inteligens/lecture-notes/basics"]
    "749uni/notes/kunstig-inteligens/lecture-notes/control-surface" [label="uni/notes/kunstig-inteligens/lecture-notes/control-surface"]
    "750uni/notes/kunstig-inteligens/lecture-notes/four-value-functions" [label="uni/notes/kunstig-inteligens/lecture-notes/four-value-functions"]
    "751uni/notes/kunstig-inteligens/lecture-notes/fuzzy-logic-control" [label="uni/notes/kunstig-inteligens/lecture-notes/fuzzy-logic-control"]
    "752uni/notes/kunstig-inteligens/lecture-notes/fuzzy-logic" [label="uni/notes/kunstig-inteligens/lecture-notes/fuzzy-logic"]
    "753uni/notes/kunstig-inteligens/lecture-notes/mamdani-or-standard-fuzzy-system" [label="uni/notes/kunstig-inteligens/lecture-notes/mamdani-or-standard-fuzzy-system"]
    "754uni/notes/kunstig-inteligens/lecture-notes/markov-decision-process" [label="uni/notes/kunstig-inteligens/lecture-notes/markov-decision-process"]
    "755uni/notes/kunstig-inteligens/lecture-notes/monte-carlo-policy" [label="uni/notes/kunstig-inteligens/lecture-notes/monte-carlo-policy"]
    "756uni/notes/kunstig-inteligens/lecture-notes/on-policy-vs-off-policy" [label="uni/notes/kunstig-inteligens/lecture-notes/on-policy-vs-off-policy"]
    "757uni/notes/kunstig-inteligens/lecture-notes/q-learning" [label="uni/notes/kunstig-inteligens/lecture-notes/q-learning"]
    "758uni/notes/kunstig-inteligens/lecture-notes/reinforcement-learning" [label="uni/notes/kunstig-inteligens/lecture-notes/reinforcement-learning"]
    "759uni/notes/kunstig-inteligens/lecture-notes/sugeno-or-takagi-sugeno-or-functional-fuzzy-systems" [label="uni/notes/kunstig-inteligens/lecture-notes/sugeno-or-takagi-sugeno-or-functional-fuzzy-systems"]
    "760uni/notes/kunstig-inteligens/lecture-notes/temporal-difference" [label="uni/notes/kunstig-inteligens/lecture-notes/temporal-difference"]
    "761uni/notes/kunstig-inteligens/lecture-notes/terminology" [label="uni/notes/kunstig-inteligens/lecture-notes/terminology"]
    "762uni/notes/kunstig-inteligens/lecture-notes/tuning-fuzzy-controllers" [label="uni/notes/kunstig-inteligens/lecture-notes/tuning-fuzzy-controllers"]
    "763uni/notes/kunstig-inteligens/lecture-notes/n-step-bootstrapping" [label="uni/notes/kunstig-inteligens/lecture-notes/n-step-bootstrapping"]
    "764uni/notes/kunstig-inteligens/lecture-notes/t-norms-and-s-norms" [label="uni/notes/kunstig-inteligens/lecture-notes/t-norms-and-s-norms"]
    "765uni/notes/matlab-&-mathematica/bounding-boxes" [label="uni/notes/matlab-&-mathematica/bounding-boxes"]
    "766uni/notes/matlab-&-mathematica/mathematica/regler-til-inputs" [label="uni/notes/matlab-&-mathematica/mathematica/regler-til-inputs"]
    "767uni/notes/matlab-&-mathematica/mathematica/tag-sã¸jler-fra-importet-data" [label="uni/notes/matlab-&-mathematica/mathematica/tag-sã¸jler-fra-importet-data"]
    "768uni/notes/matlab-&-mathematica/mathematica-generelle-kommandoer" [label="uni/notes/matlab-&-mathematica/mathematica-generelle-kommandoer"]
    "769uni/notes/matlab-&-mathematica/untitled" [label="uni/notes/matlab-&-mathematica/untitled"]
    "770uni/notes/modbus/intro" [label="uni/notes/modbus/intro"]
    "771uni/notes/multivariable-calculus/noter/bode-plot" [label="uni/notes/multivariable-calculus/noter/bode-plot"]
    "772uni/notes/multivariable-calculus/noter/fourier-rã¦kker" [label="uni/notes/multivariable-calculus/noter/fourier-rã¦kker"]
    "773uni/notes/multivariable-calculus/noter/laplace-transformation" [label="uni/notes/multivariable-calculus/noter/laplace-transformation"]
    "774uni/notes/multivariable-calculus/noter/normal-form-of-a-pde" [label="uni/notes/multivariable-calculus/noter/normal-form-of-a-pde"]
    "775uni/notes/multivariable-calculus/noter/superpositionsprincippet" [label="uni/notes/multivariable-calculus/noter/superpositionsprincippet"]
    "776uni/notes/multivariable-calculus/opgaver/double-integrals.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/double-integrals.excalidraw"]
    "777uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/fourier-rã¦kker.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/fourier-rã¦kker.excalidraw"]
    "778uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-1.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-1.excalidraw"]
    "779uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-2.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-2.excalidraw"]
    "780uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-3.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-3.excalidraw"]
    "781uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-4.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/fourier-rã¦kker/opgave-4.excalidraw"]
    "782uni/notes/multivariable-calculus/opgaver/laplace/opgave-2.1-laplace.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/laplace/opgave-2.1-laplace.excalidraw"]
    "783uni/notes/multivariable-calculus/opgaver/multivariable-funktioner.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/multivariable-funktioner.excalidraw"]
    "784uni/notes/multivariable-calculus/opgaver/triple-integrals.excalidraw" [label="uni/notes/multivariable-calculus/opgaver/triple-integrals.excalidraw"]
    "785uni/notes/newnotes/bisection-method" [label="uni/notes/newnotes/bisection-method"]
    "786uni/notes/newnotes/boltzman-softmax-function" [label="uni/notes/newnotes/boltzman-softmax-function"]
    "787uni/notes/newnotes/bootstrapping-in-rl" [label="uni/notes/newnotes/bootstrapping-in-rl"]
    "788uni/notes/newnotes/converge-error" [label="uni/notes/newnotes/converge-error"]
    "789uni/notes/newnotes/error-analysis-for-linear-equations" [label="uni/notes/newnotes/error-analysis-for-linear-equations"]
    "790uni/notes/newnotes/false-position-method" [label="uni/notes/newnotes/false-position-method"]
    "791uni/notes/newnotes/game-plan" [label="uni/notes/newnotes/game-plan"]
    "792uni/notes/newnotes/game-plan-for-isa" [label="uni/notes/newnotes/game-plan-for-isa"]
    "793uni/notes/newnotes/isa-progress" [label="uni/notes/newnotes/isa-progress"]
    "794uni/notes/newnotes/lu-decompostion" [label="uni/notes/newnotes/lu-decompostion"]
    "795uni/notes/newnotes/least-squares-problems" [label="uni/notes/newnotes/least-squares-problems"]
    "796uni/notes/newnotes/linear-least-square-problems-org-tut" [label="uni/notes/newnotes/linear-least-square-problems-org-tut"]
    "797uni/notes/newnotes/numerical-integration" [label="uni/notes/newnotes/numerical-integration"]
    "798uni/notes/newnotes/nummerical-recipes" [label="uni/notes/newnotes/nummerical-recipes"]
    "799uni/notes/newnotes/popos-boot-entry-management" [label="uni/notes/newnotes/popos-boot-entry-management"]
    "800uni/notes/newnotes/rapport-kilder" [label="uni/notes/newnotes/rapport-kilder"]
    "801uni/notes/newnotes/richardson-extrapolation" [label="uni/notes/newnotes/richardson-extrapolation"]
    "802uni/notes/newnotes/singular-value-decomposition" [label="uni/notes/newnotes/singular-value-decomposition"]
    "803uni/notes/newnotes/videnskabsteori-overblik" [label="uni/notes/newnotes/videnskabsteori-overblik"]
    "804uni/notes/newnotes/virtual-monitor" [label="uni/notes/newnotes/virtual-monitor"]
    "805uni/notes/newnotes/info-function" [label="uni/notes/newnotes/info-function"]
    "806uni/notes/newnotes/mini-møder" [label="uni/notes/newnotes/mini-møder"]
    "807uni/notes/reguleringsteknik/noter/anti-windup" [label="uni/notes/reguleringsteknik/noter/anti-windup"]
    "808uni/notes/reguleringsteknik/noter/closed-loop-transfer-function" [label="uni/notes/reguleringsteknik/noter/closed-loop-transfer-function"]
    "809uni/notes/reguleringsteknik/noter/condition-for-controllability" [label="uni/notes/reguleringsteknik/noter/condition-for-controllability"]
    "810uni/notes/reguleringsteknik/noter/controllable-canonical-form" [label="uni/notes/reguleringsteknik/noter/controllable-canonical-form"]
    "811uni/notes/reguleringsteknik/noter/digitization" [label="uni/notes/reguleringsteknik/noter/digitization"]
    "812uni/notes/reguleringsteknik/noter/discrete-design" [label="uni/notes/reguleringsteknik/noter/discrete-design"]
    "813uni/notes/reguleringsteknik/noter/domã¦ner" [label="uni/notes/reguleringsteknik/noter/domã¦ner"]
    "814uni/notes/reguleringsteknik/noter/dã¦mpning-af-system" [label="uni/notes/reguleringsteknik/noter/dã¦mpning-af-system"]
    "815uni/notes/reguleringsteknik/noter/feedback-control" [label="uni/notes/reguleringsteknik/noter/feedback-control"]
    "816uni/notes/reguleringsteknik/noter/final-value-theorem" [label="uni/notes/reguleringsteknik/noter/final-value-theorem"]
    "817uni/notes/reguleringsteknik/noter/full-order-observer" [label="uni/notes/reguleringsteknik/noter/full-order-observer"]
    "818uni/notes/reguleringsteknik/noter/integral-control" [label="uni/notes/reguleringsteknik/noter/integral-control"]
    "819uni/notes/reguleringsteknik/noter/kalman-filter-&-random-variables" [label="uni/notes/reguleringsteknik/noter/kalman-filter-&-random-variables"]
    "820uni/notes/reguleringsteknik/noter/kaskade-kontrol" [label="uni/notes/reguleringsteknik/noter/kaskade-kontrol"]
    "821uni/notes/reguleringsteknik/noter/lead-&-lag-kompensatorer" [label="uni/notes/reguleringsteknik/noter/lead-&-lag-kompensatorer"]
    "822uni/notes/reguleringsteknik/noter/linear-invariante-systemer" [label="uni/notes/reguleringsteknik/noter/linear-invariante-systemer"]
    "823uni/notes/reguleringsteknik/noter/linearization" [label="uni/notes/reguleringsteknik/noter/linearization"]
    "824uni/notes/reguleringsteknik/noter/modellering-af-systemer/impulsmoment-sã¦tningen" [label="uni/notes/reguleringsteknik/noter/modellering-af-systemer/impulsmoment-sã¦tningen"]
    "825uni/notes/reguleringsteknik/noter/modellering-af-systemer/kontinã¦r-tids-tilstands-modeller" [label="uni/notes/reguleringsteknik/noter/modellering-af-systemer/kontinã¦r-tids-tilstands-modeller"]
    "826uni/notes/reguleringsteknik/noter/modellering-af-systemer/matlab-simulering" [label="uni/notes/reguleringsteknik/noter/modellering-af-systemer/matlab-simulering"]
    "827uni/notes/reguleringsteknik/noter/modellering-af-systemer/modellering-af-dynamiske-systemer" [label="uni/notes/reguleringsteknik/noter/modellering-af-systemer/modellering-af-dynamiske-systemer"]
    "828uni/notes/reguleringsteknik/noter/modellering-af-systemer/tidsdomã¦ne-modeller" [label="uni/notes/reguleringsteknik/noter/modellering-af-systemer/tidsdomã¦ne-modeller"]
    "829uni/notes/reguleringsteknik/noter/modellering-af-systemer/diskret-tids-tilstands-model" [label="uni/notes/reguleringsteknik/noter/modellering-af-systemer/diskret-tids-tilstands-model"]
    "830uni/notes/reguleringsteknik/noter/nyquist-stability-criterion" [label="uni/notes/reguleringsteknik/noter/nyquist-stability-criterion"]
    "831uni/notes/reguleringsteknik/noter/observability" [label="uni/notes/reguleringsteknik/noter/observability"]
    "832uni/notes/reguleringsteknik/noter/observer-based-control" [label="uni/notes/reguleringsteknik/noter/observer-based-control"]
    "833uni/notes/reguleringsteknik/noter/open-and-closed-loop-control-system" [label="uni/notes/reguleringsteknik/noter/open-and-closed-loop-control-system"]
    "834uni/notes/reguleringsteknik/noter/optimal-control" [label="uni/notes/reguleringsteknik/noter/optimal-control"]
    "835uni/notes/reguleringsteknik/noter/overshoot-risetime-og-settling-time" [label="uni/notes/reguleringsteknik/noter/overshoot-risetime-og-settling-time"]
    "836uni/notes/reguleringsteknik/noter/pid-controller" [label="uni/notes/reguleringsteknik/noter/pid-controller"]
    "837uni/notes/reguleringsteknik/noter/polers-indflydelse" [label="uni/notes/reguleringsteknik/noter/polers-indflydelse"]
    "838uni/notes/reguleringsteknik/noter/ratio-damping" [label="uni/notes/reguleringsteknik/noter/ratio-damping"]
    "839uni/notes/reguleringsteknik/noter/reference-signals" [label="uni/notes/reguleringsteknik/noter/reference-signals"]
    "840uni/notes/reguleringsteknik/noter/root-locus" [label="uni/notes/reguleringsteknik/noter/root-locus"]
    "841uni/notes/reguleringsteknik/noter/stability-margin-gain-and-phase" [label="uni/notes/reguleringsteknik/noter/stability-margin-gain-and-phase"]
    "842uni/notes/reguleringsteknik/noter/state-feedback" [label="uni/notes/reguleringsteknik/noter/state-feedback"]
    "843uni/notes/reguleringsteknik/noter/steady-state-tracking" [label="uni/notes/reguleringsteknik/noter/steady-state-tracking"]
    "844uni/notes/reguleringsteknik/noter/relation-mellem-s-og-z-domã¦ne" [label="uni/notes/reguleringsteknik/noter/relation-mellem-s-og-z-domã¦ne"]
    "845uni/notes/robotics/actions" [label="uni/notes/robotics/actions"]
    "846uni/notes/robotics/build-and-run-ros" [label="uni/notes/robotics/build-and-run-ros"]
    "847uni/notes/robotics/coverage-planning" [label="uni/notes/robotics/coverage-planning"]
    "848uni/notes/robotics/localization" [label="uni/notes/robotics/localization"]
    "849uni/notes/robotics/nodes" [label="uni/notes/robotics/nodes"]
    "850uni/notes/robotics/odometry" [label="uni/notes/robotics/odometry"]
    "851uni/notes/robotics/parameters" [label="uni/notes/robotics/parameters"]
    "852uni/notes/robotics/ros2-basics" [label="uni/notes/robotics/ros2-basics"]
    "853uni/notes/robotics/sampling-based-planning" [label="uni/notes/robotics/sampling-based-planning"]
    "854uni/notes/robotics/service" [label="uni/notes/robotics/service"]
    "855uni/notes/robotics/topics" [label="uni/notes/robotics/topics"]
    "856uni/notes/robotters-fysik/bevã¦gelsesmã¦ngder/bevã¦gelsesmã¦ngde-for-et-partikel" [label="uni/notes/robotters-fysik/bevã¦gelsesmã¦ngder/bevã¦gelsesmã¦ngde-for-et-partikel"]
    "857uni/notes/robotters-fysik/bevã¦gelsesmã¦ngder/bevã¦gelsesmã¦ngde" [label="uni/notes/robotters-fysik/bevã¦gelsesmã¦ngder/bevã¦gelsesmã¦ngde"]
    "858uni/notes/robotters-fysik/bevã¦gelsesmã¦ngder/elastisk-stã¸d" [label="uni/notes/robotters-fysik/bevã¦gelsesmã¦ngder/elastisk-stã¸d"]
    "859uni/notes/robotters-fysik/dã¦mpede-svingninger" [label="uni/notes/robotters-fysik/dã¦mpede-svingninger"]
    "860uni/notes/robotters-fysik/effekt-og-arbejde" [label="uni/notes/robotters-fysik/effekt-og-arbejde"]
    "861uni/notes/robotters-fysik/eksamen/flytningsformel" [label="uni/notes/robotters-fysik/eksamen/flytningsformel"]
    "862uni/notes/robotters-fysik/eksamen/matematisk-pendul" [label="uni/notes/robotters-fysik/eksamen/matematisk-pendul"]
    "863uni/notes/robotters-fysik/flytningsmoment" [label="uni/notes/robotters-fysik/flytningsmoment"]
    "864uni/notes/robotters-fysik/fysisk-pendul" [label="uni/notes/robotters-fysik/fysisk-pendul"]
    "865uni/notes/robotters-fysik/harmoniske-bevã¦gelser" [label="uni/notes/robotters-fysik/harmoniske-bevã¦gelser"]
    "866uni/notes/robotters-fysik/inertimoment-og-flytningsmoment" [label="uni/notes/robotters-fysik/inertimoment-og-flytningsmoment"]
    "867uni/notes/robotters-fysik/kraftmoment." [label="uni/notes/robotters-fysik/kraftmoment."]
    "868uni/notes/robotters-fysik/matematisk-pendul" [label="uni/notes/robotters-fysik/matematisk-pendul"]
    "869uni/notes/robotters-fysik/pendul-i-store-vinkler" [label="uni/notes/robotters-fysik/pendul-i-store-vinkler"]
    "870uni/notes/robotters-fysik/potentiel-og-kinetisk-energi" [label="uni/notes/robotters-fysik/potentiel-og-kinetisk-energi"]
    "871uni/notes/robotters-fysik/rulning" [label="uni/notes/robotters-fysik/rulning"]
    "872uni/notes/robotters-fysik/stift-legemes-rotation" [label="uni/notes/robotters-fysik/stift-legemes-rotation"]
    "873uni/notes/robotters-fysik/tabeller/densitet" [label="uni/notes/robotters-fysik/tabeller/densitet"]
    "874uni/notes/robotters-fysik/tabeller/restitutionskoefficient" [label="uni/notes/robotters-fysik/tabeller/restitutionskoefficient"]
    "875uni/notes/robotters-fysik/tvungne-svingninger" [label="uni/notes/robotters-fysik/tvungne-svingninger"]
    "876uni/notes/robotters-fysik/vigtige-formler" [label="uni/notes/robotters-fysik/vigtige-formler"]
    "877uni/notes/shared-memory/inter-process-communication" [label="uni/notes/shared-memory/inter-process-communication"]
    "878uni/notes/signalbehandling/exercises/lektion-1-hã¸j-og-lavpas-filtre" [label="uni/notes/signalbehandling/exercises/lektion-1-hã¸j-og-lavpas-filtre"]
    "879uni/notes/signalbehandling/exercises/lektion-2-sampling-og-rekonstruktion" [label="uni/notes/signalbehandling/exercises/lektion-2-sampling-og-rekonstruktion"]
    "880uni/notes/signalbehandling/lecture-notes/amplitudegrafer" [label="uni/notes/signalbehandling/lecture-notes/amplitudegrafer"]
    "881uni/notes/signalbehandling/lecture-notes/differensligninger" [label="uni/notes/signalbehandling/lecture-notes/differensligninger"]
    "882uni/notes/signalbehandling/lecture-notes/direkte-type-1-og-2" [label="uni/notes/signalbehandling/lecture-notes/direkte-type-1-og-2"]
    "883uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/bessel-butterworth-&-chebushev" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/bessel-butterworth-&-chebushev"]
    "884uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/bessel" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/bessel"]
    "885uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/butterworth" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/butterworth"]
    "886uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/chebyshevfilter" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/chebyshevfilter"]
    "887uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/filtre-typer" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/filtre-typer"]
    "888uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/gruppeløbstid" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/gruppeløbstid"]
    "889uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/højpasfilter" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/højpasfilter"]
    "890uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/konstruktion-af-filter" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/konstruktion-af-filter"]
    "891uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/lavpas-til-båndpasfilter" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/lavpas-til-båndpasfilter"]
    "892uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/lavpas-til-højpasfilter" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/lavpas-til-højpasfilter"]
    "893uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/valg-af-filter" [label="uni/notes/signalbehandling/lecture-notes/elektroniske-filtre/valg-af-filter"]
    "894uni/notes/signalbehandling/lecture-notes/fourier/lækage" [label="uni/notes/signalbehandling/lecture-notes/fourier/lækage"]
    "895uni/notes/signalbehandling/lecture-notes/fourier/picket-fencing" [label="uni/notes/signalbehandling/lecture-notes/fourier/picket-fencing"]
    "896uni/notes/signalbehandling/lecture-notes/iir-filtre" [label="uni/notes/signalbehandling/lecture-notes/iir-filtre"]
    "897uni/notes/signalbehandling/lecture-notes/invers-z-transformation" [label="uni/notes/signalbehandling/lecture-notes/invers-z-transformation"]
    "898uni/notes/signalbehandling/lecture-notes/kaskaderealisation" [label="uni/notes/signalbehandling/lecture-notes/kaskaderealisation"]
    "899uni/notes/signalbehandling/lecture-notes/overføringsfunktion-eksempel" [label="uni/notes/signalbehandling/lecture-notes/overføringsfunktion-eksempel"]
    "900uni/notes/signalbehandling/lecture-notes/parallelrealisation" [label="uni/notes/signalbehandling/lecture-notes/parallelrealisation"]
    "901uni/notes/signalbehandling/lecture-notes/relation-mellem-s-domæne-og-z-domæne" [label="uni/notes/signalbehandling/lecture-notes/relation-mellem-s-domæne-og-z-domæne"]
    "902uni/notes/signalbehandling/lecture-notes/sampling/aliasing" [label="uni/notes/signalbehandling/lecture-notes/sampling/aliasing"]
    "903uni/notes/signalbehandling/lecture-notes/sampling/amplitudespektrum" [label="uni/notes/signalbehandling/lecture-notes/sampling/amplitudespektrum"]
    "904uni/notes/signalbehandling/lecture-notes/sampling/differensligning-eksempel" [label="uni/notes/signalbehandling/lecture-notes/sampling/differensligning-eksempel"]
    "905uni/notes/signalbehandling/lecture-notes/sampling/frekvensanalyse" [label="uni/notes/signalbehandling/lecture-notes/sampling/frekvensanalyse"]
    "906uni/notes/signalbehandling/lecture-notes/sampling/impulssampling" [label="uni/notes/signalbehandling/lecture-notes/sampling/impulssampling"]
    "907uni/notes/signalbehandling/lecture-notes/sampling/nyquist-shannon-sætning" [label="uni/notes/signalbehandling/lecture-notes/sampling/nyquist-shannon-sætning"]
    "908uni/notes/signalbehandling/lecture-notes/sampling/overblik-over-systemer" [label="uni/notes/signalbehandling/lecture-notes/sampling/overblik-over-systemer"]
    "909uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/amplitudespektrum-for-pulssampling" [label="uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/amplitudespektrum-for-pulssampling"]
    "910uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/holdekredsløb" [label="uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/holdekredsløb"]
    "911uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/pulssampler-model" [label="uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/pulssampler-model"]
    "912uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/pulssampling-princip" [label="uni/notes/signalbehandling/lecture-notes/sampling/pulssampling/pulssampling-princip"]
    "913uni/notes/signalbehandling/lecture-notes/sampling/rekonstruktion/rekonstruktion-princip" [label="uni/notes/signalbehandling/lecture-notes/sampling/rekonstruktion/rekonstruktion-princip"]
    "914uni/notes/signalbehandling/lecture-notes/sampling/rekonstruktion/rekonstruktionsfilter" [label="uni/notes/signalbehandling/lecture-notes/sampling/rekonstruktion/rekonstruktionsfilter"]
    "915uni/notes/signalbehandling/lecture-notes/sampling/samplingfrekvens" [label="uni/notes/signalbehandling/lecture-notes/sampling/samplingfrekvens"]
    "916uni/notes/signalbehandling/lecture-notes/sampling/samplingsignalet" [label="uni/notes/signalbehandling/lecture-notes/sampling/samplingsignalet"]
    "917uni/notes/signalbehandling/lecture-notes/sampling/sekvens/laplacetransformeret-frekvens" [label="uni/notes/signalbehandling/lecture-notes/sampling/sekvens/laplacetransformeret-frekvens"]
    "918uni/notes/signalbehandling/lecture-notes/sampling/sekvens/sekvenser-definition" [label="uni/notes/signalbehandling/lecture-notes/sampling/sekvens/sekvenser-definition"]
    "919uni/notes/signalbehandling/lecture-notes/sampling/sekvens/standard-frekvenser" [label="uni/notes/signalbehandling/lecture-notes/sampling/sekvens/standard-frekvenser"]
    "920uni/notes/signalbehandling/lecture-notes/stepfunktion" [label="uni/notes/signalbehandling/lecture-notes/stepfunktion"]
    "921uni/notes/signalbehandling/lecture-notes/vinduer/barlett-vindue" [label="uni/notes/signalbehandling/lecture-notes/vinduer/barlett-vindue"]
    "922uni/notes/signalbehandling/lecture-notes/vinduer/hamming-og-hanning" [label="uni/notes/signalbehandling/lecture-notes/vinduer/hamming-og-hanning"]
    "923uni/notes/signalbehandling/lecture-notes/vinduer/kaiser-vindue" [label="uni/notes/signalbehandling/lecture-notes/vinduer/kaiser-vindue"]
    "924uni/notes/signalbehandling/lecture-notes/vinduer/rektangulært-vindue" [label="uni/notes/signalbehandling/lecture-notes/vinduer/rektangulært-vindue"]
    "925uni/notes/signalbehandling/lecture-notes/vinduer/vinduesfunktion" [label="uni/notes/signalbehandling/lecture-notes/vinduer/vinduesfunktion"]
    "926uni/notes/softwareudvikling/databaser/normalisering-af-data" [label="uni/notes/softwareudvikling/databaser/normalisering-af-data"]
    "927uni/notes/softwareudvikling/sql/groups" [label="uni/notes/softwareudvikling/sql/groups"]
    "928uni/notes/softwareudvikling/sql/having" [label="uni/notes/softwareudvikling/sql/having"]
    "929uni/notes/softwareudvikling/sql/join" [label="uni/notes/softwareudvikling/sql/join"]
    "930uni/notes/softwareudvikling/sql/sql-kommandoer" [label="uni/notes/softwareudvikling/sql/sql-kommandoer"]
    "931uni/notes/softwareudvikling/uml/generel-uml" [label="uni/notes/softwareudvikling/uml/generel-uml"]
    "932uni/notes/softwareudvikling/udvikling/faser-i-traditionel-softwareudvikling" [label="uni/notes/softwareudvikling/udvikling/faser-i-traditionel-softwareudvikling"]
    "933uni/notes/softwareudvikling/udvikling/typer-af-systemer" [label="uni/notes/softwareudvikling/udvikling/typer-af-systemer"]
    "934uni/notes/softwareudvikling/udvikling/untitled" [label="uni/notes/softwareudvikling/udvikling/untitled"]
    "935uni/notes/statistik/anova-tables" [label="uni/notes/statistik/anova-tables"]
    "936uni/notes/statistik/exam-test" [label="uni/notes/statistik/exam-test"]
    "937uni/notes/statistik/formler" [label="uni/notes/statistik/formler"]
    "938uni/notes/statistik/inference-for-simple-linear-regression" [label="uni/notes/statistik/inference-for-simple-linear-regression"]
    "939uni/notes/statistik/komplet-beskrivelse" [label="uni/notes/statistik/komplet-beskrivelse"]
    "940uni/notes/statistik/kontinuerte-stokastiske-variable" [label="uni/notes/statistik/kontinuerte-stokastiske-variable"]
    "941uni/notes/statistik/matlab-commands" [label="uni/notes/statistik/matlab-commands"]
    "942uni/notes/statistik/simultaneous-random-variables" [label="uni/notes/statistik/simultaneous-random-variables"]
    "943uni/notes/statistik/terminologi" [label="uni/notes/statistik/terminologi"]
    "944uni/semesters/semester-1" [label="uni/semesters/semester-1"]
    "945uni/semesters/semester-2" [label="uni/semesters/semester-2"]
    "946uni/semesters/semester-3" [label="uni/semesters/semester-3"]
    "947uni/semesters/semester-4" [label="uni/semesters/semester-4"]
    "948uni/semesters/semester-5" [label="uni/semesters/semester-5"]
    "949uni/semesters/semester-6" [label="uni/semesters/semester-6"]
    "950uni/semesters/semester-7" [label="uni/semesters/semester-7"]
    "951uni/slides/initial-value-problem-lecture" [label="uni/slides/initial-value-problem-lecture"]
    "952uni/slides/intro-til-numeriske-metoder" [label="uni/slides/intro-til-numeriske-metoder"]
    "953uni/slides/lecture-4-svd-and-error-analysis" [label="uni/slides/lecture-4-svd-and-error-analysis"]
    "954uni/slides/lecture-6-convergence-and-root-finding-error" [label="uni/slides/lecture-6-convergence-and-root-finding-error"]
    "955uni/slides/lecture-8-numerical-integration" [label="uni/slides/lecture-8-numerical-integration"]
    "956uni/slides/lecture-9-newton-cotes-quadratures" [label="uni/slides/lecture-9-newton-cotes-quadratures"]
    "957uni/slides/lecture-least-square-problems" [label="uni/slides/lecture-least-square-problems"]
    "958uni/slides/lecture-linear-least-squares-problems" [label="uni/slides/lecture-linear-least-squares-problems"]
    "959uni/slides/numerical-book" [label="uni/slides/numerical-book"]
    "960uni/slides/penzaboard" [label="uni/slides/penzaboard"]
    "961uni/slides/portfolio" [label="uni/slides/portfolio"]
    "962uni/slides/root-finding-lecture" [label="uni/slides/root-finding-lecture"]
    "963uni/slides/systems-of-non-linear-equations-lecture" [label="uni/slides/systems-of-non-linear-equations-lecture"]
    "964uni/slides/videnskabsteori-intro" [label="uni/slides/videnskabsteori-intro"]
    "965uni/slides/lecture-12" [label="uni/slides/lecture-12"]
    "966uni/exam" [label="uni/exam"]
    "967untitled" [label="untitled"]
    "968written_markdown/expected" [label="written_markdown/expected"]
    "969written_markdown/ollamatest" [label="written_markdown/ollamatest"]
    "970written_markdown/page-1" [label="written_markdown/page-1"]

    "62formelsamling/overfã¸ringsfunktion" -> "54formelsamling/laplace-transformation"
    "72formelsamling/vinduesfunktion" -> "72formelsamling/vinduesfunktion"
    "163uni/notes/1-formelsamlinger/formelsamling-calculus" -> "72formelsamling/vinduesfunktion"
    "286uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-1" -> "285uni/notes/computer-arkitektur/noter/micro-architecture-level/ijvm-instruction-set"
    "288uni/notes/computer-arkitektur/noter/micro-architecture-level/mic-3" -> "285uni/notes/computer-arkitektur/noter/micro-architecture-level/ijvm-instruction-set"
    "503uni/notes/datateknik/assembly/instructions/add" -> "481uni/notes/datateknik/atmega32/add-or-multiply-function"
    "555uni/notes/datateknik/microcontrollers/assembly/instructions/add" -> "481uni/notes/datateknik/atmega32/add-or-multiply-function"
    "669uni/notes/elektro-fysik/komponenter-og-subcircuits" -> "670uni/notes/elektro-fysik/kondensator"
    "789uni/notes/newnotes/error-analysis-for-linear-equations" -> "802uni/notes/newnotes/singular-value-decomposition"
    "876uni/notes/robotters-fysik/vigtige-formler" -> "860uni/notes/robotters-fysik/effekt-og-arbejde"
    "894uni/notes/signalbehandling/lecture-notes/fourier/lækage" -> "72formelsamling/vinduesfunktion"
}

:b shell 74
python3 examples/5_create_vault.py tmp_test_vault && rm -rf tmp_test_vault
:i returncode 0
:b stdout 873
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

Vault created successfully at 'tmp_test_vault' with 38 notes!

:b shell 77
python3 examples/6_rename_note.py test-vaults/simle_vault first_note    FIRST
:i returncode 1
:b stdout 0

:b shell 80
python3 examples/6_rename_note.py test-vaults/simle_vault first_note.md FIRST.md
:i returncode 1
:b stdout 0

:b shell 68
python3 examples/7_add_frontmatter.py "test-vaults/Obsidian Sandbox"
:i returncode 0
:b stdout 1737
Adding frontmatter to 'From plain-text note-taking' in directory 'Adventurer'
Adding frontmatter to 'From standard note-taking' in directory 'Adventurer'
Adding frontmatter to 'No prior experience' in directory 'Adventurer'
Adding frontmatter to 'Blockquote' in directory 'Formatting'
Adding frontmatter to 'Callout' in directory 'Formatting'
Adding frontmatter to 'Code block' in directory 'Formatting'
Adding frontmatter to 'Comment' in directory 'Formatting'
Adding frontmatter to 'Diagram' in directory 'Formatting'
Adding frontmatter to 'Embeds' in directory 'Formatting'
Adding frontmatter to 'Emphasis' in directory 'Formatting'
Adding frontmatter to 'Footnote' in directory 'Formatting'
Adding frontmatter to 'Format your notes' in directory 'Formatting'
Adding frontmatter to 'Heading' in directory 'Formatting'
Adding frontmatter to 'Highlighting' in directory 'Formatting'
Adding frontmatter to 'Horizontal divider' in directory 'Formatting'
Adding frontmatter to 'Images' in directory 'Formatting'
Adding frontmatter to 'Inline code' in directory 'Formatting'
Adding frontmatter to 'Internal link' in directory 'Formatting'
Adding frontmatter to 'Links' in directory 'Formatting'
Adding frontmatter to 'Lists' in directory 'Formatting'
Adding frontmatter to 'Math' in directory 'Formatting'
Adding frontmatter to 'Strikethrough' in directory 'Formatting'
Adding frontmatter to 'Table' in directory 'Formatting'
Adding frontmatter to 'Task' in directory 'Formatting'
Adding frontmatter to 'Create a vault' in directory 'Guides'
Adding frontmatter to 'Create your first note' in directory 'Guides'
Adding frontmatter to 'Get started with Obsidian' in directory 'Guides'
Adding frontmatter to 'Link notes' in directory 'Guides'

:b shell 73
python3 examples/7_add_frontmatter.py "test-vaults/BalderHolst_uni-notes"
:i returncode 0
:b stdout 31818
'Drawing 2022-11-17 12.34.37.excalidraw' already has frontmatter, skipping.
'Truth-table to MUX' already has frontmatter, skipping.
'fysik PA' already has frontmatter, skipping.
Adding frontmatter to 'AC' in directory 'Notes'
Adding frontmatter to 'ADC' in directory 'Notes'
Adding frontmatter to 'ALU' in directory 'Notes'
Adding frontmatter to 'ARM' in directory 'Notes'
Adding frontmatter to 'ARP Packet' in directory 'Notes'
Adding frontmatter to 'AVR Ports' in directory 'Notes'
Adding frontmatter to 'Abstract Classes in C++' in directory 'Notes'
Adding frontmatter to 'Acceleration af partikler' in directory 'Notes'
Adding frontmatter to 'Algorithms and Data Structures' in directory 'Notes'
Adding frontmatter to 'Amdahl's Law' in directory 'Notes'
Adding frontmatter to 'Andengradspolynomier' in directory 'Notes'
Adding frontmatter to 'Andenordens inhomogene differentialligninger' in directory 'Notes'
Adding frontmatter to 'Andenordensdifferentialligninger' in directory 'Notes'
Adding frontmatter to 'Angle-Set Conventions' in directory 'Notes'
Adding frontmatter to 'Anti Aliasering Filter' in directory 'Notes'
Adding frontmatter to 'Anti-Windup' in directory 'Notes'
Adding frontmatter to 'Antisymetrisk' in directory 'Notes'
Adding frontmatter to 'Approximation' in directory 'Notes'
Adding frontmatter to 'Arbejde' in directory 'Notes'
Adding frontmatter to 'Arc Length' in directory 'Notes'
Adding frontmatter to 'Arrays in C++' in directory 'Notes'
Adding frontmatter to 'Artificial Intelligence' in directory 'Notes'
Adding frontmatter to 'Assembly' in directory 'Notes'
Adding frontmatter to 'Assumptions of Kinematics' in directory 'Notes'
Adding frontmatter to 'Asymptotic Relative Efficiency (ARE)' in directory 'Notes'
Adding frontmatter to 'At Gøre Prøve' in directory 'Notes'
Adding frontmatter to 'Axis Angle' in directory 'Notes'
Adding frontmatter to 'Bandwidth' in directory 'Notes'
Adding frontmatter to 'Basis' in directory 'Notes'
Adding frontmatter to 'Bayesian Learning' in directory 'Notes'
Adding frontmatter to 'Bayesian Networks' in directory 'Notes'
Adding frontmatter to 'Bellman-Ford* Algorithm' in directory 'Notes'
Adding frontmatter to 'Bessel' in directory 'Notes'
Adding frontmatter to 'Bevis for 2. Løsningsformel' in directory 'Notes'
Adding frontmatter to 'Bevis for Parameterfremstilling' in directory 'Notes'
Adding frontmatter to 'Bevis for den Gennerelle Løsningsformel til Linære Førsteordensdifferentialligninger' in directory 'Notes'
Adding frontmatter to 'Beviser' in directory 'Notes'
Adding frontmatter to 'Bevægelse på Skråplan' in directory 'Notes'
Adding frontmatter to 'Bevægelsesmængde (Impuls)' in directory 'Notes'
Adding frontmatter to 'Bevægelsesmængdemoment' in directory 'Notes'
Adding frontmatter to 'Bias' in directory 'Notes'
Adding frontmatter to 'Big-O Notation' in directory 'Notes'
Adding frontmatter to 'Bilineær z-transformation' in directory 'Notes'
Adding frontmatter to 'Binomial Distribution' in directory 'Notes'
Adding frontmatter to 'Bivariate Distribution' in directory 'Notes'
Adding frontmatter to 'Bode Plot' in directory 'Notes'
Adding frontmatter to 'Bolzmanns Konstant' in directory 'Notes'
Adding frontmatter to 'Boolean Algebra' in directory 'Notes'
Adding frontmatter to 'Breadth-first Search' in directory 'Notes'
Adding frontmatter to 'Butterworth Filter' in directory 'Notes'
Adding frontmatter to 'Bølgeformlen' in directory 'Notes'
Adding frontmatter to 'C Libraries' in directory 'Notes'
Adding frontmatter to 'C++ Streams' in directory 'Notes'
Adding frontmatter to 'Cascade Control' in directory 'Notes'
Adding frontmatter to 'Central Limit Theorem' in directory 'Notes'
Adding frontmatter to 'Centripetalacceleration' in directory 'Notes'
Adding frontmatter to 'Centripetalkraft' in directory 'Notes'
Adding frontmatter to 'Change of Variables' in directory 'Notes'
Adding frontmatter to 'Chebyshev Filter' in directory 'Notes'
Adding frontmatter to 'Cholesky Decomposition' in directory 'Notes'
Adding frontmatter to 'Circles' in directory 'Notes'
Adding frontmatter to 'Cirklens Ligning' in directory 'Notes'
Adding frontmatter to 'Classes in C++' in directory 'Notes'
Adding frontmatter to 'Classification of Second order PDEs' in directory 'Notes'
Adding frontmatter to 'Common Mode Rejection Ratio' in directory 'Notes'
Adding frontmatter to 'Confidence Interval' in directory 'Notes'
Adding frontmatter to 'Control System Performance' in directory 'Notes'
Adding frontmatter to 'Control Systems' in directory 'Notes'
Adding frontmatter to 'Controllability' in directory 'Notes'
Adding frontmatter to 'Controllable Canonical Form' in directory 'Notes'
Adding frontmatter to 'Convergence of Random Variables' in directory 'Notes'
Adding frontmatter to 'Coulumbs Lov' in directory 'Notes'
Adding frontmatter to 'Coulumbs konstant' in directory 'Notes'
Adding frontmatter to 'Covariance and Correlation' in directory 'Notes'
Adding frontmatter to 'Covariance' in directory 'Notes'
Adding frontmatter to 'Craig's Notation' in directory 'Notes'
Adding frontmatter to 'Critical Value' in directory 'Notes'
Adding frontmatter to 'Curl' in directory 'Notes'
Adding frontmatter to 'Cylindrical Coordinates' in directory 'Notes'
Adding frontmatter to 'D Latch' in directory 'Notes'
Adding frontmatter to 'DC Amplification' in directory 'Notes'
Adding frontmatter to 'DC' in directory 'Notes'
Adding frontmatter to 'DH-Parameters' in directory 'Notes'
Adding frontmatter to 'DHCP' in directory 'Notes'
Adding frontmatter to 'Data Communication' in directory 'Notes'
Adding frontmatter to 'Data Link Layer' in directory 'Notes'
Adding frontmatter to 'De kinematiske ligninger' in directory 'Notes'
Adding frontmatter to 'Decibel' in directory 'Notes'
Adding frontmatter to 'Deep Learning' in directory 'Notes'
Adding frontmatter to 'Degrees of Freedom' in directory 'Notes'
Adding frontmatter to 'Delay through filter (gruppeløstid)' in directory 'Notes'
Adding frontmatter to 'Delta Method' in directory 'Notes'
Adding frontmatter to 'Den retningsafledte' in directory 'Notes'
Adding frontmatter to 'Densitet' in directory 'Notes'
Adding frontmatter to 'Depth-first Search' in directory 'Notes'
Adding frontmatter to 'Det Komplekse Plan' in directory 'Notes'
Adding frontmatter to 'Determinanen for Matricer' in directory 'Notes'
Adding frontmatter to 'Diagonalization' in directory 'Notes'
Adding frontmatter to 'Diagonalmatrix' in directory 'Notes'
Adding frontmatter to 'Differensligninger' in directory 'Notes'
Adding frontmatter to 'Differential Equations' in directory 'Notes'
Adding frontmatter to 'Differentialregning - Basis' in directory 'Notes'
Adding frontmatter to 'Differentialregning Regneregler' in directory 'Notes'
Adding frontmatter to 'Differentialregning' in directory 'Notes'
Adding frontmatter to 'Differentiation af funktioner med to variable' in directory 'Notes'
Adding frontmatter to 'Differentiator' in directory 'Notes'
Adding frontmatter to 'Digital Realisation Structures' in directory 'Notes'
Adding frontmatter to 'Digitization' in directory 'Notes'
Adding frontmatter to 'Dijkstra’s Algorithm' in directory 'Notes'
Adding frontmatter to 'Dioder' in directory 'Notes'
Adding frontmatter to 'Dirac Delta Function' in directory 'Notes'
Adding frontmatter to 'Direct Samling' in directory 'Notes'
Adding frontmatter to 'Directories in C' in directory 'Notes'
Adding frontmatter to 'Diskret Fourier Transformation' in directory 'Notes'
Adding frontmatter to 'Distributions' in directory 'Notes'
Adding frontmatter to 'Disturbance Rejection' in directory 'Notes'
Adding frontmatter to 'Divergence' in directory 'Notes'
Adding frontmatter to 'Dynamic Bayesian Networks' in directory 'Notes'
Adding frontmatter to 'Dynamic Compensation' in directory 'Notes'
Adding frontmatter to 'Dynamic Inference' in directory 'Notes'
Adding frontmatter to 'Dynamic Memory Allocation' in directory 'Notes'
Adding frontmatter to 'Dæmpede Svingninger - Differentialligning 1' in directory 'Notes'
Adding frontmatter to 'Dæmpede Svingninger - Differentialligning' in directory 'Notes'
Adding frontmatter to 'Edmonds Karp Algorithm' in directory 'Notes'
Adding frontmatter to 'Effekt' in directory 'Notes'
Adding frontmatter to 'Eigen values and vectors' in directory 'Notes'
Adding frontmatter to 'Eigendecomposition' in directory 'Notes'
Adding frontmatter to 'Einsteins Fotoelektriske Lov' in directory 'Notes'
Adding frontmatter to 'Eksponentielle Funktioner' in directory 'Notes'
Adding frontmatter to 'Elektrisk Resonans' in directory 'Notes'
Adding frontmatter to 'Elektroner' in directory 'Notes'
Adding frontmatter to 'Elementarladningen' in directory 'Notes'
Adding frontmatter to 'Elementarpartiklers Bølgeegenskaber' in directory 'Notes'
Adding frontmatter to 'Embedded' in directory 'Notes'
Adding frontmatter to 'Emperical CDF' in directory 'Notes'
Adding frontmatter to 'En-en-tydig Funktion' in directory 'Notes'
Adding frontmatter to 'Energi' in directory 'Notes'
Adding frontmatter to 'Error Analysis' in directory 'Notes'
Adding frontmatter to 'Ethernet' in directory 'Notes'
Adding frontmatter to 'Euler-Lagrange Modelling' in directory 'Notes'
Adding frontmatter to 'Eulers Formel' in directory 'Notes'
Adding frontmatter to 'Expectation' in directory 'Notes'
Adding frontmatter to 'Exponential Distribution' in directory 'Notes'
Adding frontmatter to 'FAN-OUT' in directory 'Notes'
Adding frontmatter to 'FIR Filtre' in directory 'Notes'
Adding frontmatter to 'Fast Fourier transformation (FFT)' in directory 'Notes'
Adding frontmatter to 'Feed Forward' in directory 'Notes'
Adding frontmatter to 'Feedback Control' in directory 'Notes'
Adding frontmatter to 'Fejlberegning på Operationsforstærker' in directory 'Notes'
Adding frontmatter to 'File Metadata' in directory 'Notes'
Adding frontmatter to 'Files' in directory 'Notes'
Adding frontmatter to 'Filter Transformations' in directory 'Notes'
Adding frontmatter to 'Filters' in directory 'Notes'
Adding frontmatter to 'First-Order Logic' in directory 'Notes'
Adding frontmatter to 'Fisher Information' in directory 'Notes'
Adding frontmatter to 'Fjederkraft' in directory 'Notes'
Adding frontmatter to 'Flytningsformlen' in directory 'Notes'
Adding frontmatter to 'Foldningssum' in directory 'Notes'
Adding frontmatter to 'Ford Fulkerson Algorithm' in directory 'Notes'
Adding frontmatter to 'Fordampningsenergi' in directory 'Notes'
Adding frontmatter to 'Fordoblings- og halveringkonstant' in directory 'Notes'
Adding frontmatter to 'Forward Kinematics' in directory 'Notes'
Adding frontmatter to 'Forwarding Table' in directory 'Notes'
Adding frontmatter to 'Fotoelektrisk Effekt' in directory 'Notes'
Adding frontmatter to 'Fotoner' in directory 'Notes'
Adding frontmatter to 'Fourier-transformation' in directory 'Notes'
Adding frontmatter to 'Fourieseries' in directory 'Notes'
Adding frontmatter to 'Frames' in directory 'Notes'
Adding frontmatter to 'Frekvens' in directory 'Notes'
Adding frontmatter to 'Frequency Response' in directory 'Notes'
Adding frontmatter to 'Friktion' in directory 'Notes'
Adding frontmatter to 'Fuldstændig og partikulær løsning' in directory 'Notes'
Adding frontmatter to 'Full Adder' in directory 'Notes'
Adding frontmatter to 'Funktioner af flere Variable' in directory 'Notes'
Adding frontmatter to 'Førsteordensdifferentialligninger' in directory 'Notes'
Adding frontmatter to 'Gain Margins' in directory 'Notes'
Adding frontmatter to 'Gates' in directory 'Notes'
Adding frontmatter to 'Gauss's Divergence Theorem' in directory 'Notes'
Adding frontmatter to 'Gaussian Distribution' in directory 'Notes'
Adding frontmatter to 'Generalized Coordinates' in directory 'Notes'
Adding frontmatter to 'Gimbal Lock' in directory 'Notes'
Adding frontmatter to 'Gnidning' in directory 'Notes'
Adding frontmatter to 'Gnidningsmordstand gennem Luft' in directory 'Notes'
Adding frontmatter to 'Gradient' in directory 'Notes'
Adding frontmatter to 'Gravitation' in directory 'Notes'
Adding frontmatter to 'Gray Codes' in directory 'Notes'
Adding frontmatter to 'Green's Theorem' in directory 'Notes'
Adding frontmatter to 'Grænser' in directory 'Notes'
Adding frontmatter to 'Halveringtid' in directory 'Notes'
Adding frontmatter to 'Hamming Distance' in directory 'Notes'
Adding frontmatter to 'Harmoniske svingninger' in directory 'Notes'
Adding frontmatter to 'Hastighed og Fart' in directory 'Notes'
Adding frontmatter to 'Hello World in C++' in directory 'Notes'
Adding frontmatter to 'Hidden Markov Models' in directory 'Notes'
Adding frontmatter to 'Homogeneous Functions' in directory 'Notes'
Adding frontmatter to 'Hvordan skriver man en videnskabelig artikel' in directory 'Notes'
Adding frontmatter to 'Hypothesis Testing' in directory 'Notes'
Adding frontmatter to 'Hældningsfelt' in directory 'Notes'
Adding frontmatter to 'IID' in directory 'Notes'
Adding frontmatter to 'IIR Filters' in directory 'Notes'
Adding frontmatter to 'IPv4' in directory 'Notes'
Adding frontmatter to 'IPv6' in directory 'Notes'
Adding frontmatter to 'Identity Matrix' in directory 'Notes'
Adding frontmatter to 'Impedans' in directory 'Notes'
Adding frontmatter to 'Impule Inveriant z-transformation' in directory 'Notes'
Adding frontmatter to 'Impulse Response' in directory 'Notes'
Adding frontmatter to 'Impulse Sampling' in directory 'Notes'
Adding frontmatter to 'Impulsmoment' in directory 'Notes'
Adding frontmatter to 'Indre og Ydre Produkt' in directory 'Notes'
Adding frontmatter to 'Inertimoment' in directory 'Notes'
Adding frontmatter to 'Insertion Sort' in directory 'Notes'
Adding frontmatter to 'Integral Control' in directory 'Notes'
Adding frontmatter to 'Integral Table' in directory 'Notes'
Adding frontmatter to 'Integraler Regneregler' in directory 'Notes'
Adding frontmatter to 'Integraler' in directory 'Notes'
Adding frontmatter to 'Integralregning - Basis' in directory 'Notes'
Adding frontmatter to 'Integration med Substidution' in directory 'Notes'
Adding frontmatter to 'Integrator' in directory 'Notes'
Adding frontmatter to 'Intel x86 Architecture' in directory 'Notes'
Adding frontmatter to 'Intelligent Systems' in directory 'Notes'
Adding frontmatter to 'Interfaces in C++' in directory 'Notes'
Adding frontmatter to 'Interupts' in directory 'Notes'
Adding frontmatter to 'Inverse Kinematics' in directory 'Notes'
Adding frontmatter to 'Inverse Matrix' in directory 'Notes'
Adding frontmatter to 'Jacobian Matrix for Robotics' in directory 'Notes'
Adding frontmatter to 'Jacobian Matrix' in directory 'Notes'
Adding frontmatter to 'Jævn Cirkelbevægelse' in directory 'Notes'
Adding frontmatter to 'KCL' in directory 'Notes'
Adding frontmatter to 'KVL' in directory 'Notes'
Adding frontmatter to 'Kalman Filter' in directory 'Notes'
Adding frontmatter to 'Karatsuba Algorithm' in directory 'Notes'
Adding frontmatter to 'Karnaugh Map' in directory 'Notes'
Adding frontmatter to 'Keplers Lov' in directory 'Notes'
Adding frontmatter to 'Kinematrics' in directory 'Notes'
Adding frontmatter to 'Kinetic Energy' in directory 'Notes'
Adding frontmatter to 'Kinetisk Energi' in directory 'Notes'
Adding frontmatter to 'Knudepunktsmetoden' in directory 'Notes'
Adding frontmatter to 'Koblede Førsteordensdifferentialligninger' in directory 'Notes'
Adding frontmatter to 'Komparator' in directory 'Notes'
Adding frontmatter to 'Komplekse Tal' in directory 'Notes'
Adding frontmatter to 'Kondensator' in directory 'Notes'
Adding frontmatter to 'Konduktans' in directory 'Notes'
Adding frontmatter to 'Konservative og ikke-konservative kræfter' in directory 'Notes'
Adding frontmatter to 'Koordinatsystem og Flader' in directory 'Notes'
Adding frontmatter to 'Kosaraju’s Algorithm' in directory 'Notes'
Adding frontmatter to 'Kraftmoment' in directory 'Notes'
Adding frontmatter to 'Kredsløb' in directory 'Notes'
Adding frontmatter to 'Kvadratkomplettering' in directory 'Notes'
Adding frontmatter to 'LU Decomposition' in directory 'Notes'
Adding frontmatter to 'Ladning i en Kugle' in directory 'Notes'
Adding frontmatter to 'Ladningers bevægelse i et kuglesymmetrisk felt' in directory 'Notes'
Adding frontmatter to 'Laplace Transformation' in directory 'Notes'
Adding frontmatter to 'Laplace's Equation' in directory 'Notes'
Adding frontmatter to 'Laplaces lov' in directory 'Notes'
Adding frontmatter to 'Laplacian Operator' in directory 'Notes'
Adding frontmatter to 'Latch' in directory 'Notes'
Adding frontmatter to 'Law of Cosines' in directory 'Notes'
Adding frontmatter to 'Law of Large Number' in directory 'Notes'
Adding frontmatter to 'Least Squared Problem' in directory 'Notes'
Adding frontmatter to 'Ledere og Isolatorer' in directory 'Notes'
Adding frontmatter to 'Libraries in C++' in directory 'Notes'
Adding frontmatter to 'Library Interpositioning' in directory 'Notes'
Adding frontmatter to 'Ligninssystemer Uden Løsninger' in directory 'Notes'
Adding frontmatter to 'Linarisering' in directory 'Notes'
Adding frontmatter to 'Line Coding' in directory 'Notes'
Adding frontmatter to 'Line Integrals' in directory 'Notes'
Adding frontmatter to 'Linear Algebra' in directory 'Notes'
Adding frontmatter to 'Linear Classification' in directory 'Notes'
Adding frontmatter to 'Linear Systems' in directory 'Notes'
Adding frontmatter to 'Lineært Tidsinvariant System' in directory 'Notes'
Adding frontmatter to 'Links' in directory 'Notes'
Adding frontmatter to 'Linux Processes' in directory 'Notes'
Adding frontmatter to 'Linære Funktioner' in directory 'Notes'
Adding frontmatter to 'Linære førsteordensdifferentialligninger' in directory 'Notes'
Adding frontmatter to 'Linært Afhængige Vektorer' in directory 'Notes'
Adding frontmatter to 'Log-likelihood Test' in directory 'Notes'
Adding frontmatter to 'Logaritmer' in directory 'Notes'
Adding frontmatter to 'Logistisk vækst' in directory 'Notes'
Adding frontmatter to 'Loops in C++' in directory 'Notes'
Adding frontmatter to 'Lysets Hastighed' in directory 'Notes'
Adding frontmatter to 'MIC Architecture' in directory 'Notes'
Adding frontmatter to 'Machine Learning' in directory 'Notes'
Adding frontmatter to 'Maps' in directory 'Notes'
Adding frontmatter to 'Marginal Distribution' in directory 'Notes'
Adding frontmatter to 'Maskemetoden' in directory 'Notes'
Adding frontmatter to 'Massemidtpunkt' in directory 'Notes'
Adding frontmatter to 'Master Theorem' in directory 'Notes'
Adding frontmatter to 'Matched z-transformation' in directory 'Notes'
Adding frontmatter to 'Matricer - Regneregler' in directory 'Notes'
Adding frontmatter to 'Matrix Image' in directory 'Notes'
Adding frontmatter to 'Matrix Kernel' in directory 'Notes'
Adding frontmatter to 'Matrix' in directory 'Notes'
Adding frontmatter to 'Max Flow' in directory 'Notes'
Adding frontmatter to 'Maximum Likelihood Estimation (MLE)' in directory 'Notes'
Adding frontmatter to 'Mean Square Error (MSE)' in directory 'Notes'
Adding frontmatter to 'Media Access Control' in directory 'Notes'
Adding frontmatter to 'Mekanisk effekt' in directory 'Notes'
Adding frontmatter to 'Mekanisk energi i centralbevægelser' in directory 'Notes'
Adding frontmatter to 'Mekanisk energi' in directory 'Notes'
Adding frontmatter to 'Memory Management in C++' in directory 'Notes'
Adding frontmatter to 'Memory Management' in directory 'Notes'
Adding frontmatter to 'Mergesort' in directory 'Notes'
Adding frontmatter to 'Microcontrolers' in directory 'Notes'
Adding frontmatter to 'Middelværdisætningen' in directory 'Notes'
Adding frontmatter to 'Mixture Models' in directory 'Notes'
Adding frontmatter to 'Modstande' in directory 'Notes'
Adding frontmatter to 'Monotoniforhold' in directory 'Notes'
Adding frontmatter to 'Morgans Law' in directory 'Notes'
Adding frontmatter to 'Multiplexer' in directory 'Notes'
Adding frontmatter to 'Multivariable Math' in directory 'Notes'
Adding frontmatter to 'Multivariate Random Variables' in directory 'Notes'
Adding frontmatter to 'NAT' in directory 'Notes'
Adding frontmatter to 'Network Layer' in directory 'Notes'
Adding frontmatter to 'Neutral Stability' in directory 'Notes'
Adding frontmatter to 'Newtons Afkølingslov' in directory 'Notes'
Adding frontmatter to 'Newtons Love' in directory 'Notes'
Adding frontmatter to 'Niveaukurver' in directory 'Notes'
Adding frontmatter to 'Normal Distribution' in directory 'Notes'
Adding frontmatter to 'Normal form of a PDE' in directory 'Notes'
Adding frontmatter to 'Normalfordelingen' in directory 'Notes'
Adding frontmatter to 'Normalkraft' in directory 'Notes'
Adding frontmatter to 'Norton Ækvivalens' in directory 'Notes'
Adding frontmatter to 'Numbering Systems' in directory 'Notes'
Adding frontmatter to 'Numerical Methods' in directory 'Notes'
Adding frontmatter to 'Nyquist Formula' in directory 'Notes'
Adding frontmatter to 'Nyquist Stability' in directory 'Notes'
Adding frontmatter to 'Nyquist-Shannon' in directory 'Notes'
Adding frontmatter to 'Observers' in directory 'Notes'
Adding frontmatter to 'Ohm's Lov' in directory 'Notes'
Adding frontmatter to 'Omdrejningslegne' in directory 'Notes'
Adding frontmatter to 'Omvendt funktion' in directory 'Notes'
Adding frontmatter to 'Operationsforstærker' in directory 'Notes'
Adding frontmatter to 'Optimal Control' in directory 'Notes'
Adding frontmatter to 'Orientation' in directory 'Notes'
Adding frontmatter to 'Orthogonal Matrix' in directory 'Notes'
Adding frontmatter to 'P-value' in directory 'Notes'
Adding frontmatter to 'PID-controller' in directory 'Notes'
Adding frontmatter to 'Parallelforbindelser' in directory 'Notes'
Adding frontmatter to 'Parity-Check Code' in directory 'Notes'
Adding frontmatter to 'Partial Differential Equations' in directory 'Notes'
Adding frontmatter to 'Partialbrøker' in directory 'Notes'
Adding frontmatter to 'Particle Filtering' in directory 'Notes'
Adding frontmatter to 'Partiel Integration' in directory 'Notes'
Adding frontmatter to 'Penduler' in directory 'Notes'
Adding frontmatter to 'Periodic Signal Analysis' in directory 'Notes'
Adding frontmatter to 'Phasor Representation' in directory 'Notes'
Adding frontmatter to 'Planck konstanten' in directory 'Notes'
Adding frontmatter to 'Plane Kredsløb' in directory 'Notes'
Adding frontmatter to 'Planer' in directory 'Notes'
Adding frontmatter to 'Plug-in Estimator' in directory 'Notes'
Adding frontmatter to 'Pointers' in directory 'Notes'
Adding frontmatter to 'Poisson Distribution' in directory 'Notes'
Adding frontmatter to 'Poisson's Equation' in directory 'Notes'
Adding frontmatter to 'Polar Coordinates' in directory 'Notes'
Adding frontmatter to 'Pooling' in directory 'Notes'
Adding frontmatter to 'Positive definite matrix' in directory 'Notes'
Adding frontmatter to 'Positive semi-definite matrix' in directory 'Notes'
Adding frontmatter to 'Potensregneregler' in directory 'Notes'
Adding frontmatter to 'Potential Energy' in directory 'Notes'
Adding frontmatter to 'Potentiel Energi' in directory 'Notes'
Adding frontmatter to 'Predict CPU Burst' in directory 'Notes'
Adding frontmatter to 'Probability vs Likelihood' in directory 'Notes'
Adding frontmatter to 'Process' in directory 'Notes'
Adding frontmatter to 'Projection' in directory 'Notes'
Adding frontmatter to 'Propability Space' in directory 'Notes'
Adding frontmatter to 'Pulse Sampling' in directory 'Notes'
Adding frontmatter to 'Python Web Scraping' in directory 'Notes'
Adding frontmatter to 'QQ-plot' in directory 'Notes'
Adding frontmatter to 'Quicksort' in directory 'Notes'
Adding frontmatter to 'RISC vs. CISC Architecture' in directory 'Notes'
Adding frontmatter to 'RMS-værdien' in directory 'Notes'
Adding frontmatter to 'Radix Sort' in directory 'Notes'
Adding frontmatter to 'Raketligningen' in directory 'Notes'
Adding frontmatter to 'Random Variables' in directory 'Notes'
Adding frontmatter to 'Rank of Matrix' in directory 'Notes'
Adding frontmatter to 'Rationelle Funktioner' in directory 'Notes'
Adding frontmatter to 'References in C++' in directory 'Notes'
Adding frontmatter to 'Registers' in directory 'Notes'
Adding frontmatter to 'Relativitetsteorien' in directory 'Notes'
Adding frontmatter to 'Riemann Sum' in directory 'Notes'
Adding frontmatter to 'Root Locus Tuning' in directory 'Notes'
Adding frontmatter to 'Rotation' in directory 'Notes'
Adding frontmatter to 'Rotational Matrices' in directory 'Notes'
Adding frontmatter to 'Row Echelon Form' in directory 'Notes'
Adding frontmatter to 'Rulning' in directory 'Notes'
Adding frontmatter to 'Række og Søjle vektorer' in directory 'Notes'
Adding frontmatter to 'Røntgenrør' in directory 'Notes'
Adding frontmatter to 'Røntgenstråling' in directory 'Notes'
Adding frontmatter to 'Safe State' in directory 'Notes'
Adding frontmatter to 'Sample Mean and Variance' in directory 'Notes'
Adding frontmatter to 'Schmitt Trigger' in directory 'Notes'
Adding frontmatter to 'Score Function' in directory 'Notes'
Adding frontmatter to 'Score Test' in directory 'Notes'
Adding frontmatter to 'Scrum' in directory 'Notes'
Adding frontmatter to 'Sekant' in directory 'Notes'
Adding frontmatter to 'Seperation of Variables' in directory 'Notes'
Adding frontmatter to 'Sequences' in directory 'Notes'
Adding frontmatter to 'Serieforbindelser' in directory 'Notes'
Adding frontmatter to 'Shannon Formula' in directory 'Notes'
Adding frontmatter to 'Signal Bandwidth' in directory 'Notes'
Adding frontmatter to 'Signal Processing' in directory 'Notes'
Adding frontmatter to 'Signal Reconstruction' in directory 'Notes'
Adding frontmatter to 'Signal element' in directory 'Notes'
Adding frontmatter to 'Signals' in directory 'Notes'
Adding frontmatter to 'Simulation of Robot Dynamics' in directory 'Notes'
Adding frontmatter to 'Singular Value Decomposition' in directory 'Notes'
Adding frontmatter to 'Skrå Kast' in directory 'Notes'
Adding frontmatter to 'Sliding Mode Control' in directory 'Notes'
Adding frontmatter to 'Smart Pointers in C++' in directory 'Notes'
Adding frontmatter to 'Små Integrationsbeviser' in directory 'Notes'
Adding frontmatter to 'Snitkurver' in directory 'Notes'
Adding frontmatter to 'Software Development' in directory 'Notes'
Adding frontmatter to 'Sorting Algorithms' in directory 'Notes'
Adding frontmatter to 'Specifik Fordampningsvarme' in directory 'Notes'
Adding frontmatter to 'Specifik Smeltevarme' in directory 'Notes'
Adding frontmatter to 'Spectral Theorem' in directory 'Notes'
Adding frontmatter to 'Spherical Coordinates' in directory 'Notes'
Adding frontmatter to 'Spoler' in directory 'Notes'
Adding frontmatter to 'Spænding' in directory 'Notes'
Adding frontmatter to 'Spændingsdeler' in directory 'Notes'
Adding frontmatter to 'Stability' in directory 'Notes'
Adding frontmatter to 'Stable Sorting' in directory 'Notes'
Adding frontmatter to 'Standard Error' in directory 'Notes'
Adding frontmatter to 'Standard IO' in directory 'Notes'
Adding frontmatter to 'Standard Teorien' in directory 'Notes'
Adding frontmatter to 'State Feedback' in directory 'Notes'
Adding frontmatter to 'State Machines' in directory 'Notes'
Adding frontmatter to 'State Space Models' in directory 'Notes'
Adding frontmatter to 'Stationære punkter' in directory 'Notes'
Adding frontmatter to 'Statistics' in directory 'Notes'
Adding frontmatter to 'Steady State Tracking' in directory 'Notes'
Adding frontmatter to 'Steady-State Value of Time Function' in directory 'Notes'
Adding frontmatter to 'Step Response' in directory 'Notes'
Adding frontmatter to 'Stokes Gnidningslov' in directory 'Notes'
Adding frontmatter to 'Strongly Connected Components' in directory 'Notes'
Adding frontmatter to 'Strøm' in directory 'Notes'
Adding frontmatter to 'Strømdeler' in directory 'Notes'
Adding frontmatter to 'Stående Cirkelbølger' in directory 'Notes'
Adding frontmatter to 'Stød' in directory 'Notes'
Adding frontmatter to 'Subtractor' in directory 'Notes'
Adding frontmatter to 'Sum of Products' in directory 'Notes'
Adding frontmatter to 'Supervised Learning' in directory 'Notes'
Adding frontmatter to 'Surface Integrals' in directory 'Notes'
Adding frontmatter to 'Symetric Matrices' in directory 'Notes'
Adding frontmatter to 'System of Linear Equations' in directory 'Notes'
Adding frontmatter to 'TCP-IP' in directory 'Notes'
Adding frontmatter to 'Tangent Plane' in directory 'Notes'
Adding frontmatter to 'Tangent' in directory 'Notes'
Adding frontmatter to 'Tangentplan' in directory 'Notes'
Adding frontmatter to 'Tarjan's Algorithm' in directory 'Notes'
Adding frontmatter to 'Taylorpolynomium' in directory 'Notes'
Adding frontmatter to 'Terminalhastighed' in directory 'Notes'
Adding frontmatter to 'The Bootstrap' in directory 'Notes'
Adding frontmatter to 'The C++ Preprocessor' in directory 'Notes'
Adding frontmatter to 'The Heat Equation' in directory 'Notes'
Adding frontmatter to 'The OSI model' in directory 'Notes'
Adding frontmatter to 'The State of a System' in directory 'Notes'
Adding frontmatter to 'The Wave Equation' in directory 'Notes'
Adding frontmatter to 'Thevenin Ækvivalens' in directory 'Notes'
Adding frontmatter to 'Thread Deadlocks' in directory 'Notes'
Adding frontmatter to 'Trace' in directory 'Notes'
Adding frontmatter to 'Transformation Matrices' in directory 'Notes'
Adding frontmatter to 'Transient Respons' in directory 'Notes'
Adding frontmatter to 'Transistorer' in directory 'Notes'
Adding frontmatter to 'Transmission' in directory 'Notes'
Adding frontmatter to 'Transport Layer' in directory 'Notes'
Adding frontmatter to 'Tretrinsraketten' in directory 'Notes'
Adding frontmatter to 'Tri-State Buffer' in directory 'Notes'
Adding frontmatter to 'Trigonometri' in directory 'Notes'
Adding frontmatter to 'Triple Integrals' in directory 'Notes'
Adding frontmatter to 'Tyngdeaccelerationen' in directory 'Notes'
Adding frontmatter to 'Tyngdekraften' in directory 'Notes'
Adding frontmatter to 'Types of Microcontrolers' in directory 'Notes'
Adding frontmatter to 'UART Protocol' in directory 'Notes'
Adding frontmatter to 'Uegenlige Integraler' in directory 'Notes'
Adding frontmatter to 'Ulige Funktioner' in directory 'Notes'
Adding frontmatter to 'Underactuated Robots' in directory 'Notes'
Adding frontmatter to 'Unified Process' in directory 'Notes'
Adding frontmatter to 'Unit Sample' in directory 'Notes'
Adding frontmatter to 'Unix Files' in directory 'Notes'
Adding frontmatter to 'Unix IO' in directory 'Notes'
Adding frontmatter to 'Variance' in directory 'Notes'
Adding frontmatter to 'Varmekapacitet' in directory 'Notes'
Adding frontmatter to 'Vector Fields' in directory 'Notes'
Adding frontmatter to 'Vectors' in directory 'Notes'
Adding frontmatter to 'Vektorfunktioner' in directory 'Notes'
Adding frontmatter to 'Velocity Curves' in directory 'Notes'
Adding frontmatter to 'Vinkelfrekvens' in directory 'Notes'
Adding frontmatter to 'Viskositet' in directory 'Notes'
Adding frontmatter to 'Viterbi Algorithm' in directory 'Notes'
Adding frontmatter to 'Vnodes and Inodes' in directory 'Notes'
Adding frontmatter to 'Wald Test' in directory 'Notes'
Adding frontmatter to 'Window Functions' in directory 'Notes'
Adding frontmatter to 'X2 Distribution' in directory 'Notes'
Adding frontmatter to 'Z-distribution' in directory 'Notes'
Adding frontmatter to 'Zeigler Nichols Tuning Method' in directory 'Notes'
Adding frontmatter to 'gravitationskraft' in directory 'Notes'
Adding frontmatter to 'impulstog' in directory 'Notes'
Adding frontmatter to 'n-Space' in directory 'Notes'
Adding frontmatter to 'z-transformation' in directory 'Notes'
Adding frontmatter to 'Ækvivalente Kredsløb' in directory 'Notes'
Adding frontmatter to 'Insert Title' in directory 'Templates'
Adding frontmatter to 'distribution' in directory 'Templates'
Adding frontmatter to 'subject' in directory 'Templates'

:b shell 64
python3 examples/7_add_frontmatter.py "test-vaults/simple_vault"
:i returncode 0
:b stdout 149
'frontmatter' already has frontmatter, skipping.
Adding frontmatter to 'sub-note' in directory 'sub'
Adding frontmatter to 'todo' in directory 'sub'

:b shell 80
python3 examples/7_add_frontmatter.py "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 0
:b stdout 6083
'Concept Board' already has frontmatter, skipping.
'Vertical Hydroponics' already has frontmatter, skipping.
'Satellite Concept Drawing' already has frontmatter, skipping.
'Dashboard' already has frontmatter, skipping.
'Element Structure and Formats' already has frontmatter, skipping.
'Inbox' already has frontmatter, skipping.
'2023-07-21' already has frontmatter, skipping.
'Journal Dashboard' already has frontmatter, skipping.
'Learning Dashboard' already has frontmatter, skipping.
'Enceladus Geysers Potential Causes' already has frontmatter, skipping.
'Enceladus Ice Thickness' already has frontmatter, skipping.
'Notes Dashboard' already has frontmatter, skipping.
'Radiation Belt Locations' already has frontmatter, skipping.
'Solar Cycle Duration' already has frontmatter, skipping.
'Personal Dashboard' already has frontmatter, skipping.
'Projects' already has frontmatter, skipping.
'Home' already has frontmatter, skipping.
'2023-10-29 - Example Meeting Note' already has frontmatter, skipping.
'All Meetings' already has frontmatter, skipping.
'All Notes' already has frontmatter, skipping.
'References' already has frontmatter, skipping.
'Tasks' already has frontmatter, skipping.
Adding frontmatter to 'README' in directory 'Vault'
'Resources Dashboard' already has frontmatter, skipping.
'Books Dashboard' already has frontmatter, skipping.
Adding frontmatter to 'Example Contact' in directory 'Contacts'
'Periapsis' already has frontmatter, skipping.
'All Formulas' already has frontmatter, skipping.
'Tsiolkovsky Rocket Equation' already has frontmatter, skipping.
Adding frontmatter to 'Navigation with Dataview and customJS' in directory 'Obsidian Development'
Adding frontmatter to 'Navigation with DataviewJS' in directory 'Obsidian Development'
'Obsidian Development Dashboard' already has frontmatter, skipping.
'Spaces Dashboard' already has frontmatter, skipping.
'Trips Dashboard' already has frontmatter, skipping.
'Sidebar Navigation' already has frontmatter, skipping.
'Tasks' already has frontmatter, skipping.
Adding frontmatter to 'Abstract callout' in directory 'callouts'
Adding frontmatter to 'Bug callout' in directory 'callouts'
Adding frontmatter to 'Caution callout' in directory 'callouts'
Adding frontmatter to 'Danger callout' in directory 'callouts'
Adding frontmatter to 'Done callout' in directory 'callouts'
Adding frontmatter to 'Error callout' in directory 'callouts'
Adding frontmatter to 'Example callout' in directory 'callouts'
Adding frontmatter to 'FAQ callout' in directory 'callouts'
Adding frontmatter to 'Failure callout' in directory 'callouts'
Adding frontmatter to 'Help callout' in directory 'callouts'
Adding frontmatter to 'Important callout' in directory 'callouts'
Adding frontmatter to 'Info callout' in directory 'callouts'
Adding frontmatter to 'Missing callout' in directory 'callouts'
Adding frontmatter to 'Note callout' in directory 'callouts'
Adding frontmatter to 'Question callout' in directory 'callouts'
Adding frontmatter to 'Quote callout' in directory 'callouts'
Adding frontmatter to 'Success callout' in directory 'callouts'
Adding frontmatter to 'Summary callout' in directory 'callouts'
Adding frontmatter to 'Tip callout' in directory 'callouts'
Adding frontmatter to 'Todo callout' in directory 'callouts'
Adding frontmatter to 'Warning callout' in directory 'callouts'
Adding frontmatter to 'Dataview flat table' in directory 'dataview'
Adding frontmatter to 'Dataview nested table' in directory 'dataview'
Adding frontmatter to 'Insert navigation bar' in directory 'dataview'
Adding frontmatter to 'List installed plugins' in directory 'dataview'
Adding frontmatter to 'Blank page' in directory 'general'
Adding frontmatter to 'Boilerplate' in directory 'general'
Adding frontmatter to 'Book' in directory 'general'
Adding frontmatter to 'Concept' in directory 'general'
Adding frontmatter to 'Contact' in directory 'general'
Adding frontmatter to 'Definition' in directory 'general'
Adding frontmatter to 'Empty page' in directory 'general'
Adding frontmatter to 'Insert code block' in directory 'general'
Adding frontmatter to 'Insert columns' in directory 'general'
Adding frontmatter to 'Insert external link' in directory 'general'
Adding frontmatter to 'Insert formula variable definition' in directory 'general'
Adding frontmatter to 'Insert header 1' in directory 'general'
Adding frontmatter to 'Insert header 2' in directory 'general'
Adding frontmatter to 'Insert header 3' in directory 'general'
Adding frontmatter to 'Insert header 4' in directory 'general'
Adding frontmatter to 'Insert header 5' in directory 'general'
Adding frontmatter to 'Insert header 6' in directory 'general'
Adding frontmatter to 'Insert table of contents' in directory 'general'
Adding frontmatter to 'Journal entry' in directory 'general'
Adding frontmatter to 'Math constant' in directory 'general'
Adding frontmatter to 'Math formula' in directory 'general'
Adding frontmatter to 'Note page' in directory 'general'
Adding frontmatter to 'Travel and Trip' in directory 'general'
Adding frontmatter to 'Course assignment' in directory 'learning'
Adding frontmatter to 'Course lecture' in directory 'learning'
Adding frontmatter to 'Course note' in directory 'learning'
Adding frontmatter to 'Course setup' in directory 'learning'
Adding frontmatter to 'Project boilerplate page' in directory 'project'
Adding frontmatter to 'Project feature' in directory 'project'
Adding frontmatter to 'Project meeting' in directory 'project'
Adding frontmatter to 'Project note' in directory 'project'
Adding frontmatter to 'Project setup meetings' in directory 'project'
Adding frontmatter to 'Project setup notes' in directory 'project'
Adding frontmatter to 'Project setup references' in directory 'project'
Adding frontmatter to 'Project setup tasks' in directory 'project'
Adding frontmatter to 'Project setup' in directory 'project'
Adding frontmatter to 'Project task' in directory 'project'
Adding frontmatter to 'Resource' in directory 'resources'
Adding frontmatter to 'Space home' in directory 'spaces'

:b shell 69
python3 examples/7_add_frontmatter.py "test-vaults/TheJoboReal_Noter"
:i returncode 1
:b stdout 7059
Adding frontmatter to '03-01-2025' in directory 'Calendar'
Adding frontmatter to '19-11-2024' in directory 'Calendar'
Adding frontmatter to '2024-19-12' in directory 'Calendar'
Adding frontmatter to '2024-20-12' in directory 'Calendar'
Adding frontmatter to '2025-06-01' in directory 'Calendar'
Adding frontmatter to '2025-12-01' in directory 'Calendar'
Adding frontmatter to '21-11-2024' in directory 'Calendar'
Adding frontmatter to '22-01-2025' in directory 'Calendar'
Adding frontmatter to '24-11-2024' in directory 'Calendar'
Adding frontmatter to '26-01-2025' in directory 'Calendar'
Adding frontmatter to '26-12-2024' in directory 'Calendar'
Adding frontmatter to '27-11-2024' in directory 'Calendar'
Adding frontmatter to '29-11-2024' in directory 'Calendar'
Adding frontmatter to '29-12-2024' in directory 'Calendar'
Adding frontmatter to '30-12-2024' in directory 'Calendar'
'Drawing 2024-01-02 20.35.25.excalidraw' already has frontmatter, skipping.
'Drawing 2024-01-03 12.17.25.excalidraw' already has frontmatter, skipping.
'Drawing 2024-06-01 11.11.40.excalidraw' already has frontmatter, skipping.
'Drawing 2024-09-08 22.21.12.excalidraw' already has frontmatter, skipping.
'Drawing 2024-09-12 14.08.07.excalidraw' already has frontmatter, skipping.
'Drawing 2024-09-16 16.37.56.excalidraw' already has frontmatter, skipping.
'Drawing 2024-09-26 09.37.59.excalidraw' already has frontmatter, skipping.
'Drawing 2024-09-26 10.01.34.excalidraw' already has frontmatter, skipping.
'Drawing 2024-10-09 11.42.52.excalidraw' already has frontmatter, skipping.
'Drawing 2024-10-21 08.30.11.excalidraw' already has frontmatter, skipping.
'Drawing 2024-10-21 08.55.36.excalidraw' already has frontmatter, skipping.
Adding frontmatter to 'Auxiliary Conditions' in directory 'Formelsamling'
Adding frontmatter to 'Classification of PDE' in directory 'Formelsamling'
Adding frontmatter to 'Differensligninger' in directory 'Formelsamling'
Adding frontmatter to 'Differential Operators' in directory 'Formelsamling'
Adding frontmatter to 'Dirac delta funktion' in directory 'Formelsamling'
Adding frontmatter to 'Direkte type 1 og 2Direkte Type 1Direkte Type 1' in directory 'Formelsamling'
Adding frontmatter to 'Direkte type 1 og 2Direkte Type 2Direkte Type 2' in directory 'Formelsamling'
Adding frontmatter to 'Diskret Fourier Transformation' in directory 'Formelsamling'
Adding frontmatter to 'Distance from point to plane' in directory 'Formelsamling'
Adding frontmatter to 'DomÃ¦ner og Ranges' in directory 'Formelsamling'
Adding frontmatter to 'Double Integration' in directory 'Formelsamling'
Adding frontmatter to 'DÃ¦mpede Svingninger' in directory 'Formelsamling'
Adding frontmatter to 'Enheds step funktion' in directory 'Formelsamling'
Adding frontmatter to 'Fast Fourier Transformation' in directory 'Formelsamling'
Adding frontmatter to 'Fourier Koefficienter' in directory 'Formelsamling'
Adding frontmatter to 'Fourier RÃ¦kker' in directory 'Formelsamling'
Adding frontmatter to 'Fourier Tabeller' in directory 'Formelsamling'
Adding frontmatter to 'Fourier Transform' in directory 'Formelsamling'
Adding frontmatter to 'Fourier function' in directory 'Formelsamling'
Adding frontmatter to 'Frekvensrespons' in directory 'Formelsamling'
Adding frontmatter to 'Greens Theorem' in directory 'Formelsamling'
Adding frontmatter to 'Heat Equation' in directory 'Formelsamling'
Adding frontmatter to 'Higher order derivatives' in directory 'Formelsamling'
Adding frontmatter to 'Impulsrespons' in directory 'Formelsamling'
Adding frontmatter to 'Invers Diskret Fourier Transformation' in directory 'Formelsamling'
Adding frontmatter to 'Invers Laplace Transformation' in directory 'Formelsamling'
Adding frontmatter to 'Koordinatsystemer' in directory 'Formelsamling'
Adding frontmatter to 'Laplace Transformation' in directory 'Formelsamling'
Adding frontmatter to 'Level Curves' in directory 'Formelsamling'
Adding frontmatter to 'Limits on Multivariable Functions' in directory 'Formelsamling'
Adding frontmatter to 'Line or Curve Integral' in directory 'Formelsamling'
Adding frontmatter to 'LineÃ¦r Algebra' in directory 'Formelsamling'
Adding frontmatter to 'LineÃ¦r approximation' in directory 'Formelsamling'
Adding frontmatter to 'Matched z-transformation' in directory 'Formelsamling'
Adding frontmatter to 'MiddelvÃ¦rdier' in directory 'Formelsamling'
Adding frontmatter to 'OverfÃ¸ringsfunktion' in directory 'Formelsamling'
Adding frontmatter to 'Rationelle funktioner' in directory 'Formelsamling'
Adding frontmatter to 'Regler' in directory 'Formelsamling'
Adding frontmatter to 'Stabilitet i et System' in directory 'Formelsamling'
Adding frontmatter to 'Superpositionsintegralet' in directory 'Formelsamling'
Adding frontmatter to 'Surface Integrals' in directory 'Formelsamling'
Adding frontmatter to 'Tangent Plane' in directory 'Formelsamling'
Adding frontmatter to 'Taylor' in directory 'Formelsamling'
Adding frontmatter to 'Triple Integration' in directory 'Formelsamling'
Adding frontmatter to 'Vector Fields' in directory 'Formelsamling'
Adding frontmatter to 'Vinduesfunktion' in directory 'Formelsamling'
Adding frontmatter to 'Wave Equation' in directory 'Formelsamling'
Adding frontmatter to 'z-transformation' in directory 'Formelsamling'
'Anden ordens differentiale ligning' already has frontmatter, skipping.
'DH.excalidraw' already has frontmatter, skipping.
'Drawing 2022-12-24 16.19.33.excalidraw' already has frontmatter, skipping.
'Drawing 2023-01-04 11.51.19.excalidraw' already has frontmatter, skipping.
'Drawing 2023-01-04 12.45.14.excalidraw' already has frontmatter, skipping.
'Drawing 2023-01-04 13.36.23.excalidraw' already has frontmatter, skipping.
'Drawing 2023-01-07 13.36.12.excalidraw' already has frontmatter, skipping.
'Drawing 2023-01-08 11.58.53.excalidraw' already has frontmatter, skipping.
'Drawing 2023-01-17 16.10.09.excalidraw' already has frontmatter, skipping.
'Drawing 2023-02-08 15.30.46.excalidraw' already has frontmatter, skipping.
'Drawing 2023-03-21 11.32.24.excalidraw' already has frontmatter, skipping.
'Drawing 2023-04-12 16.12.54.excalidraw' already has frontmatter, skipping.
'Drawing 2023-04-24 12.22.17.excalidraw' already has frontmatter, skipping.
'Drawing 2023-04-24 12.37.17.excalidraw' already has frontmatter, skipping.
'Fysisk Pendul' already has frontmatter, skipping.
'Inertimoment pÃ¥ pendul' already has frontmatter, skipping.
'Karnaugh  maps.excalidraw' already has frontmatter, skipping.
'Matematisk pendul.excalidraw' already has frontmatter, skipping.
'PartialbrÃ¸ker' already has frontmatter, skipping.
'Partielle BrÃ¸ker.excalidraw' already has frontmatter, skipping.
'Rotations matrix om x-akse.excalidraw' already has frontmatter, skipping.
Adding frontmatter to 'Set Dimensions' in directory 'Downloaded'
'Four Value Functions 2024-10-31 12.30.10.excalidraw' already has frontmatter, skipping.
Adding frontmatter to 'Airmon wifi bruteforce' in directory 'Projects'
Adding frontmatter to 'Eink Calendar' in directory 'Projects'

:b shell 70
python3 examples/8_formatter.py test-vaults/simple_vault/first_note.md
:i returncode 0
:b stdout 56
Formatting note: test-vaults/simple_vault/first_note.md

:b shell 70
python3 examples/8_formatter.py --vault "test-vaults/Obsidian Sandbox"
:i returncode 0
:b stdout 2242
Formatting note: test-vaults/Obsidian Sandbox/Adventurer/From plain-text note-taking.md
Formatting note: test-vaults/Obsidian Sandbox/Adventurer/From standard note-taking.md
Formatting note: test-vaults/Obsidian Sandbox/Adventurer/No prior experience.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Blockquote.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Callout.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Code block.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Comment.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Diagram.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Embeds.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Emphasis.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Footnote.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Format your notes.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Heading.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Highlighting.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Horizontal divider.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Images.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Inline code.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Internal link.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Links.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Lists.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Math.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Strikethrough.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Table.md
Formatting note: test-vaults/Obsidian Sandbox/Formatting/Task.md
Formatting note: test-vaults/Obsidian Sandbox/Guides/Create a vault.md
Formatting note: test-vaults/Obsidian Sandbox/Guides/Create your first note.md
Formatting note: test-vaults/Obsidian Sandbox/Guides/Get started with Obsidian.md
Formatting note: test-vaults/Obsidian Sandbox/Guides/Link notes.md
Formatting note: test-vaults/Obsidian Sandbox/Plugins make Obsidian special for you.md
Formatting note: test-vaults/Obsidian Sandbox/Start Here.md
Formatting note: test-vaults/Obsidian Sandbox/Vault is just a local folder.md

:b shell 75
python3 examples/8_formatter.py --vault "test-vaults/BalderHolst_uni-notes"
:i returncode 0
:b stdout 39582
Formatting note: test-vaults/BalderHolst_uni-notes/Excalidraw/Drawing 2022-11-17 12.34.37.excalidraw.md
Formatting note: test-vaults/BalderHolst_uni-notes/Excalidraw/Truth-table to MUX.md
Formatting note: test-vaults/BalderHolst_uni-notes/Excalidraw/fysik PA.md
Formatting note: test-vaults/BalderHolst_uni-notes/HOME.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/AC.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/ADC.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/ALU.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/ARM.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/ARP Packet.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/AVR Ports.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Abstract Classes in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Acceleration af partikler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Algorithms and Data Structures.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Amdahl's Law.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Andengradspolynomier.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Andenordens inhomogene differentialligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Andenordensdifferentialligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Angle-Set Conventions.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Anti Aliasering Filter.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Anti-Windup.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Antisymetrisk.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Approximation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Arbejde.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Arc Length.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Arrays in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Artificial Intelligence.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Assembly.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Assumptions of Kinematics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Asymptotic Relative Efficiency (ARE).md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/At Gøre Prøve.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Axis Angle.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bandwidth.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Basis.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bayesian Learning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bayesian Networks.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bellman-Ford* Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bessel.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bevis for 2. Løsningsformel.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bevis for Parameterfremstilling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bevis for den Gennerelle Løsningsformel til Linære Førsteordensdifferentialligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Beviser.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bevægelse på Skråplan.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bevægelsesmængde (Impuls).md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bevægelsesmængdemoment.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bias.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Big-O Notation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bilineær z-transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Binomial Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bivariate Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bode Plot.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bolzmanns Konstant.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Boolean Algebra.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Breadth-first Search.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Butterworth Filter.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Bølgeformlen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/C Libraries.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/C++ Streams.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Cascade Control.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Central Limit Theorem.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Centripetalacceleration.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Centripetalkraft.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Change of Variables.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Chebyshev Filter.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Cholesky Decomposition.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Circles.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Cirklens Ligning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Classes in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Classification of Second order PDEs.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Common Mode Rejection Ratio.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Confidence Interval.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Control System Performance.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Control Systems.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Controllability.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Controllable Canonical Form.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Convergence of Random Variables.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Coulumbs Lov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Coulumbs konstant.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Covariance and Correlation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Covariance.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Craig's Notation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Critical Value.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Curl.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Cylindrical Coordinates.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/D Latch.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/DC Amplification.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/DC.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/DH-Parameters.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/DHCP.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Data Communication.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Data Link Layer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/De kinematiske ligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Decibel.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Deep Learning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Degrees of Freedom.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Delay through filter (gruppeløstid).md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Delta Method.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Den retningsafledte.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Densitet.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Depth-first Search.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Det Komplekse Plan.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Determinanen for Matricer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Diagonalization.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Diagonalmatrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differensligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differential Equations.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differentialregning - Basis.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differentialregning Regneregler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differentialregning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differentiation af funktioner med to variable.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Differentiator.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Digital Realisation Structures.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Digitization.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dijkstra’s Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dioder.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dirac Delta Function.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Direct Samling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Directories in C.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Diskret Fourier Transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Distributions.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Disturbance Rejection.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Divergence.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dynamic Bayesian Networks.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dynamic Compensation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dynamic Inference.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dynamic Memory Allocation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dæmpede Svingninger - Differentialligning 1.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Dæmpede Svingninger - Differentialligning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Edmonds Karp Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Effekt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Eigen values and vectors.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Eigendecomposition.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Einsteins Fotoelektriske Lov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Eksponentielle Funktioner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Elektrisk Resonans.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Elektroner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Elementarladningen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Elementarpartiklers Bølgeegenskaber.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Embedded.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Emperical CDF.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/En-en-tydig Funktion.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Energi.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Error Analysis.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ethernet.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Euler-Lagrange Modelling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Eulers Formel.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Expectation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Exponential Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/FAN-OUT.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/FIR Filtre.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fast Fourier transformation (FFT).md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Feed Forward.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Feedback Control.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fejlberegning på Operationsforstærker.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/File Metadata.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Files.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Filter Transformations.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Filters.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/First-Order Logic.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fisher Information.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fjederkraft.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Flytningsformlen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Foldningssum.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ford Fulkerson Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fordampningsenergi.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fordoblings- og halveringkonstant.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Forward Kinematics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Forwarding Table.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fotoelektrisk Effekt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fotoner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fourier-transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fourieseries.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Frames.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Frekvens.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Frequency Response.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Friktion.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Fuldstændig og partikulær løsning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Full Adder.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Funktioner af flere Variable.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Førsteordensdifferentialligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gain Margins.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gates.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gauss's Divergence Theorem.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gaussian Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Generalized Coordinates.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gimbal Lock.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gnidning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gnidningsmordstand gennem Luft.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gradient.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gravitation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Gray Codes.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Green's Theorem.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Grænser.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Halveringtid.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hamming Distance.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Harmoniske svingninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hastighed og Fart.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hello World in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hidden Markov Models.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Homogeneous Functions.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hvordan skriver man en videnskabelig artikel.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hypothesis Testing.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Hældningsfelt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/IID.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/IIR Filters.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/IPv4.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/IPv6.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Identity Matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Impedans.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Impule Inveriant z-transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Impulse Response.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Impulse Sampling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Impulsmoment.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Indre og Ydre Produkt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Inertimoment.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Insertion Sort.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integral Control.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integral Table.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integraler Regneregler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integraler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integralregning - Basis.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integration med Substidution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Integrator.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Intel x86 Architecture.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Intelligent Systems.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Interfaces in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Interupts.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Inverse Kinematics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Inverse Matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Jacobian Matrix for Robotics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Jacobian Matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Jævn Cirkelbevægelse.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/KCL.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/KVL.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kalman Filter.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Karatsuba Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Karnaugh Map.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Keplers Lov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kinematrics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kinetic Energy.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kinetisk Energi.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Knudepunktsmetoden.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Koblede Førsteordensdifferentialligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Komparator.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Komplekse Tal.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kondensator.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Konduktans.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Konservative og ikke-konservative kræfter.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Koordinatsystem og Flader.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kosaraju’s Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kraftmoment.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kredsløb.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Kvadratkomplettering.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/LU Decomposition.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ladning i en Kugle.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ladningers bevægelse i et kuglesymmetrisk felt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Laplace Transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Laplace's Equation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Laplaces lov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Laplacian Operator.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Latch.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Law of Cosines.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Law of Large Number.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Least Squared Problem.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ledere og Isolatorer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Libraries in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Library Interpositioning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ligninssystemer Uden Løsninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linarisering.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Line Coding.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Line Integrals.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linear Algebra.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linear Classification.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linear Systems.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Lineært Tidsinvariant System.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Links.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linux Processes.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linære Funktioner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linære førsteordensdifferentialligninger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Linært Afhængige Vektorer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Log-likelihood Test.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Logaritmer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Logistisk vækst.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Loops in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Lysets Hastighed.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/MIC Architecture.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Machine Learning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Maps.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Marginal Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Maskemetoden.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Massemidtpunkt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Master Theorem.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Matched z-transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Matricer - Regneregler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Matrix Image.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Matrix Kernel.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Max Flow.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Maximum Likelihood Estimation (MLE).md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Mean Square Error (MSE).md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Media Access Control.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Mekanisk effekt.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Mekanisk energi i centralbevægelser.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Mekanisk energi.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Memory Management in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Memory Management.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Mergesort.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Microcontrolers.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Middelværdisætningen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Mixture Models.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Modstande.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Monotoniforhold.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Morgans Law.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Multiplexer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Multivariable Math.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Multivariate Random Variables.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/NAT.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Network Layer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Neutral Stability.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Newtons Afkølingslov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Newtons Love.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Niveaukurver.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Normal Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Normal form of a PDE.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Normalfordelingen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Normalkraft.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Norton Ækvivalens.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Numbering Systems.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Numerical Methods.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Nyquist Formula.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Nyquist Stability.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Nyquist-Shannon.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Observers.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ohm's Lov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Omdrejningslegne.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Omvendt funktion.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Operationsforstærker.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Optimal Control.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Orientation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Orthogonal Matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/P-value.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/PID-controller.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Parallelforbindelser.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Parity-Check Code.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Partial Differential Equations.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Partialbrøker.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Particle Filtering.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Partiel Integration.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Penduler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Periodic Signal Analysis.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Phasor Representation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Planck konstanten.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Plane Kredsløb.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Planer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Plug-in Estimator.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Pointers.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Poisson Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Poisson's Equation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Polar Coordinates.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Pooling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Positive definite matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Positive semi-definite matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Potensregneregler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Potential Energy.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Potentiel Energi.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Predict CPU Burst.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Probability vs Likelihood.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Process.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Projection.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Propability Space.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Pulse Sampling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Python Web Scraping.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/QQ-plot.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Quicksort.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/RISC vs. CISC Architecture.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/RMS-værdien.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Radix Sort.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Raketligningen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Random Variables.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Rank of Matrix.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Rationelle Funktioner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/References in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Registers.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Relativitetsteorien.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Riemann Sum.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Root Locus Tuning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Rotation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Rotational Matrices.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Row Echelon Form.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Rulning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Række og Søjle vektorer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Røntgenrør.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Røntgenstråling.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Safe State.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Sample Mean and Variance.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Schmitt Trigger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Score Function.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Score Test.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Scrum.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Sekant.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Seperation of Variables.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Sequences.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Serieforbindelser.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Shannon Formula.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Signal Bandwidth.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Signal Processing.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Signal Reconstruction.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Signal element.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Signals.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Simulation of Robot Dynamics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Singular Value Decomposition.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Skrå Kast.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Sliding Mode Control.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Smart Pointers in C++.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Små Integrationsbeviser.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Snitkurver.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Software Development.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Sorting Algorithms.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Specifik Fordampningsvarme.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Specifik Smeltevarme.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Spectral Theorem.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Spherical Coordinates.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Spoler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Spænding.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Spændingsdeler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Stability.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Stable Sorting.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Standard Error.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Standard IO.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Standard Teorien.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/State Feedback.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/State Machines.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/State Space Models.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Stationære punkter.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Statistics.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Steady State Tracking.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Steady-State Value of Time Function.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Step Response.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Stokes Gnidningslov.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Strongly Connected Components.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Strøm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Strømdeler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Stående Cirkelbølger.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Stød.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Subtractor.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Sum of Products.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Supervised Learning.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Surface Integrals.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Symetric Matrices.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/System of Linear Equations.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/TCP-IP.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tangent Plane.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tangent.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tangentplan.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tarjan's Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Taylorpolynomium.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Terminalhastighed.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/The Bootstrap.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/The C++ Preprocessor.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/The Heat Equation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/The OSI model.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/The State of a System.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/The Wave Equation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Thevenin Ækvivalens.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Thread Deadlocks.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Trace.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Transformation Matrices.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Transient Respons.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Transistorer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Transmission.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Transport Layer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tretrinsraketten.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tri-State Buffer.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Trigonometri.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Triple Integrals.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tyngdeaccelerationen.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Tyngdekraften.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Types of Microcontrolers.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/UART Protocol.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Uegenlige Integraler.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ulige Funktioner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Underactuated Robots.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Unified Process.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Unit Sample.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Unix Files.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Unix IO.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Variance.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Varmekapacitet.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Vector Fields.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Vectors.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Vektorfunktioner.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Velocity Curves.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Vinkelfrekvens.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Viskositet.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Viterbi Algorithm.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Vnodes and Inodes.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Wald Test.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Window Functions.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/X2 Distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Z-distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Zeigler Nichols Tuning Method.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/gravitationskraft.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/impulstog.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/n-Space.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/z-transformation.md
Formatting note: test-vaults/BalderHolst_uni-notes/Notes/Ækvivalente Kredsløb.md
Formatting note: test-vaults/BalderHolst_uni-notes/README.md
Formatting note: test-vaults/BalderHolst_uni-notes/Templates/Insert Title.md
Formatting note: test-vaults/BalderHolst_uni-notes/Templates/distribution.md
Formatting note: test-vaults/BalderHolst_uni-notes/Templates/subject.md

:b shell 66
python3 examples/8_formatter.py --vault "test-vaults/simple_vault"
:i returncode 0
:b stdout 590
Formatting note: test-vaults/simple_vault/callout.md
Formatting note: test-vaults/simple_vault/code.md
Formatting note: test-vaults/simple_vault/first_note.md
Formatting note: test-vaults/simple_vault/frontmatter.md
Formatting note: test-vaults/simple_vault/list.md
Formatting note: test-vaults/simple_vault/quote.md
Formatting note: test-vaults/simple_vault/second_note.md
Formatting note: test-vaults/simple_vault/sub/sub-note.md
Formatting note: test-vaults/simple_vault/sub/todo.md
Formatting note: test-vaults/simple_vault/todo.md
Formatting note: test-vaults/simple_vault/websites.md

:b shell 82
python3 examples/8_formatter.py --vault "test-vaults/SoRobby_ObsidianStarterVault"
:i returncode 0
:b stdout 10607
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/README.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Concept Board/Concept Board.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Concept Board/Concepts/Vertical Hydroponics.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Concept Board/Drawings/Satellite Concept Drawing.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Element Structure and Formats.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Inbox/Inbox.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Journal/Entries/2023-07-21.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Journal/Journal Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Learning/Learning Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Notes/Enceladus Geysers Potential Causes.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Notes/Enceladus Ice Thickness.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Notes/Notes Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Notes/Radiation Belt Locations.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Notes/Solar Cycle Duration.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Personal/Personal Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Projects.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Top Secret Project/Home.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Top Secret Project/Meetings/2023-10-29 - Example Meeting Note.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Top Secret Project/Meetings/All Meetings.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Top Secret Project/Notes/All Notes.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Top Secret Project/References.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Projects/Top Secret Project/Tasks.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/README.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Resources/Resources Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Books/Books Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Contacts/Example Contact.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Definitions/Periapsis.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Formulas/All Formulas.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Formulas/Tsiolkovsky Rocket Equation.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Obsidian Development/Navigation with Dataview and customJS.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Obsidian Development/Navigation with DataviewJS.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Obsidian Development/Obsidian Development Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Spaces Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/Spaces/Trips/Trips Dashboard.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/pinned/Sidebar Navigation.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/pinned/Tasks.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Abstract callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Bug callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Caution callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Danger callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Done callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Error callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Example callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/FAQ callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Failure callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Help callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Important callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Info callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Missing callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Note callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Question callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Quote callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Success callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Summary callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Tip callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Todo callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/callouts/Warning callout.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/dataview/Dataview flat table.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/dataview/Dataview nested table.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/dataview/Insert navigation bar.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/dataview/List installed plugins.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Blank page.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Boilerplate.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Book.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Concept.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Contact.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Definition.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Empty page.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert code block.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert columns.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert external link.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert formula variable definition.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert header 1.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert header 2.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert header 3.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert header 4.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert header 5.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert header 6.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Insert table of contents.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Journal entry.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Math constant.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Math formula.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Note page.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/general/Travel and Trip.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/learning/Course assignment.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/learning/Course lecture.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/learning/Course note.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/learning/Course setup.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project boilerplate page.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project feature.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project meeting.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project note.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project setup meetings.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project setup notes.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project setup references.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project setup tasks.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project setup.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/project/Project task.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/resources/Resource.md
Formatting note: test-vaults/SoRobby_ObsidianStarterVault/Vault/_data_/templates/spaces/Space home.md

:b shell 71
python3 examples/8_formatter.py --vault "test-vaults/TheJoboReal_Noter"
:i returncode 0
:b stdout 103077
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/03-01-2025.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/19-11-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/2024-19-12.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/2024-20-12.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/2025-06-01.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/2025-12-01.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/21-11-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/22-01-2025.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/24-11-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/26-01-2025.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/26-12-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/27-11-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/29-11-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/29-12-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Calendar/30-12-2024.md
Formatting note: test-vaults/TheJoboReal_Noter/Dashboard.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-01-02 20.35.25.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-01-03 12.17.25.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-06-01 11.11.40.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-09-08 22.21.12.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-09-12 14.08.07.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-09-16 16.37.56.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-09-26 09.37.59.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-09-26 10.01.34.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-10-09 11.42.52.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-10-21 08.30.11.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Excalidraw/Drawing 2024-10-21 08.55.36.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Auxiliary Conditions.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Classification of PDE.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Differensligninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Differential Operators.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Dirac delta funktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Direkte type 1 og 2Direkte Type 1Direkte Type 1.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Direkte type 1 og 2Direkte Type 2Direkte Type 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Diskret Fourier Transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Distance from point to plane.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/DomÃ¦ner og Ranges.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Double Integration.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/DÃ¦mpede Svingninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Enheds step funktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Fast Fourier Transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Fourier Koefficienter.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Fourier RÃ¦kker.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Fourier Tabeller.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Fourier Transform.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Fourier function.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Frekvensrespons.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Greens Theorem.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Heat Equation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Higher order derivatives.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Impulsrespons.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Invers Diskret Fourier Transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Invers Laplace Transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Koordinatsystemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Laplace Transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Level Curves.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Limits on Multivariable Functions.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Line or Curve Integral.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/LineÃ¦r Algebra.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/LineÃ¦r approximation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Matched z-transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/MiddelvÃ¦rdier.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/OverfÃ¸ringsfunktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Rationelle funktioner.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Regler.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Stabilitet i et System.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Superpositionsintegralet.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Surface Integrals.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Tangent Plane.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Taylor.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Triple Integration.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Vector Fields.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Vinduesfunktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/Wave Equation.md
Formatting note: test-vaults/TheJoboReal_Noter/Formelsamling/z-transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Anden ordens differentiale ligning.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/DH.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2022-12-24 16.19.33.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-01-04 11.51.19.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-01-04 12.45.14.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-01-04 13.36.23.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-01-07 13.36.12.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-01-08 11.58.53.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-01-17 16.10.09.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-02-08 15.30.46.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-03-21 11.32.24.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-04-12 16.12.54.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-04-24 12.22.17.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Drawing 2023-04-24 12.37.17.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Fysisk Pendul.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Inertimoment pÃ¥ pendul.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Karnaugh  maps.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Matematisk pendul.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/PartialbrÃ¸ker.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Partielle BrÃ¸ker.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Rotations matrix om x-akse.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Excalidraw/Scripts/Downloaded/Set Dimensions.md
Formatting note: test-vaults/TheJoboReal_Noter/Misc/Four Value Functions 2024-10-31 12.30.10.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Projects/Airmon wifi bruteforce.md
Formatting note: test-vaults/TheJoboReal_Noter/Projects/Eink Calendar.md
Formatting note: test-vaults/TheJoboReal_Noter/README.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/AssignmentTemp.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/CourseTemp.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/ExerciseTemp.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/LectureSlideTemp.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/NoteTemp.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/SemesterTemp.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/Todo.md
Formatting note: test-vaults/TheJoboReal_Noter/Templates/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/Todo/TODO.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Assignment 5 Num.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Num Exercise 4.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Numerical Assignment 1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Numerisk assignment 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Port3 Numerisk.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Portfolio 1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Assignments/Portfolio 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Algoritmer og  Datastruktur.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Bachelor.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/C++.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Calculus.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Computer Arkitektur.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Computer Vision.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Control of Autonomous Systems.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Data Kommunikation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Datateknik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Digital Programmerbar elektronik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Droner.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Elektro fysik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Embedded Systems.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Forstaerkningsteknik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/FreeRTOS.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Individuel Studieaktivitet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Indlejret Programmering.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Introduction to Embodied Artificial Intelligence.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Kinematik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Kunstig Inteligens.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Linux Querks.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Matlab & Mathematica.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Multivariable Calculus.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Multivariat Statistik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Numeriske Metoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Reguleringsteknik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Robotics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Robotters Fysik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Scientific Method.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Signalbehandling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Softwareudvikling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Statistik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Courses/Videnskabsteori.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Cholesky & LU exercise.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Exercise 7 Newton.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/LU Decomposition og Gaussian.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Lecture 4 error estimate.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Lecture 8 Numerical integration.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Lecture1_Task.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Richardson Extrapolation exercise.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/Root Finding Exercise.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/SVD Exercise.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Exercises/add C and e.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/C++ cheatsheet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/Elektro Formelsamling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/Formelsamling Calculus.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/Formelsamling Fysik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/Formelsamling Kinematik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/Matlab addons.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/1 Formelsamlinger/SQL Cheatsheet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Assignments/Stack Queue and balPar.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Eksamen.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Gammel eksamen/eksamen 1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Gammel eksamen/eksamen 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Big O notation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Binary Tree.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Binary Trees Traversal.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Dijkstra Method.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Graphs.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Hashing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Induktionsbeviser.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Linked Lists.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Priorityqueing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Sorting.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Algoritmer og Datastruktur/Lecture Notes/Spanning Tree.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Bachelor/CBBA consensus-based bundle algorithm.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Bachelor/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Arithmetic operations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Arrays.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/BIT-wise logical operations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Data types(Variables).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/AVR interrupt.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/External interrupt register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/Global interrupt enable.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/Interrupt addresses.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/Interrupt example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/TIMER0 interrupt.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Interrupt/TIMER0.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Pin reader.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/Structure and Compilation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C/TCCR0 timer counter control register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Abstract Classes/Abstract Classes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Arrays.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Boolean Operators.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Casting.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Classes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Const.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Header guard.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Hello World.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/If, while, for loops.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Memory(Heap and Stacks).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Namespace.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Pointers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Reference operator.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/References.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Smart Pointers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Streams.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Strings.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/Struct.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Functions and stuff/enum and enum class.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Inheritance/Derived constructers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Inheritance/Inheritance.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Inheritance/Virtual.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Libraries/Compile.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Modbus/Intro.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/OpenCV/Intro.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Read & Write to file/Read and Write class to file example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/C++/Read & Write to file/Read and write string to file example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Eksamens opgaver/Februar 2021 opg 4.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Eksamens opgaver/Maj 2021.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/De Moivre w4 -81.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/De Moivre.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/Drawing 2022-12-02 12.37.17.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/Drawing 2022-12-20 13.05.59.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/Drawing 2022-12-20 23.04.31.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/Eksamensopgaver.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Exercises/plottes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/1. ordens differentialeligninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Calculus noter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Differensligninger og Dæmpede svingninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Gauss Elimination.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Generelle formler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Koblede diff ligninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Kordinatsystemer/Cylendrical Cordinates.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Kordinatsystemer/Polar cordinates.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Kordinatsystemer/Spherical Cordinates.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Ligningssystemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Linear algebra og matrice opgaver.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Matricer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/MiddelvÃ¦rdier.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Partial Differential equations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Specielle Matricer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Calculus/Lecture Notes/Ulige funktioner.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Bankers Algorithm.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Deadlock Detection.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Deadlock Prevention.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Deadlock Recovery.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Deadlock Situations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Managing Deadlocks.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Resource Allocation Algorithm.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Resource allocation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Deadlocks/Safe State.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/IJVM/IJVM Implementation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/IJVM/IJVM implementation in Mic-1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/IJVM/IJVM instruction set.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/MAL (Micro Assembly Language)/MAL (Micro Assembly Language).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/MAL (Micro Assembly Language)/Modification of the Data Path.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/MAL (Micro Assembly Language)/Optimization of the microcode.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Address Binding.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Basic Hardware.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Logical and Physical address space.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/AMD processor 16-bit (AM186EM).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/ATmega128L - external memory.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/Address demultiplexer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/Memory Interface 16-bit.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/Memory Interface 8-bit.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/Memory Interface Wait State.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Interface/Memory Interface.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Memory Management optimization.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Non-Uniform Memory Access (NUMA).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Paging.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Protection.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Round-Robin.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Memory/Segmentation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/Cache.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/Data Path Timing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/IFU (Instruction Fetch Unit).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/IJVM instruction set.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/MIC-1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/MIC-2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/MIC-3.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/MIR (Micro Instructions Register).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/Memory Access Timing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/Memory Operation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Micro-architecture level/Micro Architecture Level.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Allocation of frames.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Copy on Write.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Demand Paging.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Loaclity.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Page Buffering Algorithm.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Page Fault Frequency.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Page Replacing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Paging/Thrashing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Atomic Acces.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Bounded Buffer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Condition Variable.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Consumer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Deadlock.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Dining-Philosophers Problem.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Monitors.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Process Synchronization.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Producer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Race Condition.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Readers-Writers Problem.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Process Synchronization/Semaphore.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/SPI/SPI Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/SPI/SPI Registers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/SPI/SPI Setup.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/CISC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/Designs of instruction - LOAD.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/Instruction on set design.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/Program execution of the LOAD instruction.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/Simple Computer Model Instructions.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/Simple Computer Model.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/Simple computer model (a program example).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Simple Computer Model/The Control Unit.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Virtual Memory/Virtual Memory Basics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Virtual Memory/Virtual Space Address.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Von Neumann architecture/Pentium II Motherboard.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Arkitektur/Noter/Von Neumann architecture/Von Neumann Architecture.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Vision/Book.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Computer Vision/Ground sample distance (GSD).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Controlled Access/Channelization.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Controlled Access/Polling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Controlled Access/Reservation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Controlled Access/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Media Access Control/ALOHA.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Media Access Control/CSMA or CD.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Media Access Control/CSMA.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Media Access Control/Media Access Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Access/Media Access Control/Random Access.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/CAN networks/CAN Frames.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/CAN networks/CAN physical and Data link Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/CAN networks/CAN â Controller Area Network.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/CAN networks/Error Detection Mechanisms.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/ARP Address Resolution Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/ARP Request Reply example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/ARP-Package format.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Bit Error detection.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Block Coding.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Burst error.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Communication example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Cyclic Codes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Control DLC/Bit-oriented framing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Control DLC/Character-oriented framing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Control DLC/Data Link Control DLC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Control DLC/Finite State Machine (FSM).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Control DLC/Flow and error control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Control DLC/Framing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Link Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Data Polynomial.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/Asynchronous Balanced Mode (ABM).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/Example P F bit.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Fields/Address Field.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Fields/Control Field.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Fields/FCS field.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Fields/Flag Fields.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Fields/HDLC Connect and Disconnect.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Fields/Information field.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/HDLC Frames â three types.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/High-Level Data Link Control (HDLC).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/High Level Data Link Control/Normal Response Mode (NRM).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Link-Layer Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/Link Control Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/Multiplexing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/PPP Data from the Network Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/PPP Example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/PPP Frame Format.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/PPP Multilink.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/PPP Network Control Protocols.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/PPP Transition phases.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Point-To-Point Protocol (PPP)/Point-ToPoint-Protocol-(PPP).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Protocols/Piggybacking.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Protocols/Simple protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Protocols/Stop-and-wait.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Services.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Single-Bit error.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Three types of addresses.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Data Links Layers/Two Categories of Links.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Brigdet Ethernet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Encoding.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Fast Ethernet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Full-Duplex Switched Ethernet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Gigabit Ethernet Encoding.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Gigabit Ethernet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Gigabit Physical Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/IEEE Standard Ethernet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/MAC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Physical Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Switched Ethernet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Ethernet/Unicast, Multicast and Broadcast addresses.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Bipolar AMI & Pseudoternary.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Line Coding Schemes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Line Coding.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Multilevel/4D-PAM5.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Multilevel/8B6T.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Multilevel/Definittion 2B1Q.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Multilevel/Multitransition MLT-3.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Polar Manchester and differentiel Manchester.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Polar NRZ.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Polar RZ.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Line coding/Unipolar NRZ.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Address aggregation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Connectionless Service.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/DHCP Dynamic Host Configuration Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Debuggin tools.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Forwarding of IP packets.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Fragmentation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Geographical Routing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/HOP and TTL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Hierarchical Routing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/ICMPv4 Query messages.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/ICMPv4.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV4/IPV4 Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV4/IPV4 Cecksum.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV4/IPV4 Datagrams.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV4/IPV4 Network Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV4/IPV4.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/ICMPV6 Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV4 to IPV6.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Address Mapping.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Autoconfiguration.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Blocks.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Extension Headers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Flow Label.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6 Special Addresses.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/IPV6/IPV6.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Logical Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Multi-Protocol Label Switching (MPLS).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Address Translation NAT.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Congestion control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Connection-oriented service.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Error Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Flow Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Forwarding mechanism.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Perfomance.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Quality of Service (QoS).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Network Security.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/Routing and forwarding.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/TCP (Transmission Control Protocol).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Network Layer/UDP (User Datagram Protocol).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Noise/Noiseless channel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Noise/Noisy channel Shannon Capacity.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Noise/SNR signal to noice ratio.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Noise/Signal rate.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Noise/Transmission Distrortion.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/OSI model.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Protocols.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transmission Impairment/Attenuation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Bidirectional protocols.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Connectionless and Connectionâoriented service.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Go-Back-N Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Protocols.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/SCTP (Stream Control Transmission Protocol).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/SNMP (Simple Network Management Protocol).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Selective-Repeat Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Simple Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Stop and Wait Protocol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Addressing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Congestion Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Encapsulation and decapsulation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Error Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Flow Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer ICANN range.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Multiplexing and demultiplexing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Service.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer Socket Address.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Noter/Transport Layer/Transport Layer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Data Kommunikation/Opgaver/Lektion 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/ADD or Multiply function.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/CTC example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/Display schematic.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/IO ports.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/Inside of AVR port.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/Schematic.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/ATmega32/Timers in ATMEGA32.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/ADC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/ADCH or ADCL Result register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/ADCSRA Register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/ADMUX.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/Example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/How to use ADC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/PWM signal.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Analog to Digital/UCSRA Control and register Status.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Directives/DEF.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Directives/Directives.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Directives/EQU.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Directives/INCLUDE.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Directives/ORG.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Directives/SET.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/ADC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/ADD.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Bit manipulation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/COM.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Conditional Jump (CP & CPI).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/DEC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Division.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/IN & OUT.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/IN (from IO).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/INC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Instructions.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/LDS and LDI.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Logical Shift.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Loops.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/MOV.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Multiplication.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/No operation(NOP).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/OUT (from IO).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/SBC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/STS.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/SUBI.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Setup PORT as Input or Output.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Instructions/Sub(Subtract).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Stacks/PUSH, POP.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Stacks/Stack Pointer set.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Stacks/Stacks.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Subroutine/CALL, RCALL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Subroutine/RET.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Assembly/Subroutine/Subroutines.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Boolean algebra.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Counters.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/ADD or Multiply function.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/CTC example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/Display schematic.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/IO ports.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/Inside of AVR port.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/PWM example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/Schematic.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/ATmega32/Timers in ATMEGA32.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/ADC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/ADCH or ADCL Result register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/ADCSRA Register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/ADMUX.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/Example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/How to use ADC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Analog to Digital/UCSRA Control and register Status.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Directives/DEF.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Directives/Directives.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Directives/EQU.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Directives/INCLUDE.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Directives/ORG.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Directives/SET.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/ADC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/ADD.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Bit manipulation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/COM.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Conditional Jump (CP & CPI).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/DEC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Division.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/IN & OUT.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/IN (from IO).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/INC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Instructions.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/LDS and LDI.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Logical Shift.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Loops.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/MOV.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Multiplication.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/No operation(NOP).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/OUT (from IO).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/SBC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/STS.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/SUBI.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Setup PORT as Input or Output.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Instructions/Sub(Subtract).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Stacks/PUSH, POP.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Stacks/Stack Pointer set.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Stacks/Stacks.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Subroutine/CALL, RCALL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Subroutine/RET.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Assembly/Subroutine/Subroutines.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Boolean algebra/Boolean algebra.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Boolean algebra/Counters.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Boolean algebra/Nummereringssystemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Boolean algebra/Python Converter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Arithmetic operations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Arrays.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/BIT-wise logical operations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Data types(Variables).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/AVR interrupt.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/External interrupt register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/Global interrupt enable.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/Interrupt addresses.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/Interrupt example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/TIMER0 interrupt.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Interrupt/TIMER0.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Pin reader.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/Structure and Compilation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/C/TCCR0 timer counter control register.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/ALU (Arithmetic Logic Unit).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/AVR Microcontroller.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Architecture.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/CLOCK.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/CPU.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Decoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Full Adder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Gates.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Karnaugh maps (K-maps).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Memory.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Multiplexer (MUX), or Selector.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/R-S (Reset-Set) Latch.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Registers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Microcontrollers/Microcontrollers/Tri-state Buffer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Nummereringssystemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/PWM (pulse width modulation).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Datateknik/Python Converter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Assignment 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Digital Assignment.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Adders.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Comparators.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Complex Comaparator.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Counter VHDL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/D-Type Flip-Flop.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/D-type latch.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Decoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Divider.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Encoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Keypad Encoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/LCD Driver FPGA.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Multiplication.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Priority Encoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Register VHDL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/SPI(Serial Peripheral Interface-bus).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Shift Registers VHDL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Signals and Variables.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Digital Programmerbar elektronik/Noter/Subtractors.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Droner/Before Flight Checklist.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Droner/Group 7 Team Contract.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/AC-kredsloeb.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Bipolar Junction Transistor (BJT), FET og PNP.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Effekt.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/AC-kredslÃ¸b.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Bass ForstÃ¦rker.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Diode PN.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Dioden.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Drawing 2023-01-14 18.43.16.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Halvledere.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Impedans og Resonans.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Kirchoffs StrÃ¸m lov.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Knudepunktmetode.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Knudepunktmetoden.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Kondensator formel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Kondensator.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Maskemetoden.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Ohms Lov Serie og Parallel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Op-Amp.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/OpAfLadning.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Resonans.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Spole.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/SpÃ¦ndings og strÃ¸m deler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Thevening.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Eksamen/Transistor.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Elektro.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Frekvens og phasor.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/FÃ¦lles Emitterkobling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Halvledere.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Impedans.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Komponenter og subcircuits.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Kondensator.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Ohms Lov.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Op og Afladning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Operationsforstaerker.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Operationsforstærker.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Opgaver/Drawing 2022-12-01 10.18.34.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Parrallel-koblinger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/RMS Effekt.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Resistor.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Sinusformet signal.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Spilt power supply.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Spoler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Superposition.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Tidsvarierende signaler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Elektro fysik/Ãkvivalentkredsloeb.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Forstaerkningsteknik/Noter/Biaskompensator og biasstrÃ¸m.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Forstaerkningsteknik/Noter/Common Mode Rejection (CMR).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Forstaerkningsteknik/Noter/Feedback tabel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Forstaerkningsteknik/Noter/Maksimal fejl i forstÃ¦rkning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/CONTRIBUTING.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/README.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/SECURITY.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/abbreviations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/booktitle.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch01.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch02.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch03.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch04.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch05.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch06.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch07.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch08.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch09.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch10.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch11.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch12.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/ch13.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/copyright.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/dedication.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/FreeRTOS/toc.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/Cortex M4/Cortex-M4 NVIC.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/Cortex M4/Cortex-M4 Registers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/Cortex M4/Cortex-M4 TIMER0.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/Drawing 2024-04-15 13.39.03.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/FreeRTOS (Real Time Operating System).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/RTCS (Run to Complete Scheduling).md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/RTCS - Scheduler API.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Indlejret Programmering/Noter/printf().md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Assignments/Kinematik opgaver.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Assignments/inverse kinematics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Building robots in matlab/2 axis 2D planar robot.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/DH Parameters.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Euler and fixed angles.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Forward Kinematics.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Joints.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Rotationmatrices.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Rotationsmatrices.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Transformation Matrix.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/Translationsmatrices.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Eksamen/inverse kinematics.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Inverse kinematics/Choice of Solution.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Inverse kinematics/Example.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Inverse kinematics/General.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Inverse kinematics/planar Inverse kinematics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Joints and Links/DH Parameters.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Joints and Links/Joints and Links.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Mappings/Cases.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Notation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Orientation/Mapping.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Orientation/Mere Rotation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Orientation/Rotation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Orientation/Translation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/PA/PA 1 opg1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/PA/PA 1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Velocity/Angular velocity.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Velocity/Linear velocity of rigid bodies.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kinematik/Lecture Notes/Velocity/Point velocity in frame.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Exercises/Exercise 1 Fuzzy control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Basics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Control Surface.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Four Value Functions.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Fuzzy Logic Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Fuzzy logic.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Mamdani or standard fuzzy system.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Markov Decision Process.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Monte Carlo Policy.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/On-Policy vs off-policy.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Q-Learning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Reinforcement Learning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Sugeno or Takagi-Sugeno or Functional Fuzzy Systems.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Temporal Difference.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Terminology.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/Tuning fuzzy controllers.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/n-Step Bootstrapping.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Kunstig inteligens/Lecture Notes/t-norms and s-norms.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Matlab & Mathematica/Bounding boxes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Matlab & Mathematica/Mathematica/Regler til inputs.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Matlab & Mathematica/Mathematica/Tag sÃ¸jler fra importet data.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Matlab & Mathematica/Mathematica generelle kommandoer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Matlab & Mathematica/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Modbus/Intro.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Noter/BODE plot.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Noter/Fourier RÃ¦kker.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Noter/Laplace Transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Noter/Normal form of a PDE.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Noter/Superpositionsprincippet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Double Integrals.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Fourier RÃ¦kker/Fourier RÃ¦kker.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Fourier RÃ¦kker/Opgave 1.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Fourier RÃ¦kker/Opgave 2.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Fourier RÃ¦kker/Opgave 3.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Fourier RÃ¦kker/Opgave 4.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Laplace/Opgave 2.1 Laplace.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Multivariable Funktioner.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Multivariable Calculus/Opgaver/Triple Integrals.excalidraw.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Bisection Method.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Boltzman Softmax Function.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Bootstrapping in RL.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Converge Error.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Error Analysis for linear equations.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/False Position Method.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Game Plan.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Game plan for ISA.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/ISA Progress.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/LU Decompostion.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Least squares problems.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Linear Least Square Problems org tut.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Numerical Integration.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Nummerical Recipes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/PopOS boot entry management.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Rapport Kilder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Richardson Extrapolation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Singular Value Decomposition.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Videnskabsteori Overblik.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/Virtual Monitor.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/info function.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/NewNotes/mini møder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Anti-Windup.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Closed Loop Transfer function.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Condition for Controllability.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Controllable Canonical Form.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Digitization.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Discrete Design.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/DomÃ¦ner.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/DÃ¦mpning af system.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Feedback Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Final Value Theorem.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Full Order Observer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Integral Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Kalman Filter & Random Variables.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Kaskade Kontrol.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Lead & Lag kompensatorer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Linear Invariante systemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Linearization.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Modellering af systemer/Impulsmoment sÃ¦tningen.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Modellering af systemer/KontinÃ¦r tids tilstands modeller.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Modellering af systemer/Matlab simulering.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Modellering af systemer/Modellering af Dynamiske systemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Modellering af systemer/TidsdomÃ¦ne Modeller.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Modellering af systemer/diskret tids tilstands model.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Nyquist Stability Criterion.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Observability.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Observer Based Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Open and Closed Loop Control System.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Optimal Control.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Overshoot Risetime og Settling time.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/PID Controller.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Polers indflydelse.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Ratio Damping.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Reference Signals.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Root Locus.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Stability Margin Gain and Phase.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/State Feedback.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/Steady State Tracking.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Reguleringsteknik/Noter/relation mellem s og z-domÃ¦ne.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Actions.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Build and run ROS.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Coverage Planning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Localization.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Nodes.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Odometry.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Parameters.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Ros2 basics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Sampling Based Planning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Service.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotics/Topics.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/BevÃ¦gelsesmÃ¦ngder/BevÃ¦gelsesmÃ¦ngde for et partikel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/BevÃ¦gelsesmÃ¦ngder/BevÃ¦gelsesmÃ¦ngde.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/BevÃ¦gelsesmÃ¦ngder/Elastisk stÃ¸d.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/DÃ¦mpede svingninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Effekt og arbejde.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Eksamen/Flytningsformel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Eksamen/Matematisk pendul.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Flytningsmoment.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Fysisk pendul.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Harmoniske bevÃ¦gelser.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Inertimoment og flytningsmoment.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Kraftmoment..md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Matematisk Pendul.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Pendul i store vinkler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Potentiel og kinetisk energi.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Rulning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Stift legemes Rotation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Tabeller/Densitet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Tabeller/restitutionskoefficient.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Tvungne Svingninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Robotters Fysik/Vigtige formler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Shared Memory/Inter Process Communication.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Exercises/Lektion 1 HÃ¸j og Lavpas filtre.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Exercises/Lektion 2 Sampling og Rekonstruktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Amplitudegrafer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Differensligninger.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Direkte type 1 og 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Bessel Butterworth & Chebushev.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Bessel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Butterworth.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Chebyshevfilter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Filtre Typer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Gruppeløbstid.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Højpasfilter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Konstruktion af filter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Lavpas til båndpasfilter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Lavpas til højpasfilter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Elektroniske Filtre/Valg af filter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Fourier/Lækage.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Fourier/Picket Fencing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/IIR Filtre.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Invers z-transformation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Kaskaderealisation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Overføringsfunktion Eksempel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Parallelrealisation.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Relation mellem s-domæne og z-domæne.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Aliasing.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Amplitudespektrum.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Differensligning Eksempel.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Frekvensanalyse.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Impulssampling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Nyquist-Shannon sætning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Overblik over Systemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Pulssampling/Amplitudespektrum for pulssampling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Pulssampling/Holdekredsløb.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Pulssampling/Pulssampler Model.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Pulssampling/Pulssampling Princip.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Rekonstruktion/Rekonstruktion Princip.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Rekonstruktion/Rekonstruktionsfilter.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Samplingfrekvens.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Samplingsignalet.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Sekvens/Laplacetransformeret frekvens.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Sekvens/Sekvenser Definition.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Sampling/Sekvens/Standard Frekvenser.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Stepfunktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Vinduer/Barlett Vindue.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Vinduer/Hamming og Hanning.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Vinduer/Kaiser vindue.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Vinduer/Rektangulært Vindue.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Signalbehandling/Lecture Notes/Vinduer/Vinduesfunktion.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/Databaser/Normalisering af Data.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/SQL/Groups.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/SQL/Having.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/SQL/Join.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/SQL/SQL kommandoer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/UML/Generel UML.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/Udvikling/Faser i traditionel softwareudvikling.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/Udvikling/Typer af systemer.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Softwareudvikling/Udvikling/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/ANOVA tables.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Exam test.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Formler.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Inference for Simple Linear Regression.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Komplet Beskrivelse.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Kontinuerte Stokastiske Variable.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Matlab Commands.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Simultaneous random variables.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Notes/Statistik/Terminologi.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 1.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 2.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 3.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 4.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 5.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 6.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Semesters/Semester 7.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Initial Value Problem Lecture.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Intro til Numeriske Metoder.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Lecture 4 SVD and error analysis.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Lecture 6 Convergence and root finding error.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Lecture 8 Numerical Integration.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Lecture 9 Newton-Cotes quadratures.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Lecture Least Square Problems.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Lecture Linear Least Squares problems.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Numerical Book.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Penzaboard.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Portfolio.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Root Finding Lecture.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Systems of non-linear equations Lecture.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/Videnskabsteori Intro.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/Slides/lecture 12.md
Formatting note: test-vaults/TheJoboReal_Noter/Uni/exam.md
Formatting note: test-vaults/TheJoboReal_Noter/Untitled.md
Formatting note: test-vaults/TheJoboReal_Noter/written_markdown/expected.md
Formatting note: test-vaults/TheJoboReal_Noter/written_markdown/ollamatest.md
Formatting note: test-vaults/TheJoboReal_Noter/written_markdown/page-1.md


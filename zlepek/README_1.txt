Navodila za projekt Zlepek
1. Zagon Demo skripte
Ta skripta zažene kodo za interpolacijo, izračuna vrednost na določeni točki in nariše graf. S tem potrdiš, da je tvoja koda delujoča.

Postopek:

Odpri terminal (PowerShell, Command Prompt, ipd.).

Znotraj mape zlepek zaženi Julio z aktiviranim projektnim okoljem:

Bash

julia --project=.
Ko se odpre Julia REPL (ukazna vrstica julia>), izvedi skripto z naslednjim ukazom:

Julia

include("demo.jl")
Na zaslonu se bo izpisala vrednost zlepka in odprlo se bo okno z narisanim grafom.

2. Izvajanje testov
Ta korak izvede teste, ki preverijo pravilnost tvojega modula.

Postopek:

V terminalu se prepričaj, da si v mapi zlepek.

Zaženi teste z naslednjim ukazom:

Bash

julia --project=. --startup-file=no -e 'using Pkg; Pkg.test()'
V terminalu se vidi, če so testi prestali

3. Generiranje poročila v PDF formatu
Ta korak uporabi Weave.jl in tvojo TeX Live namestitev, da iz demo.jl ustvari poročilo v PDF formatu.

Postopek:

V terminalu se prepričaj, da si v mapi zlepek.

Zaženi naslednji ukaz:

Bash

julia --project=. makedocs.jl
Ko se proces zaključi, bo v mapi zlepek ustvarjena datoteka z imenom demo_report.pdf.
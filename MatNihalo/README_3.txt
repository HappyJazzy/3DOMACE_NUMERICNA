1. Priprava okolja
Preden lahko zaženete katero koli skripto, morate pripraviti projektno okolje z namestitvijo vseh potrebnih paketov.

V terminalu se premaknite v glavno mapo projekta MatNihalo.

Zaženite naslednji ukaz, ki bo samodejno namestil vse odvisnosti, navedene v datotekah Project.toml in Manifest.toml:

Bash

julia --project=. -e 'using Pkg; Pkg.instantiate()'
2. Zagon demo skripte
Ta skripta izvede simulacijo nelinearnega in linearnega nihala ter prikaže rezultate in grafe.

Bash

julia --project=. demo.jl
3. Izvajanje testov
Ta korak izvede teste, ki preverijo pravilnost modula MatNihalo.

Bash

julia --project=. test/runtests.jl
4. Generiranje poročila v PDF formatu
Ta ukaz ustvari poročilo v PDF formatu z imenom matnihalo_porocilo.pdf.

Bash

julia --project=. makedocs.jl
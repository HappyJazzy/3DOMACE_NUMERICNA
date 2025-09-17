1. Zagon demo skripte
Ta skripta izvede glavno funkcijo in prikaže rezultate izračuna integrala.

Postopek:

Odpri terminal (PowerShell, Command Prompt, ipd.).

Znotraj mape Kvadratura2Tocke zaženi skripto z naslednjim ukazom:

Bash

julia --project=. demo.jl
Na zaslonu se bo izpisal rezultat izračuna.

2. Izvajanje testov
Ta korak izvede teste, ki preverijo pravilnost tvojega modula.

Postopek:

V terminalu se prepričaj, da si v mapi Kvadratura2Tocke.

Zaženi teste z naslednjim ukazom:

Bash

julia --project=. test/runtests.jl
V terminalu se bo prikazal povzetek rezultatov testov.

3. Generiranje poročila v PDF formatu
Ta korak uporabi Weave.jl in tvojo namestitev TeX Live, da iz demo.jl ustvari poročilo v PDF formatu.

Postopek:

V terminalu se prepričaj, da si v mapi Kvadratura2Tocke.

Zaženi naslednji ukaz:

Bash

julia --project=. makedocs.jl
Ko se proces zaključi, bo v mapi Kvadratura2Tocke ustvarjena datoteka z imenom kvadratura_porocilo.pdf.

Komentar:

Koda in testi so v redu. Poročilo je pomankljivo.
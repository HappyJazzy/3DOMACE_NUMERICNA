# POROČILO 1. DOMAČE NALOGE NARAVNI ZLEPEK 18.1.8

#Avtor: Ula Derenda Zonta

using Zlepek
using Plots
using Test

## ---------------------------------
## Testi
## ---------------------------------
# Za preverjanje pravilnosti interpolacije uporabimo testne podatke.

x = [0.0, 1.0, 2.0, 3.0]
y = [1.0, 2.0, 0.0, 2.0]

Z = Zlepek.interpoliraj(x, y)

# Z makrojem @test preverimo pravilnost izračunov in vključimo rezultate v poročilo.
@test isapprox(Zlepek.vrednost(Z, 0.0), 1.0)
@test isapprox(Zlepek.vrednost(Z, 1.0), 2.0)
@test isapprox(Zlepek.vrednost(Z, 2.0), 0.0)
@test isapprox(Zlepek.vrednost(Z, 3.0), 2.0)

## ---------------------------------
## Uporaba
## ---------------------------------
# Izračunano vrednost zlepka pri x=1.5 bomo prikazali v poročilu.
println("Vrednost zlepka v x=1.5: ", Zlepek.vrednost(Z, 1.5))

# Spodnja koda bo narisala graf
Zlepek.plot(Z)

# Poročilo je pomankljivo. Pričakoval bi opis problema, izpeljava ali opis algoritma, ki 
# reši problem. Ali vsaj navedba vira, po katerem ste algoritem povzeli. 
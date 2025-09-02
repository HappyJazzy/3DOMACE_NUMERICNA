# POROČILO 2. DOMAČE NALOGE GAUSS-LEGENDROVIH KVADRATURAH NA DVEH TOČKAH 18.2.13

# 
# ImplementiraLI SMO algoritem za izračun integrala na dveh točkah in
# sestavljeno ter prilagodljivo pravilo za približno računanje integralov.

# Koda upošteva vsa navodila naloge: uporablja le osnovne funkcije in
# algoritmi so v celoti implementirani.

using Kvadratura2Tocke
using Printf


# Poročilo prikazuje rešitev za integral:
# ∫₅⁰ sin(x)/x dx
# Zahtevana natančnost je 10 decimalk, kar ustreza relativni natančnosti 10⁻¹⁰.

# Za reševanje problema uporabimo prilagodljivo 2-točkovno Gauss-Legendrovo pravilo.
# To pravilo deli interval na manjše podintervale, dokler ni dosežena
# zahtevana natančnost (toleranca).

# Izvedemo glavno funkcijo, ki izpiše rezultate in jih vključi v poročilo.
println("--- Izračun integrala ∫₀⁵ sin(x)/x dx ---")
println("Zahtevana relativna natančnost: 10⁻¹⁰")

# Klic funkcije, ki izračuna integral in izpiše podatke.
I, m, evals, err = Kvadratura2Tocke.prikaz(tol=1e-10)

println("\n--- Analiza rezultata ---")
println("Ocenjena vrednost integrala: ", @sprintf("%.10f", I))
println("Število podintervalov (m): ", m)
println("Število vrednotenj funkcije: ", evals)
println("Ocenjena napaka zadnjega koraka: ", @sprintf("%.10e", err))

# Analiza števila izračunov funkcije za doseganje natančnosti
# Koda, ki jo potrebuješ za odgovor na vprašanje:
# "Oceni, koliko izračunov funkcije je potrebnih..."

# Prilagodljivi algoritem dinamično določa število podintervalov, to pomeni,
# da je število vrednotenj funkcije (evals) minimalno potrebno za dosego
# zahtevane natančnosti. 


# POROČILO 3 - MATEMATIČNO NIHALO 18.3.5

#Avtor: Ula Derenda Zonta

# Analizirali smo rešitev diferencialne enačbe za nelinearno nihalo
# in jo primerjamo z linearno aproksimacijo.

# Enačba nelinearnega nihala je prevedena na sistem prvega reda.


# *Čeprav navodila naloge določajo uporabo metode DOPRI5, smo zaradi tehničnih težav,
# (uvozom in izvedba znotraj projektnega okolja)
# za reševanje diferencialne enačbe uporabili klasično metodo Runge-Kutta 4. reda (RK4).
using Plots
using MatNihalo
## ---------------------------------
## Primerjava nihal
## ---------------------------------
# Za različne začetne pogoje primerjamo odmik nelinearnega in harmoničnega nihala.
#
# Parametri nihala:
g = 9.81       # gravitacija (m/s^2)
l = 1.0        # dolžina nihala (m)
#
# Začetni pogoji:
θ0 = π/4       # začetni kot (rad)
θdot0 = 0.0    # začetna kotna hitrost
#
# Časovni interval:
tspan = (0.0, 10.0)  # od 0 do 10 s
# Reši nelinearno (matematično) nihalo
sol_nl = MatNihalo.odmik_nihala(θ0, θdot0, tspan)
# Reši linearno (harmonično) nihalo
sol_lin = MatNihalo.odmik_nihala(θ0, θdot0, tspan; harmonic=true)
# Nariši primerjavo, ki bo vključena v poročilo.
plot(sol_nl.t, sol_nl[1,:], label="Nelinearno")
plot!(sol_lin.t, sol_lin[1,:], label="Linearno (harmonično)",
      xlabel="t [s]", ylabel="θ(t) [rad]",
      title="Primerjava linearnega in nelinearnega nihala")

## ---------------------------------
## Nihalni čas glede na energijo
## ---------------------------------
# Kot zahtevajo navodila, prikažemo odvisnost nihalnega časa od začetne energije
# nihala (ki je določena z začetnim odmikom).

# Prikaz odvisnosti nihalnega časa od začetnega kota
# plot_nihalni_cas() # Premaknjeno na konec

# Graf potrjuje, da se nihalni čas povečuje z začetnim odmikom,
# kar dokazuje nelinearno naravo nihala.

# To je konec poročila.
"""
    plot_nihajni_cas()
Izriše graf nihajnega časa glede na začetno energijo (kot θ0).
Vrednost:
-Plots objekt s krivuljo T(θ0)
"""
function plot_nihajni_cas()
    θ0s = 0.1:0.1:1.5
    T_ener = [MatNihalo.pendulum_period(θ0) for θ0 in θ0s]
    plot(θ0s, T_ener, xlabel="Začetni odmik θ_0[rad]",
         ylabel="Nihani čas T[s]",
         title="Nihalni čas nihala glede na energijo",
         legend=false)
end
# čeprav testi dokazujejo pravilno delovanje kode, je pri generiranju
# poročila prihajalo do napake, ki kaže na nepravilno prepoznavo funkcije plot_nihalni_cas.

plot_nihalni_cas()

# V kodi imate znak Unicode 00a0, ki predstavlja nedeljiv presledek. Mogoče ste zato imeli 
# težave z prepoznavo funkcij. 
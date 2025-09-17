module MatNihalo

using DifferentialEquations
using Plots
export sistem_nihala!, sistem_harmonic!, odmik_nihala, nihajni_cas, pendulum_period, plot_nihajni_cas
"""
    sistem_nihala!(du, u, p, t)

Sistem nelinearnega matematičnega nihala

Enačbe:
θ''(t) + (g/l) * sin(θ(t)) = 0  
x1 = θ, x2 = θ'  
x1' = x2  
x2' = -(g/l) * sin(x1)

Parametri:
-du vektor sprememb (output)
-u trenutne vrednosti [θ, θ']
-p parametri (g, l)
-t čas

Vrednost:
-du se posodobi z desno stranjo sistema
"""
function sistem_nihala!(du, u, p, t)
    g, l = p
    du[1] = u[2]
    du[2] = -(g/l) * sin(u[1])
end

"""
    sistem_harmonic!(du, u, p, t)

Sistem linearnega (harmoničnega) nihala

Enačbe:
θ''(t) + (g/l) * θ(t) = 0  

Parametri:
-du vektor sprememb (output)
-u trenutne vrednosti [θ, θ']
-p parametri (g, l)
-t čas
"""
function sistem_harmonic!(du, u, p, t)
    g, l = p
    du[1] = u[2]
    du[2] = -(g/l) * u[1]
end

"""
    odmik_nihala(θ0, θ0p, tspan; g=9.81, l=1.0, harmonic=false)

Izračuna odmik nihala čez čas

Parametri:
-θ0 začetni kot [rad]
-θ0p začetna hitrost [rad/s]
-tspan interval časa (t0, t1)
-g gravitacijski pospešek (privzeto 9.81)
-l dolžina nihala (privzeto 1.0)
-harmonic če true, uporabi linearni sistem

Vrednost:
- `sol` objekt ODESolution z rešitvijo [θ(t), θ'(t)]  
"""
function odmik_nihala(θ0, θ0p, tspan, g=9.81, l=1.0; harmonic=false)
    u0 = [θ0, θ0p]
    p = (g, l)
    f = harmonic ? sistem_harmonic! : sistem_nihala!
    # mišljeno je, da sami implementirate metodo za reševanje NDE
    prob = ODEProblem(f, u0, tspan, p)
    # Klasična Runge-Kutta metoda 4. reda
    sol = solve(prob, RK4(); dt=0.01, saveat=0.01)
    return sol
end

"""
    nihajni_cas(sol)

Približno izračuna nihajni čas matematičnega nihala iz rešitve ODE

Parametri:
-sol ODESolution, rezultat `odmik_nihala`

Vrednost:
-Float64 približno polni nihalni čas
-NaN, če ni crossing θ=0
"""
function nihajni_cas(sol)
    θ0 = sol[1][1]
    t_values = sol.t
    θ_values = sol[1,:]
    crossings = findall(i -> θ_values[i]*θ_values[i+1] < 0, 1:length(θ_values)-1)
    isempty(crossings) && return NaN
    # natančnost je omejena s korakom metode za reševanje NDE
    # kar pomeni, da za večjo natančnost potrebuje metoda za NDE večje število korakov
    # čeprav je napaka izračunanih približkov dovolj majhna.
    # Se pravi, da bi za 10 decimalk potrebovali 10^10 korakov krat perioda.
    # To omejitev bi presegli, če bi problem iskanja periode zastavili kot reševanje 
    # nelinearne enačbe y(t + p) = y(t) in ga rešili z metodami za reševanje nelinearnih 
    # enačb npr. bisekcijo ali Newtonovo metodo.
    return 2 * t_values[crossings[1]]   
end

"""
    pendulum_period(θ0; g=9.81, l=1.0)

Izračuna nihajni čas glede na začetni kot

Parametri:
-θ0 začetni odmik
-g gravitacijski pospešek
-l dolžina nihala

Vrednost:
-Float64: približen nihalni čas
"""
function pendulum_period(θ0, g=9.81, l=1.0)
    sol = odmik_nihala(θ0, 0.0, (0.0, 20.0), g, l)
    return nihajni_cas(sol)
end

"""
    plot_nihajni_cas()

Izriše graf nihajnega časa glede na začetno energijo (kot θ0).

Vrednost:
-Plots objekt s krivuljo T(θ0)
"""
function plot_nihajni_cas()
    θ0s = 0.1:0.1:1.5
    T_ener = [pendulum_period(θ0) for θ0 in θ0s]
    plot(θ0s, T_ener, xlabel="Začetni odmik θ₀[rad]",
         ylabel="Nihani čas T[s]",
         title="Nihalni čas nihala glede na energijo",
         legend=false)
end

end # module

using Test
using MatNihalo

# TESTI
g = 9.81
l = 1.0
θ0 = 0.01
θdot0 = 0.0
tspan = (0.0, 5.0)

# Majhen kot -> linearna in nelinearna rešitev sta skoraj enaki
sol_nl = MatNihalo.odmik_nihala(θ0, θdot0, tspan)
sol_lin = MatNihalo.odmik_nihala(θ0, θdot0, tspan; harmonic=true)

@test maximum(abs.(sol_nl[1,:] .- sol_lin[1,:])) < 1e-3

# Perioda narašča z začetnim kotom
initial_angles = [0.1, 0.5, 1.0]
periods = [MatNihalo.pendulum_period(θ0) for θ0 in initial_angles]

@test periods[1] ≤ periods[2] ≤ periods[3]

println("Vsi testi uspešno prestani!")

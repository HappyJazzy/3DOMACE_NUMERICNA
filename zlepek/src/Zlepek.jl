module Zlepek

export Spline, interpoliraj, vrednost, plot

using Plots

# Struct to hold cubic spline coefficients
struct Spline
    x::Vector{Float64}
    y::Vector{Float64}
    a::Vector{Float64}  # koeficienti kubičnih spline-ov
    b::Vector{Float64}
    c::Vector{Float64}
    d::Vector{Float64}
end

"""
    interpoliraj(x, y)

Izračuna koeficiente kubičnega zlepka za točke x in y

Vrne:
- Zlepek struct, ki vsebuje:
    x - vektor x vrednosti vhodnih točk
    y - vektor y vrednosti vhodnih točk
    a - konstanta za vsak interval
    b - linearni koeficient za vsak interval
    c - kvadratni koeficient za vsak interval
    d - kubični koeficient za vsak interval
"""
function interpoliraj(x::Vector{Float64}, y::Vector{Float64})
    n = length(x) - 1
    h = diff(x)

    α = zeros(n)
    for i in 2:n
        α[i] = (3/h[i])*(y[i+1]-y[i]) - (3/h[i-1])*(y[i]-y[i-1])
    end

    l = ones(n+1)
    μ = zeros(n)
    z = zeros(n+1)

    for i in 2:n
        l[i] = 2*(x[i+1]-x[i-1]) - h[i-1]*μ[i-1]
        μ[i] = h[i]/l[i]
        z[i] = (α[i]-h[i-1]*z[i-1])/l[i]
    end

    b = zeros(n)
    c = zeros(n+1)
    d = zeros(n)

    for j in n:-1:1
        c[j] = z[j] - μ[j]*c[j+1]
        b[j] = (y[j+1]-y[j])/h[j] - h[j]*(c[j+1]+2*c[j])/3
        d[j] = (c[j+1]-c[j])/(3*h[j])
    end

    return Spline(x, y, y[1:end-1], b, c[1:end-1], d)
end

"""
    vrednost(Z, x0)

Izračuna vrednost kubičnega zlepka Z v točki x0

Vrne Float64 = ocenjena y vrednost zlepka v točki x0
"""
function vrednost(Z::Spline, x0::Float64)
    x, a, b, c, d = Z.x, Z.a, Z.b, Z.c, Z.d
    i = findlast(xj -> xj <= x0, x)
    i = min(i, length(a))
    dx = x0 - x[i]
    return a[i] + b[i]*dx + c[i]*dx^2 + d[i]*dx^3
end

"""
    plot(Z)

Nariše kubični zlepek Z skupaj z vhodnimi podatkovnimi točkami

Vrne graf s zlepkovnimi in podatkovnimi točkami
"""
function plot(Z::Spline)
    xs = range(Z.x[1], Z.x[end], length=200)
    ys = [vrednost(Z, xi) for xi in xs]
    Plots.plot(xs, ys, label="Zlepek spline", lw=2)
    Plots.scatter!(Z.x, Z.y, color=:red, label="Data points")
end

end

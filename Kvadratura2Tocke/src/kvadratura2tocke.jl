module Kvadratura2Tocke

using Printf
export kvadratura2_interval, kvadratura2_sestavljeno, kvadratura2_prilagodljivo, prikaz

"""
    kvadratura2_interval(f, a, b)

Izračuna eno 2-točkovno G-L kvadratura funkcije "f" na intervalu [a, b].
Vrne približek vrednosti integrala.
"""
function kvadratura2_interval(f, a::Real, b::Real)
    mid = (a + b) / 2.0
    length = b - a
    half = length / 2.0
    root3 = sqrt(3.0)
    shift = half / root3
    x_left = mid - shift
    x_right = mid + shift
    f_left = f(x_left)
    f_right = f(x_right)
    result = half * (f_left + f_right)
    return result
end

"""
    kvadratura2_sestavljeno(f, a, b, m)

Sestavljena 2-točkovna G-L kvadratura funkcije "f" na [a,b] z uporabo "m" podintervalov.
Vrne približek integrala.
"""
function kvadratura2_sestavljeno(f, a::Real, b::Real, m::Integer)
    if m <= 0
        error("Št. podintervalov m mora biti > 0")
    end
    total_length = b - a
    h = total_length / m
    total_sum = 0.0
    current_left = a
    for i in 1:m
        current_right = current_left + h
        sub_result = kvadratura2_interval(f, current_left, current_right)
        total_sum += sub_result
        current_left = current_right
    end
    return total_sum
end

"""
    kvadratura2_prilagodljivo(f, a, b; tol=1e-10, rel=false, max_m=2^20)

Prilagodljiva 2-točkovna G-L kvadratura funkcije "f" na [a,b] do dosega
absolutne napake manjše od "tol".

Vrne terko (I, m, evals, difference)`:
-I = ocenjen integral
-m = št. uporabljenih podintervalov
-evals = št. funkcijskih vrednotenj
-difference = razlika med zadnjima korakoma
"""
function kvadratura2_prilagodljivo(f, a::Real, b::Real; tol=1e-10, rel=false, max_m=2^20)
    m = 1
    I_old = kvadratura2_sestavljeno(f, a, b, m)
    evals = 2 * m
    while true
        m *= 2
        I_new = kvadratura2_sestavljeno(f, a, b, m)
        evals += 2 * m
        difference = abs(I_new - I_old)
        threshold = rel ? tol * max(abs(I_new), eps(Float64)) : tol
        if difference < threshold || m >= max_m
            return I_new, m, evals, difference
        else
            I_old = I_new
        end
    end
end

"""
    prikaz(; tol=1e-10)

Primer uporabe adaptivne 2-točkovne G-L kvadrature za integral ∫₀⁵ sin(x)/x dx.
Izpiše ocenjen integral, št. podintervalov, št. funkcijskih vrednotenj in napako zadnjega koraka.
Vrne terko (I, m, evals, err).
"""
function prikaz(; tol=1e-10)
    f(x) = x == 0.0 ? 1.0 : sin(x)/x
    I, m, evals, err = kvadratura2_prilagodljivo(f, 0.0, 5.0; tol=tol, rel=false)
    println("--- Prikaz ---")
    println("Integral: ∫₀⁵ sin(x)/x dx")
    println("Ocenjena vrednost: ", @sprintf("%.12f", I))
    println("Podintervali (m): ", m)
    println("Ocena št. funkcijskih vrednotenj: ", evals)
    println("Ocenjena napaka (zadnji korak): ", @sprintf("%.3e", err))
    println("---------------")
    return I, m, evals, err
end

end # module

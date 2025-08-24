using Test
using Kvadratura2Tocke

@testset "Kvadratura 2-točkovna testi" begin
    # Simple polynomial
    f(x) = x^2
    rezultat = kvadratura2_interval(f, 0, 1)
    @test isapprox(rezultat, 1/3; atol=1e-12)

    # Composite quadrature
    rezultat = kvadratura2_sestavljeno(f, 0, 1, 10)
    @test isapprox(rezultat, 1/3; atol=1e-12)

    # Adaptive quadrature: use precomputed reference value
    f(x) = (x == 0.0) ? 1.0 : sin(x)/x
    ref = 1.54993124495
    I, m, evals, err = kvadratura2_prilagodljivo(f, 0, 5; tol=1e-10)
    @test isapprox(I, ref; atol=1e-10)
    @test m > 0
    @test evals >= 2
    @test err < 1e-9
end

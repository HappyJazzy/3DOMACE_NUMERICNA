using Test
using Zlepek

x = [0.0, 1.0, 2.0, 3.0]
y = [1.0, 2.0, 0.0, 2.0]

Z = Zlepek.interpoliraj(x, y)

@test isapprox(Zlepek.vrednost(Z, 0.0), 1.0)
@test isapprox(Zlepek.vrednost(Z, 1.0), 2.0)
@test isapprox(Zlepek.vrednost(Z, 2.0), 0.0)
@test isapprox(Zlepek.vrednost(Z, 3.0), 2.0)

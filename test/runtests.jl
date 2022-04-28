using IrrationalConstantRules
using IrrationalConstants
using Test

const IRRATIONALS = (
    twoπ,
    fourπ,
    halfπ,
    quartπ,
    invπ,
    twoinvπ,
    fourinvπ,
    inv2π,
    inv4π,
    sqrt2,
    sqrt3,
    sqrtπ,
    sqrt2π,
    sqrt4π,
    sqrthalfπ,
    invsqrt2,
    invsqrtπ,
    invsqrt2π,
    loghalf,
    logtwo,
    logten,
    logπ,
    log2π,
    log4π,
)

const INVERSE_PAIRS = (
    (π, invπ),
    (twoπ, inv2π),
    (twoinvπ, halfπ),
    (quartπ, fourinvπ),
    (fourπ, inv4π),
    (sqrt2π, invsqrt2π),
    (sqrt2, invsqrt2),
    (sqrtπ, invsqrtπ),
)

function test_with_function(f, a::Irrational)
    b = f(a)
    @test b ≈ f(float(a)) atol=1e-14

    # The output type can be Irrational, but we enforces Float64 for now.
    # If f(a) is approximately equal to a value in IRRATIONALS, f(a) should be Irrational.
    @test (b .≈ IRRATIONALS) == (b .=== IRRATIONALS)

    # If f(a) is close to integer, it should be a integer.
    if abs(b - round(b)) < 1e-14
        @test isinteger(b)
    end
end

@testset "IrrationalConstantRules.jl" begin
    @testset "rules for $(a)" for a in IRRATIONALS
        @testset "Logarithm" begin
            if a > 0
                test_with_function(log, a)
            else
                @test_throws DomainError log(a)
            end
        end
    
        @testset "Inverse" begin
            test_with_function(inv, a)
            test_with_function(t->t^-1, a)
        end
    
        @testset "Exponential" begin
            test_with_function(exp, a)
        end
    
        @testset "Triangular" begin
            test_with_function(sin, a)
            test_with_function(cos, a)
            @test sincos(a) == (sin(a),cos(a))
        end
    
        @testset "Square" begin
            test_with_function(t->t*t, a)
            test_with_function(abs2, a)
            test_with_function(t->t^2, a)
        end
    end
    
    @testset "Multiplicative inverse for (a,b)" for (a,b) in INVERSE_PAIRS
        @test a*b == true
        @test b*a == true
    end
end

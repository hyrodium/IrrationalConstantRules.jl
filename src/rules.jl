## Square
let SQUARE_PAIRS = (
        (sqrt2, 2),
        (sqrt3, 3),
        (sqrtπ, π),
        (sqrt2π, twoπ),
        (sqrt4π, fourπ),
        (sqrthalfπ, halfπ),
        (invsqrt2, 0.5),
        (invsqrtπ, invπ),
        (invsqrt2π, inv2π),
    )
    for (a,b) in SQUARE_PAIRS
        Base.:(*)(::typeof(a), ::typeof(a)) = b
        Base.literal_pow(::typeof(^), ::typeof(a), ::Val{2}) = b
    end
end

## Inverse
let INVERSE_PAIRS = (
        (π, invπ),
        (twoπ, inv2π),
        (twoinvπ, halfπ),
        (quartπ, fourinvπ),
        (fourπ, inv4π),
        (sqrt2π, invsqrt2π),
        (sqrt2, invsqrt2),
        (sqrtπ, invsqrtπ),
    )
    for (a,b) in INVERSE_PAIRS
        if a !== π  # Avoid type piracy
            Base.inv(::typeof(a)) = b
            Base.literal_pow(::typeof(^), ::typeof(a), ::Val{-1}) = b
        end
        Base.inv(::typeof(b)) = a
        Base.literal_pow(::typeof(^), ::typeof(b), ::Val{-1}) = a
        Base.:(*)(::typeof(a), ::typeof(b)) = one(Irrational)
        Base.:(*)(::typeof(b), ::typeof(a)) = one(Irrational)
    end
end

## Triangular
Base.sin(::Irrational{:twoπ}) = false
Base.cos(::Irrational{:twoπ}) = true
Base.sincos(::Irrational{:twoπ}) = (false, true)
Base.sin(::Irrational{:fourπ}) = false
Base.cos(::Irrational{:fourπ}) = true
Base.sincos(::Irrational{:fourπ}) = (false, true)
Base.sin(::Irrational{:quartπ}) = invsqrt2
Base.cos(::Irrational{:quartπ}) = invsqrt2
Base.sincos(::Irrational{:quartπ}) = (invsqrt2, invsqrt2)
Base.sin(::Irrational{:halfπ}) = true
Base.cos(::Irrational{:halfπ}) = false
Base.sincos(::Irrational{:halfπ}) = (true, false)

## Exponential
Base.exp(::Irrational{:loghalf}) = 0.5
Base.exp(::Irrational{:logtwo}) = 2
Base.exp(::Irrational{:logten}) = 10
Base.exp(::Irrational{:logπ}) = π
Base.exp(::Irrational{:log2π}) = twoπ
Base.exp(::Irrational{:log4π}) = fourπ

## Logarithm
# Base.log(::Irrational{:π}) = logπ  # Avoid type piracy
Base.log(::Irrational{:twoπ}) = log2π
Base.log(::Irrational{:fourπ}) = log4π

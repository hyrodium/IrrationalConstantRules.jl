# IrrationalConstantRules

This package overrides the return values for `Irrational`s defined in [`IrrationalConstants.jl`](https://github.com/JuliaMath/IrrationalConstants.jl).

```julia
julia> using IrrationalConstants

julia> sin(quartπ)
0.7071067811865476

julia> sin(twoπ)
0.0

julia> using IrrationalConstantRules

julia> sin(quartπ)
invsqrt2 = 0.7071067811865...

julia> sin(twoπ)
false
```

Please read the long discussion about this on https://github.com/JuliaMath/IrrationalConstants.jl/pull/14.
I still feel `sin(::Irrational) isa Irrational` can be reasonable.

## Installation

```
(@v1.7) pkg> add https://github.com/hyrodium/IrrationalConstantRules.jl
```

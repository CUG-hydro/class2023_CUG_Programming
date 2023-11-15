using Pkg
Pkg.activate("./pluto-deployment-environment")
Pkg.instantiate()

include("generate.jl")

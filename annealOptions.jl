#=
annealOptions:
- Julia version: 
- Author: Leif
- Date: 2019-03-13
=#
# using Parameters
# @with_kw struct annealOptions
#     InitTemp ::Float64 = 1.
#     MaxConsRej ::Int64 = 1000
#     MaxSuccess::Int64 = 20
#     MaxTries::Int64 = 300
#     StopTemp::Float64 = 1e-8
#     StopVal::Float64 = -Inf
#     Verbosity::Int64 = 1
# end
struct annealOptions
    InitTemp ::Float64
    MaxConsRej ::Int64
    MaxSuccess::Int64
    MaxTries::Int64
    StopTemp::Float64
    StopVal::Float64
    Verbosity::Int64
end

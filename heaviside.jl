#=
heaviside:
- Julia version: 
- Author: Leif
- Date: 2019-03-11
=#
# designed to apply heaviside to each element in an array
function heaviside(x::Array{Float64,1})
    outArray = Array{Float64, 1}(undef, length(x))
    iter = 1
    for i in x
        if i < 0.0
            outArray[iter] = 0.0;
        else
            outArray[iter] = 1.0
        end
        iter += 1
    end
    return outArray
end

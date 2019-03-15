#=
trapz:
- Julia version: 
- Author: Leif
- Date: 2019-03-11
=#
function trapz(A ::Array{Float64,1}, B ::Array{Float64,1})
     num ::Int64  =   length(A)
    outArray    =   Array{Float64,1}(undef, num)
    outArray[1] =   0.0
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        outArray[i]         =   outArray[i-1] + (aveVal*diff)
    end
    return outArray
end
#=
trapz:
- Julia version: 
- Author: Leif
- Date: 2019-03-11
=#
function cumtrapz(A ::Array{Float64,1}, B ::Array{Float64,1})
    #1 Dimensional Array
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

function cumtrapz(A ::Array{Float64,2}, B ::Array{Float64,2})
    #Psuedo-2Dimensional Arrays
     rowA ::Int64,colA::Int64  =   size(A)
     rowB::Int64,colB::Int64  =size(B) 
    num=max(rowA,colA);
    if(min(rowA,colA)>1)
        error("Dimension of first input is too Large :(")
    end
    if(min(rowB,colB)>1)
        error("Dimension of second input is too Large :(")
    end
    outArray    =   Array{Float64,1}(undef, num)
    outArray[1] =   0.0
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        outArray[i]         =   outArray[i-1] + (aveVal*diff)
    end
    return outArray
end

function cumtrapz(A ::Array{Float64,2}, B ::Array{Float64,1})
    #Psuedo-2Dimensional Arrays
     rowA ::Int64,colA::Int64  =   size(A)
    num::Int64=max(rowA,colA)
    if(min(rowA,colA)>1)
        error("Dimension of first input is too Large :( Plz only use 1 dimensional input arrays :)")
    end
    

    outArray    =   Array{Float64,1}(undef, num)
    outArray[1] =   0.0
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        outArray[i]         =   outArray[i-1] + (aveVal*diff)
    end
    return outArray
end

function cumtrapz(A ::Array{Float64,1}, B ::Array{Float64,2})
    #1 Dimensional Array
     num ::Int64  =   length(A)
    rowB,colB=size(B)
    if(min(rowB,colB)>1)
        error("The Second input dimension is too large :(")
    end
    outArray    =   Array{Float64,1}(undef, num)
    outArray[1] =   0.0
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        outArray[i]         =   outArray[i-1] + (aveVal*diff)
    end
    return outArray
end




function trapz(A ::Array{Float64,1}, B ::Array{Float64,1})
     num ::Int64  =   length(A)
     out::Float64 = 0.0;
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        out         += (aveVal*diff)
    end
    return out
end

function trapz(A ::Array{Float64,2}, B ::Array{Float64,2})
         #Psuedo-2Dimensional Arrays
     rowA ::Int64,colA::Int64  =   size(A)
     rowB::Int64,colB::Int64  =size(B) 
    num=max(rowA,colA);
    if(min(rowA,colA)>1)
        error("Dimension of first input is too Large :(")
    end
    if(min(rowB,colB)>1)
        error("Dimension of second input is too Large :(")
    end
     out::Float64 = 0.0;
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        out         += (aveVal*diff)
    end
    return out
end

function trapz(A ::Array{Float64,2}, B ::Array{Float64,1})
    rowA ::Int64,colA::Int64  =   size(A)
    num::Int64=max(rowA,colA)
    if(min(rowA,colA)>1)
        error("Dimension of first input is too Large :( Plz only use 1 dimensional input arrays :)")
    end
     out::Float64 = 0.0;
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        out         += (aveVal*diff)
    end
    return out
end



function trapz(A ::Array{Float64,1}, B ::Array{Float64,2})
        #1 Dimensional Array
     num ::Int64  =   length(A)
    rowB,colB=size(B)
    if(min(rowB,colB)>1)
        error("The Second input dimension is too large :(")
    end
    if(min(rowA,colA)>1)
        error("Dimension of first input is too Large :( Plz only use 1 dimensional input arrays :)")
    end
     out::Float64 = 0.0;
    for i in 2:num
        aveVal ::Float64    =   (B[i]+B[i-1])/2.0
        diff ::Float64      =   A[i]-A[i-1]
        out         += (aveVal*diff)
    end
    return out
end


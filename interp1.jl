#=
interp1:
- Julia version: 
- Author: https://discourse.julialang.org/t/julia-version-of-matlab-function-interp1/8540/2
- Date: 2019-03-11
=#
# using Interpolations
#
# function interp1(xpt, ypt, x; method="linear")
#
#     y = zeros(length(x))
#     idx = trues(length(x))
#
#     if method == "linear"
#         intf = interpolate((xpt,), ypt, Gridded(Linear()))
#         y[idx] = intf[x[idx]]
#
#     elseif method == "cubic"
#         itp = interpolate(ypt, BSpline(Cubic(Natural())), OnGrid())
#         intf = scale(itp, xpt)
#         y[idx] = [intf[xi] for xi in x[idx]]
#     end
#
#     return y
# end

# expects x and xpt to be monotonic
function interpMono(xpt, ypt, x)
    if x[1] < xpt[1]
        @warn "first point is lower than defined range"
    end
    if x[end] > xpt[end]
        @warn "last point is higher than defined range"
    end
    L = length(x)
    y = Array{Float64,1}(undef, L)
    bookmark = 1
    i = 1
    while i < L+1
        # Go until you go over the searched-for value, or hit it
        while x[i] > xpt[bookmark]
            bookmark += 1
        end

        ## Interpolate
        # If you hit the value you want in xpt, assign its correspoding ypt to y
        if x[i] == xpt[bookmark]
            y[i] = ypt[bookmark]
        # Otherwise, you have gone one past, so you know x[i] is in between xpt[bookmark-1] and xpt[bookmark]
        else
            xpt_high = xpt[bookmark]
            xpt_low = xpt[bookmark-1]
            ypt_high = ypt[bookmark]
            ypt_low = ypt[bookmark-1]

            x_spread = xpt_high - xpt_low
            y_spread = ypt_high - ypt_low

            fraction = (x[i]-xpt_low) / x_spread

            y[i] = ypt_low + (fraction * y_spread)
        end


    i += 1
    # Don't iterate bookmark: if you are still in between xpt[bookmark-1] and xpt[bookmark], you
    # will skip the while loop and go right back into interpolation
    end


    return y
end
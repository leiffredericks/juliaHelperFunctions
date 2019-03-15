#=
testSimAnneal:
- Julia version: 
- Author: Leif
- Date: 2019-03-14
=#
# Example:
# The so-called six-hump camelback function has several local minima in the range -3<=x<=3 and -2<=y<=2.
#  It has two global minima, namely f(-0.0898,0.7126) = f(0.0898,-0.7126) = -1.0316. We can define and minimise it as follows:
# camel = @(x,y)(4-2.1*x.^2+x.^4/3).*x.^2+x.*y+4*(y.^2-1).*y.^2;
# loss = @(p)camel(p(1),p(2));
# [x f] = anneal(loss,[0 0])
# We get output:
# Initial temperature: 1
# Final temperature: 3.21388e-007
# Consecutive rejections: 1027
# Number of function calls: 6220
# Total final loss: -1.03163
# x =
# -0.0899 0.7127
# f =
# -1.0316
# Which reasonably approximates the analytical global minimum (note that due to randomness,
# your results will likely not be exactly the same).
include("simAnneal.jl")
include("annealOptions.jl")
# using Random
using Parameters
function loss(params)
    x=params[1]
    y=params[2]
    energy = (4-2.1*x^2+x^4/3)*x^2+x*y+4*(y^2-1)*y^2
    return energy
end
parent = [0.,0.]
minimum, fval = anneal(loss, parent)
println(minimum)



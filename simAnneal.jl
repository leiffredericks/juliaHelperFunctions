#=
simAnneal: Adapted from the matlab code written by Joachim Vandekerckhove
https://www.mathworks.com/matlabcentral/fileexchange/10548-general-simulated-annealing-algorithm
- Julia version: 
- Adated by: Leif
- Date: 2019-03-13
=#
using Random
function anneal(loss::Function, parent::Array)

    ub = Array{Float64, 1}(undef, length(parent))
            fill!(ub,Inf)
    lb = Array{Float64, 1}(undef, length(parent))
            fill!(lb,-Inf)
    function newsol(input::Array, ub::Array, lb::Array)
        # (x.+(randperm(length(x))==length(x))*randn()/100)
        # ie the one from the original code, pick a random parameter and add random normal /100 to it
        Lp = length(input)
        output = Array{Float64, 1}(undef, Lp)
        idx = rand(1:Lp)
        for i in 1:Lp
            if i == idx
                proposedNew = input[i]+randn()/100
                if proposedNew < lb[i]
                    output[i] = lb[i]
                elseif proposedNew > ub[i]
                    output[i] = ub[i]
                else
                    output[i] = proposedNew
                end
            else
                output[i] = input[i]
            end
        end
        return output
    end
    function cool(Tin::Float64)
        return 0.8*Tin
    end
    type = "Kirkpatrick"
    options::annealOptions = annealOptions( 1., 1000, 20, 300, 1e-8, -Inf, 1)
    return anneal(loss, parent, ub, lb, newsol, cool, type, options)
end
function anneal(loss::Function, parent::Array, ub::Array, lb::Array)

    function newsol(input::Array, ub::Array, lb::Array)
        # (x.+(randperm(length(x))==length(x))*randn()/100)
        # ie the one from the original code, pick a random parameter and add random normal /100 to it
        Lp = length(input)
        output = Array{Float64, 1}(undef, Lp)
        idx = rand(1:Lp)
        for i in 1:Lp
            if i == idx
                proposedNew = input[i]+randn()/100
                if proposedNew < lb[i]
                    output[i] = lb[i]
                elseif proposedNew > ub[i]
                    output[i] = ub[i]
                else
                    output[i] = proposedNew
                end
            else
                output[i] = input[i]
            end
        end
        return output
    end
    function cool(Tin::Float64)
        return 0.8*Tin
    end
    type = "Kirkpatrick"
    options::annealOptions = annealOptions( 1., 1000, 20, 300, 1e-8, -Inf, 1)
    return anneal(loss, parent, ub, lb, newsol, cool, type, options)
end
function anneal(loss::Function, parent::Array, ub::Array, lb::Array, newsol::Function)

    function cool(Tin::Float64)
        return 0.8*Tin
    end
    type = "Kirkpatrick"
    options::annealOptions = annealOptions( 1., 1000, 20, 300, 1e-8, -Inf, 1)
    return anneal(loss, parent, ub, lb, newsol, cool, type, options)
end
function anneal(loss::Function, parent::Array, ub::Array, lb::Array, newsol::Function,
    cool::Function)

    type = "Kirkpatrick"
    options::annealOptions = annealOptions( 1., 1000, 20, 300, 1e-8, -Inf, 1)
    return anneal(loss, parent, ub, lb, newsol, cool, type, options)
end
function anneal(loss::Function, parent::Array, ub::Array, lb::Array, newsol::Function,
    cool::Function, type::String)

    options::annealOptions = annealOptions( 1., 1000, 20, 300, 1e-8, -Inf, 1)
    return anneal(loss, parent, ub, lb, newsol, cool, type, options)
end
function anneal(loss::Function, parent::Array, ub::Array, lb::Array, newsol::Function,
    cool::Function, type::String, options)
# ANNEAL  Minimizes a function with the method of simulated annealing
# (Kirkpatrick et al., 1983)
#
#  ANNEAL takes three input parameters, in this order:
#
#  LOSS is a function handle [anonymous function or inline()] with a loss()
#  function(), which may be of any type(), and needn't be continuous. It does
#  however, need to return a single value.
#
#  PARENT is a vector with initial guess parameters. You must input an
#  initial guess.
#
#  OPTIONS is a structure with settings for the simulated annealing. If no
#  OPTIONS structure is provided, ANNEAL uses a default structure. OPTIONS
#  can contain any or all of the following fields (missing fields are
#  filled with default values):
#
#       Verbosity: Controls output to the screen.
#                  0 suppresses all output
#                  1 gives final report only [default]
#                  2 gives temperature changes and final report
#       Generator: Generates a new solution from an old one.
#                  Any function handle that takes a solution as input and
#                  gives a valid solution (i.e. some point in the solution
#                  space) as output.
#                  The default function generates a row vector which()
#                  slightly differs from the input vector in one element:
#                  @(x) (x+(randperm(length(x))==length(x))*randn()/100)
#                  Other examples of possible solution generators:
#                  @(x) (rand(3,1)): Picks a random point in the unit cube
#                  @(x) (ceil([9 5].*rand(2,1))): Picks a point in a 9-by-5
#                                                 discrete grid()
#                  Note that if you use the default generator, ANNEAL only
#                  works on row vectors. For loss functions that operate on
#                  column vectors, use this generator instead of the
#                  default:
#                  @(x) (x[:]"+(randperm(length(x))==length(x))*randn()/100)"
#        InitTemp: The initial temperature, can be any positive number.
#                  Default is 1.
#        StopTemp: Temperature at which to stop(), can be any positive number
#                  smaller than InitTemp.
#                  Default is 1e-8.
#         StopVal: Value at which to stop immediately, can be any output of
#                  LOSS that is sufficiently low for you.
#                  Default is() -Inf().
#       CoolSched: Generates a new temperature from the previous one.
#                  Any function handle that takes a scalar as input and
#                  returns a smaller but positive scalar as output.
#                  Default is() @(T) (.8*T)
#      MaxConsRej: Maximum number of consecutive rejections, can be any()
#                  positive number.
#                  Default is 1000.
#        MaxTries: Maximum number of tries within one temperature, can be
#                  any positive number.
#                  Default is 300.
#      MaxSuccess: Maximum number of successes within one temperature, can
#                  be any positive number.
#                  Default is 20.
#
#
#  Usage:
#     [MINIMUM,FVAL] = ANNEAL[LOSS,NEWSOL,[OPTIONS]]
#          MINIMUM is the solution which generated the smallest encountered
#          value when input into LOSS.
#          FVAL is the value of the LOSS function evaluated at MINIMUM.
#     OPTIONS = ANNEAL[]
#          OPTIONS is the default options structure.
#
#
#  Example:
#     The so-called "six-hump camelback" function has several local minima
#     in the range -3<=x<=3 and -2<=y<=2. It has two global minima, namely
#     f[-0.0898,0.7126] = f[0.0898,-0.7126] = -1.0316. We can define and
#     minimise it as follows:
#          camel = (x,y) ->(4-2.1*x.^2+x.^4/3).*x.^2+x.*y+4*(y.^2-1).*y.^2
#          loss = (p) ->camel(p[1],p[2])
#          [x f] = ANNEAL[loss(),[0 0]]
#     We get output:
#               Initial temperature:     	1
#               Final temperature:       	3.21388e-007
#               Consecutive rejections:  	1027
#               Number of function calls:	6220
#               Total final loss():        	-1.03163
#               x =
#                  -0.0899    0.7127
#               f =
#                  -1.0316
#     Which reasonably approximates the analytical global minimum (note
#     that due to randomness, your results will likely not be exactly the
#     same).
#  Reference:
#    Kirkpatrick, S., Gelatt, C.D., & Vecchi, M.P. (1983). Optimization by
#    Simulated Annealing. _Science, 220_, 671-680.
#   joachim.vandekerckhove@psy.kuleuven.be
#   $Revision: v5 $  $Date: 2006/04/26 12:54:04 $ Explanation from Joachim

    # main settings
    Tinit = options.InitTemp;        # initial temp
    minT = options.StopTemp;         # stopping temp
    minF = options.StopVal
    max_consec_rejections = options.MaxConsRej
    max_try = options.MaxTries
    max_success = options.MaxSuccess
    report = options.Verbosity

    # counters etc
    itry ::Int64 = 0
    success ::Int64 = 0
    finished ::Bool = false
    consec ::Int64 = 0
    T = Tinit
    initenergy = loss(parent)
    oldenergy = initenergy
    total::Int64 = 0

    bestEnergy = initenergy
    bestParams = copy(parent)

    if report==2
         println("T = ", T, ", loss = ", oldenergy)
    end

    # itry counts the number of searches at EACH TEMP, and gets reset with each cooling
    while !finished
        itry += 1  # just an iteration counter
        current = parent; # Parent is the inital guess, current is the current parameter set, parent gets updated later

        ## Stop / decrement T criteria
        # You have either hit a predefined attempt limit, or max successes WITHIN ONE TEMPERATURE
        if itry >= max_try || success >= max_success
            # Only way to end the loop: cooled all the way or too many rejections (new changes not accepted)
            if T < minT || consec >= max_consec_rejections
                finished = true
                total = total + itry # Keeps track of all attempts (multiple within each temperature)
                break
            # Drop temp and try again
            else
                T = cool(T)   # decrease T according to cooling schedule function
                if report==2  # output
                    println("T = ", T, ", loss = ", oldenergy)
                end
                total = total + itry # Keeps track of all attempts (multiple within each temperature)
                itry = 1 # Reset number of tries cause we at a new temp
                success  = 1 # Reset number of successive successes (lol) cause new temp
            end
        end

        # Perturb the system based on the generator function: newsol (if newsol doesn't create new array,
        # parent will already be = to newparam and rejecting the change doesn't work
        newparam = newsol(current, ub, lb)
        # Determine cost of those new parameters in the defined cost function: loss
        newenergy = loss(newparam)

        # If we hit some predefined option for "good enough", call it and return
        if newenergy < minF
            parent = newparam
            oldenergy = newenergy
            break
        end

        # If we get a lower cost than the previous parameters, accept new parameters
        if oldenergy-newenergy > 1e-6
            parent = newparam # Add the new parameters to the chain and set them as parent (will now begin outer while loop again)
            oldenergy = newenergy # Associated energy with the new parent
            success  += 1 # Length of success chain increased
            consec = 0  # Reset consecutive failures to 0 cuase this is a success

            ## Copy over best so far here, if we just assign a pointer it may get lost, so you need to copy
            if oldenergy < bestEnergy
                bestEnergy = oldenergy
                bestParams = copy(parent)
            end
        # If energy is higher, use acceptance criteria ""type" to decide whether or not to accept new value
        else

            if acceptance(oldenergy, newenergy, T, type)
                parent = newparam
                oldenergy = newenergy
                success = success+1
            else
                consec += 1
            end
        end
    end

    if oldenergy-bestEnergy > 1e-6 # bestEnergy < oldenergy
        minimum = bestParams
        fval = bestEnergy
        println("You have a different minimum than where the search ended, hmmmmmm?")
        println("bestEnergy = ", bestEnergy, " at ",  bestParams)
        println("end energy = ", oldenergy, " at ",  parent)
    else
        minimum = parent
        fval = oldenergy
    end
    if report > 0
        println("Initial temperature: ", Tinit)
        println("Final temperature: ", T)
        println("Consecutive rejections: ", consec)
        println("Number of function calls: ", total)
        println("Total final loss(): ", fval)
    end
    return [minimum,fval]
end

    ################################################################################################
    # The following section of code is under active development and should be where HMC and other
    # potential forms of monte carlo acceptance should be implemented
    ################################################################################################
function acceptance(oldenergy::Float64, newenergy::Float64, T::Float64, type::String)
    if type == "Kirkpatrick"
        k::Float64 = 1.                            # boltzmann constant
        if rand() < exp( (oldenergy-newenergy)/(k*T) )
            return true
        else
            return false
        end
    elseif type == "HMC"
        println("hey dummy, you haven't made this yet'")
    else
        error("no valid type defined")
    end
end
    ################################################################################################

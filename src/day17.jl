module Day17

using AdventOfCode2015
using Combinatorics

function day17(input::String = readInput(joinpath(@__DIR__, "..", "data", "day17.txt")))
    data = parse.(Int, split(input))
    p1, minlength = part1(data, 150)
    p2 = part2(data, 150, minlength)
    return [p1, p2]
end

function part1(data::Array{Int,1}, amount::Int)
    n = 0
    minlength = length(data)
    for comb in combinations(data)
        if sum(comb) == amount
            n += 1
            if length(comb) < minlength
                minlength = length(comb)
            end
        end
    end
    return n, minlength
end

function part2(data::Array{Int,1}, amount::Int, minlength::Int)
    n = 0
    for comb in combinations(data, minlength)
        if sum(comb) == amount
            n += 1
        end
    end
    return n
end

# The following code is a recursive approach to the problem.
# But it is much slower than the brute-force approach and
# not used anymore.
function count_combinations(data::Array{Int,1}, amount::Int)
    available = BitVector(ones(Bool, length(data)))
    combs = Set{BitVector}()
    return _count_combinations(data, amount, available, combs, true)
end

function _count_combinations(data::Array{Int,1}, amount::Int, available::BitVector, combs::Set{BitVector}, first::Bool)
    if amount == 0
        if available ∉ combs
            push!(combs, available)
            return 1
        end
        return 0
    end
    ncombinations = 0
    for (i, v) in enumerate(data .* available)
        if v > 0 && amount - v >= 0
            a = copy(available)
            a[i] = false
            ncombinations += _count_combinations(data, amount - v, a, combs, false)
        end
    end
    if first
        c = count.(combs)
        max = maximum(c)
        n = count(c .== max)
        return ncombinations, n
    end
    return ncombinations
end

end # module

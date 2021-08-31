module Day24

using AdventOfCode2015
using Combinatorics

function day24(input::String = readInput(joinpath(@__DIR__, "..", "data", "day24.txt")))
    weights = parse.(Int, split(rstrip(input), "\n"))
    return [solve(weights, 3), solve(weights, 4)]
end

function solve(weights::Array{Int,1}, ngroups::Int)
    groupweight = sum(weights) ÷ ngroups
    groups = []
    gsize = 1
    stop = false
    while gsize < length(weights)
        for comb in combinations(weights, gsize)
            if sum(comb) == groupweight
                push!(groups, comb)
                stop = true
            end
        end
        gsize += 1
        stop && break
    end
    return minimum(prod.(groups))
end


end # module
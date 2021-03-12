module Day13

using AdventOfCode2015
using Combinatorics

function day13(input::String = readInput(joinpath(@__DIR__, "..", "data", "day13.txt")))
    names, data = parse_input(input)
    return solve(names, data)
end

function parse_input(input::AbstractString)
    lines = split(rstrip(input), "\n")
    reg = r"(\w+)\s+would\s+(gain|lose)\s+(\d+)\s+happiness\s+units\s+by\s+sitting\s+next\s+to\s+(\w+)\."
    data = Dict{Tuple{String, String},Int}()
    names = Set{String}()
    for line in lines
        m = match(reg, line)
        name1, posneg, absval, name2 = m.captures
        sign = (posneg == "gain" ? '+' : '-')
        value = parse(Int, sign * absval)
        data[(name1, name2)] = value
        push!(names, name1)
        push!(names, name2)
    end
    return names, data
end

function solve(names::Set{String}, data::Dict{Tuple{String,String},Int})
    highest = 0
    highest_part2 = 0
    pair_points = Array{Int,1}(undef, length(names))
    for perm in permutations(collect(names))
        s = 0
        for i = 2:length(perm)
            p = data[(perm[i-1], perm[i])] + data[(perm[i], perm[i-1])]
            pair_points[i] = p
            s += p
        end
        p = data[(perm[end], perm[1])] + data[(perm[1], perm[end])]
        pair_points[1] = p
        s += p
        if s > highest
            highest = s
        end
        if s - minimum(pair_points) > highest_part2
            highest_part2 = s - minimum(pair_points)
        end
    end
    return [highest, highest_part2]
end

end # module

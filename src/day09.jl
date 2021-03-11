module Day09

using AdventOfCode2015
using Combinatorics

function day09(input::String = readInput(joinpath(@__DIR__, "..", "data", "day09.txt")))
    names, data = parse_input(input)
    return solve(names, data)
end

function parse_input(input::AbstractString)
    sinput = split(rstrip(input), "\n")
    data = Dict{Tuple{String,String},Int}()
    names = Set{String}()
    for line in sinput
        sline = split(line)
        city1 = sline[1]
        city2 = sline[3]
        dist = parse(Int, sline[5])
        data[(city1, city2)] = dist
        data[(city2, city1)] = dist
        push!(names, city1)
        push!(names, city2)
    end
    return names, data
end

function solve(names, data)
    total_short = typemax(Int)
    total_long = 0
    for perm in permutations(collect(names))
        dist = 0
        success = true
        for (i, city2) in enumerate(perm[2:end])
            city1 = perm[i]
            if !haskey(data, (city1, city2))
                success = false
                break
            end
            dist += data[(city1, city2)]
        end
        if success
            if dist < total_short
                total_short = dist
            end
            if dist > total_long
                total_long = dist
            end
        end
    end
    return [total_short, total_long]
end

end # module

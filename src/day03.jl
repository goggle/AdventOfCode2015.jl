module Day03

using AdventOfCode2015

function day03(input::String = readInput(joinpath(@__DIR__, "..", "data", "day03.txt")))
    return [part1(input), part2(input)]
end

function visited_locations(input::AbstractString)
    visited = Array{Array{Int,1},1}([[0,0]])
    current = Array{Int,1}([0, 0])
    for c in input
        if c == '>'
            current[1] += 1
        elseif c == '<'
            current[1] -= 1
        elseif c == '^'
            current[2] += 1
        elseif c == 'v'
            current[2] -= 1
        end
        if current ∉ visited
            push!(visited, copy(current))
        end
    end
    return visited
end

function part1(input::AbstractString)
    return length(visited_locations(input))
end

function part2(input::AbstractString)
    santa = input[1:2:end]
    robo = input[2:2:end]
    visited_santa = visited_locations(santa)
    visited_robo = visited_locations(robo)
    return length(unique(vcat(visited_santa, visited_robo)))
end

end # module

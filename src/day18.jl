module Day18

using AdventOfCode2015
using OffsetArrays

function day18(input::String = readInput(joinpath(@__DIR__, "..", "data", "day18.txt")))
    data = parse_input(input)
    return [solve(data), solve(data; part2 = true)]
end

function solve(data::OffsetArray{Bool,2,Array{Bool,2}}; part2::Bool = false)
    for n = 1:100
        if part2
            data[1, 1] = data[1, 100] = data[100, 1] = data[100, 100] = true
        end
        next = copy(data)
        for i = 1:100
            for j = 1:100
                non = count_on_neighbours(data, i, j)
                if data[i, j] && non ∉ (2, 3)
                    next[i, j] = false
                end
                if !data[i, j] && non == 3
                    next[i, j] = true
                end
            end
        end
        data = next
    end
    if part2
        data[1, 1] = data[1, 100] = data[100, 1] = data[100, 100] = true
    end
    return count(data)
end

function count_on_neighbours(data::OffsetArray{Bool,2,Array{Bool,2}}, i::Int, j::Int)
    c = 0
    for k = i-1:i+1
        for l = j-1:j+1
            if data[k, l]
                c += 1
            end
        end
    end
    return c - data[i, j]
end

function parse_input(input::AbstractString)
    lines = split(rstrip(input), "\n")
    data = OffsetArray(zeros(Bool, 102, 102), 0:101, 0:101)
    for (i, line) in enumerate(lines)
        for (j, c) in enumerate(line)
            if c == '#'
                data[i, j] = true
            elseif c == '.'
                data[i, j] = false
            end
        end
    end
    return data
end

end # module

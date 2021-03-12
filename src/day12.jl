module Day12

using AdventOfCode2015
using JSON3

function day12(input::String = readInput(joinpath(@__DIR__, "..", "data", "day12.txt")))
    json = JSON3.read(input)
    return [part1(input), part2(json)]
end

function part1(input::String)
    return parse.(Int, [m.match for m in eachmatch(r"[+-]?\d+", input)]) |> sum
end

function part2(json)
    s = 0
    if json isa AbstractArray
        for elem in json
            s += part2(elem)
        end
    elseif json isa AbstractDict
        if "red" in values(json)
            return 0
        end
        for (k, v) in json
            s += part2(v)
        end
    elseif json isa Number
        s += json
    end
    return s
end

end # module

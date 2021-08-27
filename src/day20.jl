module Day20

using AdventOfCode2015

function day20(input::String = readInput(joinpath(@__DIR__, "..", "data", "day20.txt")))
    data = parse(Int, input)
    return [part1(data), part2(data)]
end

function part1(input::Int)
    input ÷= 10
    houses = zeros(Int, input)
    for i = 1:input
        for j = i:i:input
            houses[j] += i
        end
    end
    for i = 1:input
        if houses[i] >= input
            return i
        end
    end
end

function part2(input::Int)
    houses = zeros(Int, input)
    for i = 1:input
        for j = i:i:49*i
            if j > input
                break
            end
            houses[j] += i * 11
        end
    end
    for i = 1:input
        if houses[i] >= input
            return i
        end
    end
end

end # module

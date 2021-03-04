module Day01

using AdventOfCode2015

function day01(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    return [part1(input), part2(input)]
end

function part1(input::String)
    return count(c->c=='(', input) - count(c->c==')', input)
end

function part2(input::String)
    floor = 0
    for (position, c) in enumerate(input)
        if c == '('
            floor += 1
        elseif c == ')'
            floor -= 1
            if floor == -1
                return position
            end
        end
    end
end

end # module

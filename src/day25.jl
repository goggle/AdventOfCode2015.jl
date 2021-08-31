module Day25

using AdventOfCode2015

function day25(input::String = readInput(joinpath(@__DIR__, "..", "data", "day25.txt")))
    m = match(r".*row\s+(\d+),\s+column\s+(\d+).*", input)
    row, col = parse.(Int, m.captures)
    
    i, j = 1, 1
    code = 20151125
    while !(i == row && j == col)
        if i == 1
            i = j + 1
            j = 1
        else
            i -= 1
            j += 1
        end
        code = mod(code * 252533, 33554393)
    end

    return code
end


end # module
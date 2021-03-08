module Day06

using AdventOfCode2015

@enum Command begin
    turnon = 1
    turnoff = 2
    toggle = 3
end

function day06(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    commands, coordinates = parse_input(input)
    return [part1(commands, coordinates), part2(commands, coordinates)]
end

function parse_input(input::AbstractString)
    lines = split(rstrip(input), "\n")
    reg = r"(.+)\s+(\d+),(\d+)\s+through\s+(\d+),(\d+)"

    commands = Array{Command, 1}(undef, length(lines))
    coordinates = zeros(Int, length(lines), 4)
    for (i, line) in enumerate(lines)
        m = match(reg, line)
        if m[1] == "turn on"
            commands[i] = turnon
        elseif m[1] == "turn off"
            commands[i] = turnoff
        else
            commands[i] = toggle
        end
        for j = 1:4
            # Note: We increase the coordinates by 1, because
            # in Julia arrays are 1-indexed.
            coordinates[i, j] = parse(Int, m[j+1]) + 1
        end
    end
    return commands, coordinates
end

function part1(commands::Array{Command,1}, coordinates::Array{Int,2})
    grid = zeros(Bool, 1000, 1000)
    for (comm, coords) in zip(commands, eachrow(coordinates))
        if comm == turnon
            grid[coords[1]:coords[3], coords[2]:coords[4]] .= true
        elseif comm == turnoff
            grid[coords[1]:coords[3], coords[2]:coords[4]] .= false
        elseif comm == toggle
            grid[coords[1]:coords[3], coords[2]:coords[4]] .= .!grid[coords[1]:coords[3], coords[2]:coords[4]]
        end
    end
    return sum(grid)
end

function part2(commands::Array{Command,1}, coordinates::Array{Int,2})
    grid = zeros(Int, 1000, 1000)
    for (comm, coords) in zip(commands, eachrow(coordinates))
        if comm == turnon
            grid[coords[1]:coords[3], coords[2]:coords[4]] .+= 1
        elseif comm == turnoff
            grid[coords[1]:coords[3], coords[2]:coords[4]] .-= 1
            grid[grid .== -1] .= 0
        elseif comm == toggle
            grid[coords[1]:coords[3], coords[2]:coords[4]] .+= 2
        end
    end
    return sum(grid)
end

end # module

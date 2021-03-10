module Day07

using AdventOfCode2015

struct Wire
    identifier::String
    value::Channel{UInt16}
end

function day07(input::String = readInput(joinpath(@__DIR__, "..", "data", "day07.txt")))
    wires = setup(input)
    run!(wires, input)
    part1 = Int(fetch(wires["a"].value))

    wires = setup(input)
    put!(wires["b"].value, part1)
    run!(wires, input)
    part2 = Int(fetch(wires["a"].value))
    return [part1, part2]
end

function setup(input::AbstractString)
    wires = Dict{String,Wire}()
    sinput = split.(split(rstrip(input), "\n"))
    for line in sinput
        if "AND" in line || "OR" in line || "RSHIFT" in line || "LSHIFT" in line
            ids = (line[1], line[3], line[5])
        elseif "NOT" in line
            ids = (line[2], line[4])
        else
            ids = (line[1], line[3])
        end
        for id in ids
            wires[id] = Wire(id, Channel{UInt16}(1))
            v = tryparse(Int, id)
            if v != nothing
                put!(wires[id].value, v)
            end
        end
    end
    return wires
end

function run!(wires::Dict{String,Wire}, input)
    sinput = split.(split(rstrip(input), "\n"))
    for line in sinput
        if "AND" in line
            @async AND(wires[line[1]], wires[line[3]], wires[line[5]])
        elseif "OR" in line
            @async OR(wires[line[1]], wires[line[3]], wires[line[5]])
        elseif "LSHIFT" in line
            @async LSHIFT(wires[line[1]], wires[line[3]], wires[line[5]])
        elseif "RSHIFT" in line
            @async RSHIFT(wires[line[1]], wires[line[3]], wires[line[5]])
        elseif "NOT" in line
            @async NOT(wires[line[2]], wires[line[4]])
        else
            @async DIR(wires[line[1]], wires[line[3]])
        end
    end
end

function AND(a::Wire, b::Wire, c::Wire)
    put!(c.value, fetch(a.value) & fetch(b.value))
end

function OR(a::Wire, b::Wire, c::Wire)
    put!(c.value, fetch(a.value) | fetch(b.value))
end

function RSHIFT(a::Wire, b::Wire, c::Wire)
    put!(c.value, fetch(a.value) >> fetch(b.value))
end

function LSHIFT(a::Wire, b::Wire, c::Wire)
    put!(c.value, fetch(a.value) << fetch(b.value))
end

function NOT(a::Wire, c::Wire)
    put!(c.value, ~fetch(a.value))
end

function DIR(a::Wire, c::Wire)
    put!(c.value, fetch(a.value))
end


end # module

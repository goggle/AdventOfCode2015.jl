module Day08

using AdventOfCode2015

function day08(input::String = readInput(joinpath(@__DIR__, "..", "data", "day08.txt")))
    code, memory = count_code_and_memory(input)
    enc = encode(input)
    return [code - memory, enc - code]
end

function count_code_and_memory(input::AbstractString)
    lines = split(rstrip(input))
    memory = 0
    for line in lines
        out = replace(line, r"^\"" => "")
        out = replace(out, r"\"$" => "")
        out = replace(out, r"\\x[0-9a-f][0-9a-f]" => "C")
        out = replace(out, "\\\\" => "B")
        out = replace(out, "\\\"" => "R")
        memory += length(out)
    end
    return [sum(length(line) for line in lines), memory]
end

function encode(input::AbstractString)
    lines = split(rstrip(input))
    enc = 0
    for line in lines
        count = 2
        for c in line
            if c == '\"' || c == '\\'
                count += 2
            else
                count += 1
            end
        end
        enc += count
    end
    return enc
end

end # module

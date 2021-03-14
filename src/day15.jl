module Day15

using AdventOfCode2015

function day15(input::String = readInput(joinpath(@__DIR__, "..", "data", "day15.txt")))
    data = parse_input(input)
    return solve(data)
end

function solve(data::Array{Int,2})
    reduced_data = data[:, 1:4]
    m, _ = size(data)
    vals = zeros(Int, m)
    vals[end] = 100
    best = 0
    best_part2 = 0
    while true
        r = sum(reduced_data .* vals; dims=1)
        r[r .< 0] .= 0
        score = prod(r)
        if score > best
            best = score
        end
        if sum(data[:,end] .* vals) == 500 && score > best_part2
            best_part2 = score
        end

        !next!(vals, 100) && break
    end
    return [best, best_part2]

end

function parse_input(input::AbstractString)
    lines = split(rstrip(input), "\n")
    data = Array{Int,2}(undef, length(lines), 5)
    for (i, line) in enumerate(lines)
        m = match(r"capacity\s(-?\d+),\sdurability\s(-?\d+),\sflavor\s(-?\d+),\stexture\s(-?\d+),\scalories\s(-?\d+)", line)
        data[i, :] .= parse.(Int, m.captures)
    end
    return data
end

function next!(vals::Array{Int,1}, s::Int)
    # We assume that the first array is
    # [0, 0, 0, ..., 0, s]
    vals[end-1] == s && return false
    if vals[end] > 0
        vals[1] += 1
        vals[end] -= 1
        return true
    end
    for i = 2:length(vals) - 1
        if sum(vals[i:end-1]) >= s
            continue
        end
        vals[1:i-1] .= 0
        vals[i] += 1
        vals[end] = s - sum(vals[1:end-1])
        break
    end
    return true
end

end # module

module Day16

using AdventOfCode2015

function day16(input::String = readInput(joinpath(@__DIR__, "..", "data", "day16.txt")))
    data = parse_input(input)
    facts = Dict([
        ("children", 3),
        ("cats", 7),
        ("samoyeds", 2),
        ("pomeranians", 3),
        ("akitas", 0),
        ("vizslas", 0),
        ("goldfish", 5),
        ("trees", 3),
        ("cars", 2),
        ("perfumes", 1),
    ])
    return [part1(facts, data), part2(facts, data)]
end

function part1(facts::Dict{String,Int}, data::Array{Dict{String,Int},1})
    for (i, sue) in enumerate(data)
        success = true
        for (k, v) in sue
            if v != facts[k]
                success = false
                break
            end
        end
        if success
            return i
        end
    end
    return matches[1]
end

function part2(facts::Dict{String,Int}, data::Array{Dict{String,Int},1})
    for (i, sue) in enumerate(data)
        success = true
        for (k, v) in sue
            if k in ("cats", "trees")
                if v <= facts[k]
                    success = false
                    break
                end
                continue
            end
            if k in ("pomeranians", "goldfish")
                if v >= facts[k]
                    success = false
                    break
                end
                continue
            end
            if v!= facts[k]
                success = false
                break
            end
        end
        if success
            return i
        end
    end
    return matches
end

function parse_input(input::AbstractString)
    lines = split(rstrip(input), "\n")
    sues = Array{Dict{String,Int},1}(undef, length(lines))
    for (i, line) in enumerate(lines)
        d = Dict{String,Int}()
        data = split(line)[3:end]
        identifiers = data[1:2:end]
        values = data[2:2:end]
        for (id, val) in zip(identifiers, values)
            d[rstrip(id, ':')] = parse(Int, rstrip(val, ','))
        end
        sues[i] = d
    end
    return sues
end

end # module

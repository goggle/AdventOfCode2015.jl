module Day10

using AdventOfCode2015

function day10(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    input = collect(rstrip(input))
    for i = 1:40
        input = analyze(input)
    end
    part1 = length(input)
    for i = 1:10
        input = analyze(input)
    end
    part2 = length(input)
    return [part1, part2]
end

function analyze(s::Array{Char,1})
    separr = Array{Char,1}(undef, 2*length(s))
    last = 1
    separr[1] = s[1]
    nsep = 0
    for c in s[2:end]
        if c != separr[last]
            separr[last+1] = '|'
            last += 1
            nsep += 1
        end
        separr[last+1] = c
        last += 1
    end
    separr[last+1] = '|'
    last += 1
    nsep += 1

    i, j = 1, 1
    counts = Array{Int,1}(undef, nsep)
    digs = Array{Char,1}(undef, nsep)
    c = 0
    while j <= last
        if separr[j] == '|'
            digs[i] = separr[j - 1]
            counts[i] = c
            i += 1
            j += 1
            c = 0
            continue
        end
        c += 1
        j += 1
    end

    ncounts = sum(ndigits(x) for x in counts)
    output = Array{Char,1}(undef, nsep + ncounts)
    j = 1
    for i = 1:nsep
        for dig in digits(counts[i])
            output[j] = Char('0' + dig)
            j += 1
        end
        output[j] = digs[i]
        j += 1
    end

    return output
end

end # module

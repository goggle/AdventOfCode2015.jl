module Day14

using AdventOfCode2015

function day14(input::String = readInput(joinpath(@__DIR__, "..", "data", "day14.txt")))
    speeds, t1s, t2s = parse_input(input)
    distances = similar(speeds)
    limit = 2503
    for (i, (speed, t1, t2)) in enumerate(zip(speeds, t1s, t2s))
        distances[i] = distance(speed, t1, t2, limit)
    end
    return [maximum(distances), part2(speeds, t1s, t2s, limit)]
end

function parse_input(input::String)
    lines = split(rstrip(input), "\n")
    speeds = Array{Int,1}(undef, length(lines))
    t1s = similar(speeds)
    t2s = similar(speeds)

    for (i, line) in enumerate(lines)
        m = match(r".+\s(\d+)\s.+\s(\d+)\s.+\s(\d+)\s", line)
        speeds[i] = parse(Int, m[1])
        t1s[i] = parse(Int, m[2])
        t2s[i] = parse(Int, m[3])
    end
    return speeds, t1s, t2s
end

function distance(speed::Int, t1::Int, t2::Int, duration::Int)
    n = duration ÷ (t1 + t2)
    r = duration - n * (t1 + t2)
    dist = n * t1 * speed
    if r <= t1
        dist += r * speed
    else
        dist += t1 * speed
    end
    return dist
end

function part2(speeds::Array{Int,1}, t1s::Array{Int,1}, t2s::Array{Int,1}, duration::Int)
    distances = zeros(Int, length(speeds))
    points = zeros(Int, length(speeds))
    for t = 1:duration
        for i = 1:length(speeds)
            if mod1(t, t1s[i] + t2s[i]) <= t1s[i]
                distances[i] += speeds[i]
            end
        end
        maxi = maximum(distances)
        inds = findall(x->x==maxi, distances)
        points[inds] .+= 1
    end
    return maximum(points)
end

end # module

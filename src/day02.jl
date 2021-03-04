module Day02

using AdventOfCode2015

function day02(input::String = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    boxdims = [parse.(Int, x) for x in split.(split(input), 'x')]
    return [part1(boxdims), part2(boxdims)]
end

function part1(boxdims)
    s = 0
    for (x, y, z) in boxdims
        s1 = x * y
        s2 = y * z
        s3 = x * z
        s += 2*s1 + 2*s2 + 2*s3 + min(s1, s2, s3)
    end
    return s
end

function part2(boxdims)
    s = 0
    for bd in boxdims
        sbd = sort(bd)
        s += 2*sbd[1] + 2*sbd[2] + sbd[1]*sbd[2]*sbd[3]
    end
    return s
end

end # module

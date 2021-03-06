module Day04

using AdventOfCode2015
using MD5

function day04(input::String = readInput(joinpath(@__DIR__, "..", "data", "day04.txt")))
    return [solve(rstrip(input), 5), solve(rstrip(input), 6)]
end

function solve(input::AbstractString, ndigits::Int)
    number = 1
    compare = lpad(0, ndigits, "0")
    while true
        if bytes2hex(md5(input * string(number)))[1:ndigits] == compare
            return number
        end
        number += 1
    end
end

end # module

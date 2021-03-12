module Day11

using AdventOfCode2015

function day11(input::String = readInput(joinpath(@__DIR__, "..", "data", "day11.txt")))
    part1 = find_next(input)
    part2 = find_next(part1)
    return [part1, part2]
end

function find_next(input::AbstractString)
    password = collect(rstrip(input))
    len = length(password)
    while true
        increase!(password, len)
        rule1(password) && rule2(password) && rule3(password) && break
    end
    return String(password)
end

function increase!(password::Array{Char,1}, index::Int)
    password[index] += 1
    if password[index] > 'z'
        password[index] = 'a'
        if index > 1
            increase!(password, index - 1)
        end
    end
end

function rule1(password::Array{Char,1})
    for j = 3:length(password)
        password[j] - password[j - 1] == 1 && password[j - 1] - password[j - 2] == 1 && return true
    end
    return false
end

function rule2(password::Array{Char,1})
    ('i' ∈ password || 'o' ∈ password || 'l' ∈ password) && return false
    return true
end

function rule3(password::Array{Char,1})
    c = '\0'
    j = 0
    for i = 2:length(password)
        if password[i] == password[i - 1]
            j = i + 2
            c = password[i]
            break
        end
    end
    c == '\0' && return false
    for i = j:length(password)
        if password[i] == password[i - 1] && password[i] != c
            return true
        end
    end
    return false
end

end # module

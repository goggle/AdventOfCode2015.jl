module Day05

using AdventOfCode2015

function day05(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    words = split(input)
    return [count(isnice.(words))]
end

function isnice(word::AbstractString)
    return rule1(word) && rule2(word) && rule3(word)
end

function rule1(word::AbstractString)
    count = 0
    vowels = ('a', 'e', 'i', 'o', 'u')
    for c in word
        if c ∈ vowels
            count += 1
        end
    end
    count >= 3 && return true
    return false
end

function rule2(word::AbstractString)
    for i = 2:length(word)
        word[i-1] == word[i] && return true
    end
    return false
end

function rule3(word::AbstractString)
    forbidden = ["ab", "cd", "pq", "xy"]
    for forb in forbidden
        occursin(forb, word) && return false
    end
    return true
end

end # module

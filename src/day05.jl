module Day05

using AdventOfCode2015

function day05(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    words = split(input)
    return [count(isnice.(words)), count(isnice2.(words))]
end

function isnice(word::AbstractString)
    return rule1(word) && rule2(word) && rule3(word)
end

function isnice2(word::AbstractString)
    return rule4(word) && rule5(word)
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

function rule4(word::AbstractString)
    for i = 2:length(word)
        for j = i + 2:length(word)
            word[i-1] == word[j-1] && word[i] == word[j] && return true
        end
    end
    return false
end

function rule5(word::AbstractString)
    for i = 3:length(word)
        word[i-2] == word[i] && return true
    end
    return false
end


end # module

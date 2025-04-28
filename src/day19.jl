module Day19

using AdventOfCode2015

function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    sequence, translations = parse_input(input)
    tokens = tokenize(sequence)
    return [part1(tokens, translations), part2(sequence)]
end

function parse_input(input::AbstractString)
    translations = Dict{String,Vector{String}}()
    lines = split(rstrip(input), "\n")
    for line ∈ lines
        line == "" && break
        key, _, val = split(line)
        if !haskey(translations, key)
            translations[key] = Vector{String}()
        end
        push!(translations[key], val)
    end
    sequence = lines[end]
    return string(sequence), translations
end

function tokenize(sequence::String)
    tokens = String[]
    i = 1
    @inbounds while i <= length(sequence)
        if i < length(sequence) && islowercase(sequence[i+1])
            push!(tokens, sequence[i:i+1])
            i += 2
        else
            push!(tokens, string(sequence[i]))
            i += 1
        end
    end
    return tokens
end

function generate_molecules(tokens::Vector{String}, translations::Dict{String,Vector{String}})
    molecules = Set{String}()
    for i in 1:length(tokens)
        tok = tokens[i]
        haskey(translations, tok) || continue
        new_tokens = copy(tokens)
        for tr in translations[tok]
            new_tokens[i] = tr
            push!(molecules, join(new_tokens))
        end
    end
    return molecules
end

function part1(tokens::Vector{String}, translations::Dict{String,Vector{String}})
    generate_molecules(tokens, translations) |> length
end

function part2(molecule::String)
    tokens = tokenize(molecule)
    total_symbols = length(tokens)
    rn_ar_count = count(x -> x in ["Rn", "Ar"], tokens)
    y_count = count(x -> x == "Y", tokens)
    return total_symbols - rn_ar_count - 2 * y_count - 1
end

end # module

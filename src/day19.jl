module Day19

using AdventOfCode2015

function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    sequence, translations = parse_input(input)
    tokens = tokenize(sequence, translations)
    # return [part1(tokens, translations)]
    revtr = reverse_translations(translations)
    # return part2(sequence, revtr)
    return part2(sequence, translations)
end

function parse_input(input::AbstractString)
    translations = Dict{String,Array{String,1}}()
    lines = split(rstrip(input), "\n")
    for line in lines
        line == "" && break
        key, _, val = split(line)
        if !haskey(translations, key)
            translations[key] = Array{String,1}()
        end
        push!(translations[key], val)
    end
    sequence = lines[end]
    return sequence, translations
end

function tokenize(sequence::AbstractString, translations::Dict{String,T}) where T <: Any
    reg = Regex(join(keys(translations), "|"))
    tok = Array{String,1}()
    i = 1
    while true
        ran = findnext(reg, sequence, i)
        if ran == nothing
            if i < length(sequence)
                push!(tok, sequence[i:end])
            end
            break
        end
        if i < ran.start
            push!(tok, sequence[i:ran.start-1])
        end
        push!(tok, sequence[ran])
        i = ran.stop + 1
    end
    return tok
end

function part1(tokens::Array{String,1}, translations::Dict{String,Array{String,1}})
    s = Set{String}()
    for (i, tok) in enumerate(tokens)
        !haskey(translations, tok) && continue
        for tr in translations[tok]
            push!(s, join([tokens[1:i-1]; tr; tokens[i+1:end]]))
        end
    end
    return length(s)
end

function reverse_translations(translations::Dict{String,Array{String,1}})
    rev = Dict{String,String}()
    for (key, l) in translations
        for el in l
            rev[el] = key
        end
    end
    return rev
end

function part2(sequence::AbstractString, translations::Dict{String,Array{String,1}})
    rev = reverse_translations(translations)
    rnar = filter(x->occursin(r"Rn.+Ar", x), keys(rev))
    nrnar = filter(x->!occursin(r"Rn.+Ar", x), keys(rev))
    # println(nrnar)
    while any(occursin.(nrnar, sequence))
        # println("here")
        for k in nrnar
            sequence = replace(sequence, k => rev[k])
            # println(rev[k])
        end
    end
    while any(occursin.(rnar, sequence))
        # println("here")
        for k in rnar
            sequence = replace(sequence, k => rev[k])
            # println(rev[k])
        end
    end
    while any(occursin.(nrnar, sequence))
        # println("here")
        for k in nrnar
            sequence = replace(sequence, k => rev[k])
            # println(rev[k])
        end
    end
    while any(occursin.(rnar, sequence))
        # println("here")
        for k in rnar
            sequence = replace(sequence, k => rev[k])
            # println(rev[k])
        end
    end
    while any(occursin.(nrnar, sequence))
        # println("here")
        for k in nrnar
            sequence = replace(sequence, k => rev[k])
            # println(rev[k])
        end
    end
    while any(occursin.(rnar, sequence))
        # println("here")
        for k in rnar
            sequence = replace(sequence, k => rev[k])
            # println(rev[k])
        end
    end
    return sequence
end

# function part2(sequence::AbstractString, translations::Dict{String,Array{String,1}})
#     trans = copy(translations)
#     trans["Ar"] = String[]
#     trans["Rn"] = String[]
#     tokens = tokenize(sequence, trans)
#     return tokens
#     extended = []
#
#     level = 0
#     for tok in tokens
#         if tok ∉ ("Ar", "Rn")
#             push!(extended, tok)
#             if level > 0
#                 push!(extended, ",")
#             end
#         else
#             if tok == "Rn"
#                 push!(extended, "(")
#                 level += 1
#             else
#                 pop!(extended)
#                 push!(extended, ")")
#                 level -= 1
#                 if level > 0
#                     push!(extended, ",")
#                 end
#             end
#         end
#     end
#     nelems = count(x->x∉("(", ")", ","), extended)
#     # nbrackets = count(x->x∈("(", ")"), extended)
#     nbrackets = count(x->x==")", extended)
#     ncommas = count(x->x==",", extended)
#     println(nelems, " ", nbrackets, " ", ncommas)
#     # return nelems - nbrackets - 2*ncommas - 1
#     return extended
# end

# function part2(sequence::AbstractString, rev::Dict{String,String})
#     # revs = sort(rev; by=length)
#     revs = rev
#     s = sequence
#     while true
#         @label start
#         for (key, val) in rev
#             # println(revs[elem])
#             f = findall(key, s)
#             if length(f) > 0
#                 s = replace(s, key => val, count=1)
#                 @goto start
#             end
#         end
#         break
#     end
#     # for (key, val) in revs
#     #     s = replace(s, key => val)
#     # end
#
#     # revs = rev
#     # found = false
#     # while s != "e"
#     #     for (k, v) in revs
#     #         if occursin(k, s)
#     #             found = true
#     #         end
#     #         s = replace(s, k => v)
#     #     end
#     #     if !found
#     #         break
#     #     end
#     #     found = false
#     # end
#
#     return s
# end

end # module

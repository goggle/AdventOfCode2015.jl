module Day23

using AdventOfCode2015

struct Instruction
    name::String
    register::String
    value::Int
end

function day23(input::String = readInput(joinpath(@__DIR__, "..", "data", "day23.txt")))
    instructions = parse_input(input)
    return [run_program(instructions, 0, 0), run_program(instructions, 1, 0)]
end

function parse_input(input::String)
    instructions = []
    spinput = split(rstrip(input), "\n")
    for line in split.(split(rstrip(input), "\n"))
        if line[1] in ("hlf", "tpl", "inc")
            push!(instructions, Instruction(line[1], line[2][1:1], 0))
        elseif line[1] == "jmp"
            push!(instructions, Instruction(line[1], "", parse(Int, line[2])))
        elseif line[1] in ("jie", "jio")
            push!(instructions, Instruction(line[1], line[2][1:1], parse(Int, line[3])))
        end
    end
    return instructions
end

function run_program(instructions, a, b)
    counter = 1
    maxcounter = length(instructions)
    registers = [a, b]
    while counter >= 1 && counter <= maxcounter
        instruction = instructions[counter]
        instruction.register == "a" ? j = 1 : j = 2
        if instruction.name == "hlf"
            registers[j] ÷= 2
            counter += 1
        elseif instruction.name == "tpl"
            registers[j] *= 3
            counter += 1
        elseif instruction.name == "inc"
            registers[j] += 1
            counter += 1
        elseif instruction.name == "jmp"
            counter += instruction.value
        elseif instruction.name == "jie"
            if mod(registers[j], 2) == 0
                counter += instruction.value
            else
                counter += 1
            end
        elseif instruction.name == "jio"
            if registers[j] == 1
                counter += instruction.value
            else
                counter += 1
            end
        end
    end
    return registers[2]
end


end # module
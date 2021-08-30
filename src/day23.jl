module Day23

using AdventOfCode2015

abstract type Instruction end

struct Half <: Instruction
    register::Int
end

function execute!(registers::Array{Int,1}, counter::Int, instruction::Half)
    registers[instruction.register] ÷= 2
    return counter + 1
end

struct Triple <: Instruction
    register::Int
end

function execute!(registers::Array{Int,1}, counter::Int, instruction::Triple)
    registers[instruction.register] *= 3
    return counter + 1
end

struct Increment <: Instruction
    register::Int
end

function execute!(registers::Array{Int,1}, counter::Int, instruction::Increment)
    registers[instruction.register] += 1
    return counter + 1
end

struct Jump <: Instruction
    value::Int
end

function execute!(registers::Array{Int,1}, counter::Int, instruction::Jump)
    return counter + instruction.value
end

struct JumpIfEven <: Instruction
    register::Int
    value::Int
end

function execute!(registers::Array{Int,1}, counter::Int, instruction::JumpIfEven)
    mod(registers[instruction.register], 2) == 0 && return counter + instruction.value
    return counter + 1
end

struct JumpIfOne <: Instruction
    register::Int
    value::Int
end

function execute!(registers::Array{Int,1}, counter::Int, instruction::JumpIfOne)
    registers[instruction.register] == 1 && return counter + instruction.value
    return counter + 1
end

function day23(input::String = readInput(joinpath(@__DIR__, "..", "data", "day23.txt")))
    instructions = parse_input(input)
    return [run!([0, 0], instructions), run!([1, 0], instructions)]

end

function parse_input(input::String)
    instructions = Array{Instruction,1}()
    for line in split.(split(rstrip(input), "\n"))
        if line[1] == "hlf"
            line[2][1] == 'a' ? register = 1 : register = 2
            push!(instructions, Half(register))
        elseif line[1] == "tpl"
            line[2][1] == 'a' ? register = 1 : register = 2
            push!(instructions, Triple(register))
        elseif line[1] == "inc"
            line[2][1] == 'a' ? register = 1 : register = 2
            push!(instructions, Increment(register))
        elseif line[1] == "jmp"
            push!(instructions, Jump(parse(Int, line[2])))
        elseif line[1] == "jie"
            line[2][1] == 'a' ? register = 1 : register = 2
            push!(instructions, JumpIfEven(register, parse(Int, line[3])))
        elseif line[1] == "jio"
            line[2][1] == 'a' ? register = 1 : register = 2
            push!(instructions, JumpIfOne(register, parse(Int, line[3])))
        end
    end
    return instructions
end

function run!(registers::Array{Int,1}, instructions::Array{Instruction,1})
    counter = 1
    maxcounter = length(instructions)
    while counter >= 1 && counter <= maxcounter
        counter = execute!(registers, counter, instructions[counter])
    end
    return registers[2]
end


end # module
using AdventOfCode2015
using Test

@testset "Day 1" begin
    @test AdventOfCode2015.Day01.part1("(())") == 0
    @test AdventOfCode2015.Day01.part1("()()") == 0
    @test AdventOfCode2015.Day01.part1("(((") == 3
    @test AdventOfCode2015.Day01.part1("(()(()(") == 3
    @test AdventOfCode2015.Day01.part1("))(((((") == 3
    @test AdventOfCode2015.Day01.part1("())") == -1
    @test AdventOfCode2015.Day01.part1("))(") == -1
    @test AdventOfCode2015.Day01.part1(")))") == -3
    @test AdventOfCode2015.Day01.part1(")())())") == -3
    @test AdventOfCode2015.Day01.part2(")") == 1
    @test AdventOfCode2015.Day01.part2("()())") == 5
    @test AdventOfCode2015.Day01.day01() == [74, 1795]
end

@testset "Day 2" begin
    @test AdventOfCode2015.Day02.part1([[2,3,4]]) == 58
    @test AdventOfCode2015.Day02.part1([[1,1,10]]) == 43
    @test AdventOfCode2015.Day02.part2([[2,3,4]]) == 34
    @test AdventOfCode2015.Day02.part2([[1,1,10]]) == 14
    @test AdventOfCode2015.Day02.day02() == [1588178, 3783758]
end

@testset "Day 3" begin
    @test AdventOfCode2015.Day03.part1(">") == 2
    @test AdventOfCode2015.Day03.part1("^>v<") == 4
    @test AdventOfCode2015.Day03.part1("^v^v^v^v^v") == 2
    @test AdventOfCode2015.Day03.part2("^v") == 3
    @test AdventOfCode2015.Day03.part2("^>v<") == 3
    @test AdventOfCode2015.Day03.part2("^v^v^v^v^v") == 11
    @test AdventOfCode2015.Day03.day03() == [2081, 2341]
end

@testset "Day 4" begin
    @test AdventOfCode2015.Day04.solve("abcdef", 5) == 609043
    @test AdventOfCode2015.Day04.solve("pqrstuv", 5) == 1048970
    @test AdventOfCode2015.Day04.day04() == [117946, 3938038]
end

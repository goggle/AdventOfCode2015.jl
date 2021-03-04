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

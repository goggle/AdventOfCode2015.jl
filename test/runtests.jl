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

@testset "Day 5" begin
    @test AdventOfCode2015.Day05.isnice("ugknbfddgicrmopn") == true
    @test AdventOfCode2015.Day05.isnice("aaa") == true
    @test AdventOfCode2015.Day05.isnice("jchzalrnumimnmhp") == false
    @test AdventOfCode2015.Day05.isnice("haegwjzuvuyypxyu") == false
    @test AdventOfCode2015.Day05.isnice("dvszwmarrgswjxmb") == false
    @test AdventOfCode2015.Day05.isnice2("qjhvhtzxzqqjkmpb") == true
    @test AdventOfCode2015.Day05.isnice2("xxyxx") == true
    @test AdventOfCode2015.Day05.isnice2("uurcxstgmygtbstg") == false
    @test AdventOfCode2015.Day05.isnice2("ieodomkazucvgmuy") == false
    @test AdventOfCode2015.Day05.day05() == [238, 69]
end

@testset "Day 6" begin
    sample = "turn on 0,0 through 999,999\n" *
             "toggle 0,0 through 999,0\n" *
             "turn off 499,499 through 500,500\n"
    @test AdventOfCode2015.Day06.day06(sample) == [998996, 1001996]
    @test AdventOfCode2015.Day06.day06() == [569999, 17836115]
end

@testset "Day 7" begin
    sample = "123 -> x\n" *
             "456 -> y\n" *
             "x AND y -> d\n" *
             "x OR y -> e\n" *
             "x LSHIFT 2 -> f\n" *
             "y RSHIFT 2 -> g\n" *
             "NOT x -> h\n" *
             "NOT y -> i\n"
    wires = AdventOfCode2015.Day07.setup(sample)
    AdventOfCode2015.Day07.run!(wires, sample)
    @test take!(wires["x"].value) == 123
    @test take!(wires["y"].value) == 456
    @test take!(wires["d"].value) == 72
    @test take!(wires["e"].value) == 507
    @test take!(wires["f"].value) == 492
    @test take!(wires["g"].value) == 114
    @test take!(wires["h"].value) == 65412
    @test take!(wires["i"].value) == 65079

    @test AdventOfCode2015.Day07.day07() == [956, 40149]
end

@testset "Day 8" begin
    sample = "\"\"\n" *
             "\"abc\"\n" *
             "\"aaa\\\"aaa\"\n" *
             "\"\\x27\""
    @test AdventOfCode2015.Day08.day08(sample) == [12, 19]
    @test AdventOfCode2015.Day08.day08() == [1350, 2085]
end

@testset "Day 9" begin
    sample = "London to Dublin = 464\n" *
             "London to Belfast = 518\n" *
             "Dublin to Belfast = 141\n"
    @test AdventOfCode2015.Day09.day09(sample) == [605, 982]
    @test AdventOfCode2015.Day09.day09() == [141, 736]
end

@testset "Day 10" begin
    @test AdventOfCode2015.Day10.day10() == [252594, 3579328]
end

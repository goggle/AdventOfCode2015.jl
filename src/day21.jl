module Day21

using AdventOfCode2015

struct Item
    name::String
    cost::Int
    damage::Int
    armor::Int
end

function day21(input::String = readInput(joinpath(@__DIR__, "..", "data", "day21.txt")))
    lines = split(rstrip(input), '\n')
    bosshit = parse(Int, split(lines[1])[end])
    bossdamage = parse(Int, split(lines[2])[end])
    bossarmor = parse(Int, split(lines[3])[end])
    weapons = [
        Item("Dagger", 8, 4, 0),
        Item("Shortsword", 10, 5, 0),
        Item("Warhammer", 25, 6, 0),
        Item("Longsword", 40, 7, 0),
        Item("Greataxe", 74, 8, 0)
    ]
    armor = [
        Item("Leather", 13, 0, 1),
        Item("Chainmail", 31, 0, 2),
        Item("Splintmail", 53, 0, 3),
        Item("Bandedmail", 75, 0, 4),
        Item("Platemail", 102, 0, 5)
    ]
    rings = [
        Item("Damage +1", 25, 1, 0),
        Item("Damage +2", 50, 2, 0),
        Item("Damage +3", 100, 3, 0),
        Item("Defense +1", 20, 0, 1),
        Item("Defense +2", 40, 0, 2),
        Item("Defense +3", 80, 0, 3)
    ]
    return solve(bosshit, bossdamage, bossarmor, weapons, armor, rings)
end

function solve(bosshit::Int, bossdamage::Int, bossarmor::Int, weapons, armor, rings)
    myhit = 100
    lowestcost = 1000
    highestcost = 0
    for weapon in weapons
        cost = weapon.cost
        mydamage = weapon.damage
        myarmor = weapon.armor
        if play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost < lowestcost
            lowestcost = cost
        end
        if !play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost > highestcost
            highestcost = cost
        end

        for ring in rings
            cost = weapon.cost + ring.cost
            mydamage = weapon.damage + ring.damage
            myarmor = weapon.armor + ring.armor
            if play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost < lowestcost
                lowestcost = cost
            end
            if !play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost > highestcost
                highestcost = cost
            end
            for ring2 in rings
                ring == ring2 && continue
                cost = weapon.cost + ring.cost + ring2.cost
                mydamage = weapon.damage + ring.damage + ring2.damage
                myarmor = weapon.armor + ring.armor + ring2.armor
                if play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost < lowestcost
                    lowestcost = cost
                end
                if !play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost > highestcost
                    highestcost = cost
                end
            end
        end

        for arm in armor
            cost = weapon.cost + arm.cost
            mydamage = weapon.damage + arm.damage
            myarmor = weapon.armor + arm.armor
            if play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost < lowestcost
                lowestcost = cost
            end
            if !play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost > highestcost
                highestcost = cost
            end

            for ring in rings
                cost = weapon.cost + arm.cost + ring.cost
                mydamage = weapon.damage + arm.damage + ring.damage
                myarmor = weapon.armor + arm.armor + ring.armor
                if play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost < lowestcost
                    lowestcost = cost
                end
                if !play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost > highestcost
                    highestcost = cost
                end
                for ring2 in rings
                    ring == ring2 && continue
                    cost = weapon.cost + arm.cost + ring.cost + ring2.cost
                    mydamage = weapon.damage + arm.damage + ring.damage + ring2.damage
                    myarmor = weapon.armor + arm.armor + ring.armor + ring2.armor
                    if play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost < lowestcost
                        lowestcost = cost
                    end
                    if !play_game(myhit, mydamage, myarmor, bosshit, bossdamage, bossarmor) && cost > highestcost
                        highestcost = cost
                    end
                end
            end
        end
    end
    return [lowestcost, highestcost]
end

function play_game(myhit::Int, mydamage::Int, myarmor::Int, bosshit::Int, bossdamage::Int, bossarmor::Int)
    while true
        bosshit = bosshit - (mydamage - bossarmor)
        bosshit <= 0 && return true
        myhit = myhit - (bossdamage - myarmor)
        myhit <= 0 && return false
    end
end

end # module

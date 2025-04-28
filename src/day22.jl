module Day22

using AdventOfCode2015
using DataStructures

abstract type Spell end

struct MagicMissile <: Spell
    cost::Int
    damage::Int
    heal::Int
    timer::Int
end

struct Drain <: Spell
    cost::Int
    damage::Int
    heal::Int
    timer::Int
end

struct Shield <: Spell
    cost::Int
    damage::Int
    heal::Int
    timer::Int
end

struct Poison <: Spell
    cost::Int
    damage::Int
    heal::Int
    timer::Int
end

struct Recharge <: Spell
    cost::Int
    damage::Int
    heal::Int
    timer::Int
end

struct GameState
    playerhitpoints::Int
    playerarmor::Int
    playermana::Int
    bosshitpoints::Int
    bossdamage::Int
    shield_timer::Int
    poison_timer::Int
    recharge_timer::Int
    mana_spent::Int
end

@enum GameResult begin
    playerwon
    playerlost
    ongoing
end

const SPELLS = [
    MagicMissile(53, 4, 0, 0),
    Drain(73, 2, 2, 0),
    Shield(113, 0, 0, 6),
    Poison(173, 0, 0, 6),
    Recharge(229, 0, 0, 5)
]

function day22(input::String = readInput(joinpath(@__DIR__, "..", "data", "day22.txt")))
    bosshitpoints, bossdamage = parse_input(input)
    [part1(bosshitpoints, bossdamage), part2(bosshitpoints, bossdamage)]
end

function parse_input(input::String)
    lines = split(rstrip(input), "\n")
    hp = parse(Int, match(r"Hit Points: (\d+)", lines[1]).captures[1])
    damage = parse(Int, match(r"Damage: (\d+)", lines[2]).captures[1])
    (hp, damage)
end

function part1(bosshitpoints::Int, bossdamage::Int)
    solve(bosshitpoints, bossdamage, false)
end

function part2(bosshitpoints::Int, bossdamage::Int)
    solve(bosshitpoints, bossdamage, true)
end

function solve(bosshitpoints::Int, bossdamage::Int, hard_mode::Bool)
    state = GameState(50, 0, 500, bosshitpoints, bossdamage, 0, 0, 0, 0)
    pq = PriorityQueue{Tuple{Int,Int,GameState},Int}()
    enqueue!(pq, (1, 0, state) => 0)
    visited = Dict{Tuple{Int,Int,Int,Int,Int,Int},Int}()
    best_mana = typemax(Int)
    state_id = 1
    
    while !isempty(pq)
        _, mana_spent, current = dequeue!(pq)
        mana_spent >= best_mana && continue
        
        next, status = apply_effects(current, true, hard_mode)
        if status == playerwon
            best_mana = min(best_mana, mana_spent)
            continue
        elseif status == playerlost
            continue
        end
        
        for spell in SPELLS
            if next.playermana < spell.cost ||
               (spell isa Shield && next.shield_timer > 0) ||
               (spell isa Poison && next.poison_timer > 0) ||
               (spell isa Recharge && next.recharge_timer > 0)
                continue
            end
            
            after_spell = cast(next, spell)
            status = checkstate(after_spell)
            if status == playerwon
                best_mana = min(best_mana, mana_spent + spell.cost)
                continue
            elseif status == playerlost
                continue
            end
            
            after_boss, status = apply_effects(after_spell, false, hard_mode)
            if status == playerwon
                best_mana = min(best_mana, mana_spent + spell.cost)
                continue
            elseif status == playerlost
                continue
            end
            
            state_key = (
                after_boss.playerhitpoints, after_boss.playermana, after_boss.bosshitpoints,
                after_boss.shield_timer, after_boss.poison_timer, after_boss.recharge_timer
            )
            if !haskey(visited, state_key) || visited[state_key] > after_boss.mana_spent
                visited[state_key] = after_boss.mana_spent
                state_id += 1
                enqueue!(pq, (state_id, after_boss.mana_spent, after_boss) => after_boss.mana_spent)
            end
        end
    end
    
    best_mana
end

function cast(gs::GameState, spell::MagicMissile)
    GameState(
        gs.playerhitpoints, gs.playerarmor, gs.playermana - spell.cost,
        gs.bosshitpoints - spell.damage, gs.bossdamage,
        gs.shield_timer, gs.poison_timer, gs.recharge_timer,
        gs.mana_spent + spell.cost
    )
end

function cast(gs::GameState, spell::Drain)
    GameState(
        gs.playerhitpoints + spell.heal, gs.playerarmor, gs.playermana - spell.cost,
        gs.bosshitpoints - spell.damage, gs.bossdamage,
        gs.shield_timer, gs.poison_timer, gs.recharge_timer,
        gs.mana_spent + spell.cost
    )
end

function cast(gs::GameState, spell::Shield)
    GameState(
        gs.playerhitpoints, gs.playerarmor, gs.playermana - spell.cost,
        gs.bosshitpoints, gs.bossdamage,
        spell.timer, gs.poison_timer, gs.recharge_timer,
        gs.mana_spent + spell.cost
    )
end

function cast(gs::GameState, spell::Poison)
    GameState(
        gs.playerhitpoints, gs.playerarmor, gs.playermana - spell.cost,
        gs.bosshitpoints, gs.bossdamage,
        gs.shield_timer, spell.timer, gs.recharge_timer,
        gs.mana_spent + spell.cost
    )
end

function cast(gs::GameState, spell::Recharge)
    GameState(
        gs.playerhitpoints, gs.playerarmor, gs.playermana - spell.cost,
        gs.bosshitpoints, gs.bossdamage,
        gs.shield_timer, gs.poison_timer, spell.timer,
        gs.mana_spent + spell.cost
    )
end

function effect(gs::GameState, ::Type{MagicMissile})
    (gs.playerarmor, gs.playermana, gs.bosshitpoints)
end

function effect(gs::GameState, ::Type{Drain})
    (gs.playerarmor, gs.playermana, gs.bosshitpoints)
end

function effect(gs::GameState, ::Type{Shield})
    (7, gs.playermana, gs.bosshitpoints)
end

function effect(gs::GameState, ::Type{Poison})
    (gs.playerarmor, gs.playermana, gs.bosshitpoints - 3)
end

function effect(gs::GameState, ::Type{Recharge})
    (gs.playerarmor, gs.playermana + 101, gs.bosshitpoints)
end

function checkstate(gs::GameState)
    gs.playerhitpoints <= 0 || gs.playermana < 0 ? playerlost :
    gs.bosshitpoints <= 0 ? playerwon : ongoing
end

function apply_effects(gs::GameState, is_player_turn::Bool, hard_mode::Bool)
    player_hp = gs.playerhitpoints
    if is_player_turn && hard_mode
        player_hp -= 1
        if player_hp <= 0
            return (GameState(player_hp, gs.playerarmor, gs.playermana, gs.bosshitpoints, gs.bossdamage,
                              gs.shield_timer, gs.poison_timer, gs.recharge_timer, gs.mana_spent), playerlost)
        end
    end
    
    # Initialize with no effects
    armor, mana, boss_hp = (0, gs.playermana, gs.bosshitpoints)
    
    # Apply all active effects
    if gs.shield_timer > 0
        armor, mana, boss_hp = effect(gs, Shield)
    end
    if gs.poison_timer > 0
        armor2, mana2, boss_hp2 = effect(gs, Poison)
        armor, mana, boss_hp = (armor, mana + mana2 - gs.playermana, boss_hp + boss_hp2 - gs.bosshitpoints)
    end
    if gs.recharge_timer > 0
        armor2, mana2, boss_hp2 = effect(gs, Recharge)
        armor, mana, boss_hp = (armor, mana + mana2 - gs.playermana, boss_hp + boss_hp2 - gs.bosshitpoints)
    end
    
    # Update timers
    shield_timer = max(0, gs.shield_timer - 1)
    poison_timer = max(0, gs.poison_timer - 1)
    recharge_timer = max(0, gs.recharge_timer - 1)
    
    if !is_player_turn
        player_hp -= max(1, gs.bossdamage - armor)
    end
    
    new_state = GameState(
        player_hp, armor, mana, boss_hp, gs.bossdamage,
        shield_timer, poison_timer, recharge_timer, gs.mana_spent
    )
    (new_state, checkstate(new_state))
end

end # module
--[[
    Header
    --print("Header")

    --Obter definição do jogador
    --Obter definição do monstro

    --Apresentar o monstro

    --Começar loop de batalha

    O que você vai fazer?
    0. Atacar com espada
    1. Usar poção de regeneração
    2. Atirar uma pedra.
    3. Se esconder
]]

-- Dependencias
local player = require("player.player")
local monster = require("monster.monster")
local playerActions = require("player.actions")
local utils = require("utils")
local monsterActions = require("monster.actions")

utils.enableUtf8()

-- Mostrar desenho de uma espada
utils.printHeader()


player.Health = player.Health - 3
print(string.format("A vida do jogador é %d/%d", player.Health, player.maxHealth))

-- Obtendo definição do monstro
local boss = monster
local bossActions = monsterActions

utils.printCreature(boss)

playerActions.build()
bossActions.build()
-- Carregar loop de batalha

while true do 
    -- Oferecer ações ao jogador
    print()
    print("O que você deseja fazer em seguida: ")
    local validPlayerActions = playerActions.getValidActions(player,boss)
    for i, action in pairs(validPlayerActions)do
        print(string.format("%d. %s", i, action.description))
    end
    local chosenIndex = utils.ask()
    print("Chosen Index: ".. chosenIndex)
    --TODO 

    --Simular turno do jogador
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil
    --TODO
    if isActionValid then
        chosenAction.execute(player, boss)
    else
        print(string.format("Ação inválida! %s perdeu a vez!", player.name))
    end

    -- Ponto de saida: Jogador ou monstro sem vida
    if boss.Health <= 0 then 
        break
    end

    -- Simular turno da criatura
    print()
    local validBossActions = bossActions.getValidActions(player, boss)
    -- Pegando ação da criatura
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(player, boss)
    --TODO

    if player.Health <= 0 then 
        break
    end
end
-- Condiçõe win and loser
if player.Health <= 0 then 
    print()
    print("--------------------------------------------------------------------")
    print()
    print(string.format("%s não foi capaz de vencer %s",player.name, boss.name))
    print()
elseif boss.Health <= 0 then
    print()
    print("--------------------------------------------------------------------")
    print()
    print(string.format("%s prevaleceu e venceu %s",player.name, boss.name))
    print()
end
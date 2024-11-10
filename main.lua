--[[
    Header
    --print("Header")

    --Obter definição do jogador
    --Obter definição do monstro

    --Apresentar o monstro

    --Começar loop de batalha
]]

-- Dependencias
local player = require("definitions.player")
local monster = require("definitions.monster")

os.execute("chcp 65001")

print()

-- Mostrar desenho de uma espada
print([[
========================================================================
              
              />
 (           //------------------------------------------------------(
(*)OXOXOXOXO(*>                  --------                             \
 (           \\--------------------------------------------------------)
              \>
    
                    -----------------------------                        
                        
                         ⚔️ SIMULADOR DE BATALHA ⚔️

========================================================================

                Empunhe sua espara e se prepare para lutar.
                             É hora da batalha!

]])


player.Health = player.Health - 3
print(string.format("A vida do jogador é %d/%d", player.Health, player.maxHealth))

-- Obtendo definição do monstro
local boss = monster


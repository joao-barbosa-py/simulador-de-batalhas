local utils = require "utils"
local actions = {}

-- Colocando uma lista dentro do nosso módulo
actions.list = {}

function  actions.build(playerData, creatureData)
    actions.list = {}
    -- Atacar com a espeada
    local swordAttack = {
        description = "Atacar com a espada.",
        requiriment = nil,
        execute = function (playerData, creatureData)
            -- 1. Definir chance de sucesso
            local sucessChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed
            local success = math.random() <  sucessChance 
            -- 2. Calcular dano 
            local rawDamage = playerData.attack - math.random() * creatureData.defense
            --local realDamage = 4 - math.random() * 6
            local damage = math.max(1, math.ceil(rawDamage))

            -- 3. Apresentar resultado como print
            if success then
                print(string.format("%s atacou %s e deu %d pontos de dano",playerData.name,creatureData.name, damage))
                local healthRate = math.floor((creatureData.Health / creatureData.maxHealth) * 10)
                print(string.format("%s: %s", creatureData.name, utils.getProgressBar(healthRate)))
                -- 4. Aplicar o dano em caso de sucesso 
                creatureData.Health = creatureData.Health - damage
            else 
                print(string.format("%s tentou atacar, mas não desembainhou a espada",playerData.name))
            end
        end
    }

    local regenPotion = {
        description = "Tomar uma poção de regeneração.",
        requiriment = function (playerData, creatureData)
            return playerData.potions >= 1
        end,
        execute = function (playerData, creatureData)
            playerData.potions = playerData.potions - 1

            --Regenerar vida
            local regenPoints = 8
            playerData.Health = math.min(playerData.maxHealth, playerData.Health + regenPoints) 
            print(string.format("%s usou uma poção e recuperou alguns pontos de vida",playerData.name))
        end
    }

    --populate lista
    actions.list[#actions.list+1] = swordAttack
    actions.list[#actions.list+1] = regenPotion
    --actions.list[0+1] = swordAttack
    --actions.list[1+1] = swordAttack
end

---comment 
---Retorna uma lista de ações validas 


function actions.getValidActions(playerData, creatureData)
    local validActions = {}
    for _, action in pairs(actions.list) do 
        local requirement = action.requiriment
        local isValid = requirement == nil or requirement(playerData, creatureData)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions
end


return actions

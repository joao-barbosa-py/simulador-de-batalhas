local utils = require "utils"
local actions = {}

-- Colocando uma lista dentro do nosso módulo
actions.list = {}

function  actions.build()
    actions.list = {}
    -- Atacar com a espeada
    local bodyAttack = {
        description = "Dar um soco!",
        requiriment = nil,
        execute = function (playerData, creatureData)
            -- 1. Definir chance de sucesso
            local sucessChance = playerData.speed == 0 and 1 or creatureData.speed / playerData.speed
            local success = math.random() <  sucessChance 
            -- 2. Calcular dano 
            local rawDamage = creatureData.attack - math.random() * playerData.defense
            --local realDamage = 4 - math.random() * 6
            local damage = math.max(1, math.ceil(rawDamage))

            -- 3. Apresentar resultado como print
            if success then
                playerData.Health = playerData.Health - damage
                
                print(string.format("%s atacou a %s e deu %d pontos de dano", creatureData.name,playerData.name, damage))
                local healthRate = math.floor((playerData.Health / playerData.maxHealth) * 10)
                print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))
                
            else 
                print(string.format("%s tentou atacar, mas errou", creatureData.name))
            end
        end
    }

    local sonarAttack = {
        description = "Ataque sonar.",
        requiriment = nil,
        execute = function (playerData, creatureData)

            local rawDamage = creatureData.attack - math.random() * playerData.defense
            local damage = math.max(1, math.ceil(rawDamage * 0.3))

                -- Aplicando o dano
                playerData.Health = playerData.Health - damage
                

                -- Apresentando o resultado
                print(string.format("%s usou um sonar e deu %d pontos de dano", creatureData.name,damage))
                local healthRate = math.floor((playerData.Health / playerData.maxHealth) * 10)
                print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))    
    end
    }

    local waitAction = {
        description = "Aguardar",
        requiriment = nil,

        execute = function (playerData, creatureData)
            print(string.format("%s decidiu aguardar, e não realizou nenhum ataque nesse turno",creatureData.name))
        end
    }


    --populate lista
    actions.list[#actions.list+1] = bodyAttack
    actions.list[#actions.list+1] = sonarAttack
    actions.list[#actions.list+1] = waitAction

--     --actions.list[0+1] = swordAttack
--     --actions.list[1+1] = swordAttack
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

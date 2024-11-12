local utils = {}

---
--- Essa função habilita o UTF-8 no terminal 
---
function utils.enableUtf8()
    os.execute("chcp 65001")
end

---
--- Faz o print da apresentação do simulador no terminal.
---
function utils.printHeader()
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
end

function utils.getProgressBar(attribute)
    local fullChar = "▰"
    local emptyChar = "▭"

    local result = ""
    for i = 1,10, 1 do
        result = result .. (i<= attribute and fullChar or emptyChar)     
        end
    return result
end

---
---Faz print das informções de uma criatura
---

function utils.printCreature(creature)
    -- Calculate heath rate
    local healthRate = math.floor((creature.Health / creature.maxHealth) * 10)

    -- Cartão
    print("| "  .. creature.name)
    print("| ")
    print("| "  .. creature.description)
    print("| ")
    print("|  Atributos")
    print("Atributos")
    print("| Vida:          "..utils.getProgressBar(healthRate))
    print("| Ataque:        "..utils.getProgressBar(creature.attack))
    print("| Desefesa:      "..utils.getProgressBar(creature.defense))
    print("| Velocidade:    "..utils.getProgressBar(creature.speed))
end


-- Pergunta ao usuário por um número que é retornado pela função 
function utils.ask()
    io.write("> ")
    local answer = io.read("*n")
    return answer
end


return utils
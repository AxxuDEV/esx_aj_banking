
local function inputDialog(type)
    if type ~= nil then
        if type == 1 then
            local input = lib.inputDialog('Nosto', {
                {type = 'number', label = 'Nosto', icon = 'money', min = 1, required = true}
            })
            TriggerServerEvent('esx_aj_banking:sv:nosto', input[1])
        elseif type == 2 then
            local input1 = lib.inputDialog('Talletus', {
                {type = 'number', label = 'talletus', icon = 'money', min = 1, required = true}
            })
            TriggerServerEvent('esx_aj_banking:sv:talletus', input1[1])
        elseif type == 3 then 
            local input2 = lib.inputDialog('Siirto', {
                {type = 'input', label = 'Tilisiirto', description = 'Kirjoita henkilön ID kenelle haluat siirtää rahaa', min = '1', required = true},
                {type = 'number', label = 'Tilisiirto', icon = 'money-bill-transfer', min = 1, required = true}
            })
            TriggerServerEvent('esx_aj_banking:sv:siirto', input2[1], input2[2])
        end
    end
end
  

local function bankMenu()
    if not registered then
        lib.registerContext({
            id = 'bankMenu',
            title = 'Pankki',
            options = {
                {
                    title = 'Nosto',
                    icon = 'money-check',
                    description = 'Tästä voit nostaa rahaa',
                    onSelect = function()
                        inputDialog(1)
                    end
                },
                {
                    title = 'Talletus',
                    icon = 'money-check',
                    description = 'Tästä voit tallettaa rahaa',
                    onSelect = function()
                        inputDialog(2)
                    end
                },
                {
                    title = 'Tilisiirto',
                    icon = 'money-check',
                    description = 'Tästä voit siirtää toiselle rahaa',
                    onSelect = function()
                        inputDialog(3)
                    end
                },
                {
                    title = 'Saldosi',
                    icon = 'money-check',
                    description = 'Tästä voit katsoa sinun saldosi',
                    serverEvent = 'esx_aj_banking:sv:saldo'
                }
            }
        })
        registered = true
    end
    lib.showContext('bankMenu')
end

local options = {
    {
        name = 'pankki',
        icon = 'fa-solid fa-road',
        label = 'Pankki',
        canInteract = function(entity, distance, coords, name, bone)
            return not IsEntityDead(entity)
        end,
        onSelect = function()
            bankMenu()
        end
    }
}


local models = { `prop_atm_01`, `prop_atm_02` }
local optionsNames = { 'pankki' }

exports.ox_target:addModel(models, options)






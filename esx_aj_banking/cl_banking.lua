local bankCoords = {
    [1] = vector3(152.37715, -1035.063, 29.338615),
    [2] = vector3(313.68148, -279.001, 54.170772),
    [3] = vector3(1212.980, 330.841, 37.787),
    [4] = vector3(2962.582, 482.627, 15.703),
    [5] = vector3(112.202, 6469.295, 31.626),
    [6] = vector3(351.534, -49.529, 49.042),
    [7] = vector3(241.727, 220.706, 106.286),
    [8] = vector3(1175.06, 2706.64, 38.0940),
}


local function inputDialog(type)
    if type ~= nil then
        if type == 1 then
            local input = lib.inputDialog('Nosto', {
                {type = 'number', label = 'Nosto', icon = 'money-bill-transfer', min = 1, required = true}
            })
            TriggerServerEvent('esx_aj_banking:sv:nosto', input[1])
        elseif type == 2 then
            local input1 = lib.inputDialog('Talletus', {
                {type = 'number', label = 'talletus', icon = 'money-bill-transfer', min = 1, required = true}
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
        name = 'atm',
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
local optionsNames = { 'atm' }
exports.ox_target:addModel(models, options)

local function bankBlips(v)
    local blips = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blips, 277)
    SetBlipScale(blips, 1.0)
    SetBlipColour(blips, 5)
    SetBlipAsShortRange(blips, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Pankki')
    EndTextCommandSetBlipName(blips)
end

for k, v in pairs(bankCoords) do 
    exports.ox_target:addSphereZone({
        coords = vector3(v.x, v.y, v.z),
        radius = 2,         
        options = {
            {
                name = 'pankki',
                icon = 'fa-solid fa-circle',
                label = 'Pankki',
                debug = true ,
                drawSprite = true,
                onSelect = function()
                    bankMenu()
                end
            }
        }
    })
    bankBlips(v)
end




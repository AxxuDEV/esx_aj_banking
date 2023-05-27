RegisterNetEvent('esx_aj_banking:sv:nosto', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local balance = xPlayer.getAccount('bank').money
    if xPlayer then 
        if balance > amount then 
            xPlayer.removeAccountMoney('bank', amount)
            xPlayer.addAccountMoney('money', amount)
        else
            lib.notify(source, {
                description = 'Sinulla ei ole tarpeeksi pankissa rahaa',
                type = 'error',
            })
        end
    end
end)

RegisterNetEvent('esx_aj_banking:sv:saldo', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local balance = xPlayer.getAccount('bank').money
    lib.notify(source, {
        description = 'Sinulla on '..balance..'$ pankissa',
        type = 'inform',
    })
end)

RegisterNetEvent('esx_aj_banking:sv:talletus', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local balance = xPlayer.getAccount('money').money
    if xPlayer then
        if balance > amount then
            xPlayer.removeMoney(amount)
            xPlayer.addAccountMoney('bank', amount)
        else
            lib.notify(source, {
                description = 'Sinulla ei ole tarpeeksi käteistä',
                type = 'error',
            })
        end
    end
end)


RegisterNetEvent('esx_aj_banking:sv:siirto', function(id, amount)
    local player = ESX.GetPlayerFromId(source)
    local receiver = ESX.GetPlayerFromId(id)
    local balance = player.getAccount('bank').money
    if receiver ~= nil then
        if player ~= nil then
            if player == receiver then
                if balance ~= nil then 
                    player.removeAccountMoney('bank', amount)
                    receiver.addAccountMoney('bank', amount)
                    TriggerClientEvent('ox_lib:notify', receiver, {
                        description = 'Sait rahaa henkilöltä ' ..player.getName()..' summan : '..amount.. '$',
                        type = 'success',
                    })
                    lib.notify(source, {
                        description = 'Siirsit henkilölle ' ..receiver.getName()..' summan : '..amount.. '$',
                        type = 'success',
                    })
                else 
                    lib.notify(source, {
                        description = 'Sinulla ei ole tarpeeksi rahaa',
                        type = 'error',
                    })
                end
            else
                lib.notify(source, {
                    description = 'Et voi siirtää itsellesi rahaa',
                    type = 'error',
                })
            end
        end
    else
        lib.notify(source, {
            description = 'Ei henkilöä tuolla id:llä',
            type = 'error',
        })
    end
end)

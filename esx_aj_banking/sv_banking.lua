RegisterNetEvent('esx_aj_banking:sv:nosto', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local balance = xPlayer.getAccount('bank').money
    if not xPlayer then return end
        
    if balance > amount then 
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addAccountMoney('money', amount)
    else
        lib.notify(source, {
            description = 'You dont have enough money...',
            type = 'error',
        })
    end
end)

RegisterNetEvent('esx_aj_banking:sv:saldo', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local balance = xPlayer.getAccount('bank').money
    lib.notify(source, {
        description = 'You Have '..balance..'$ in the bank',
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
    if not player then 
        return 
    end
    if not receiver then
        lib.notify(source, {
            description = 'Ei henkilöä tuolla id:llä',
            type = 'error',
        })
        return    
    end

    if tonumber(source) == tonumber(id) then
        lib.notify(source, {
            description = 'Et voi siirtää itsellesi rahaa',
            type = 'error',
        })
        return
    end

    if not balance then 
        return
    end

    if balance < amount then 
        lib.notify(source, {
            description = 'Sinulla ei ole tarpeeksi rahaa',
            type = 'error',
        })     
        return
    end
        
    player.removeAccountMoney('bank', amount)
    receiver.addAccountMoney('bank', amount)
    TriggerClientEvent('ox_lib:notify', receiver, {
        description = 'You received money from: ' ..player.getName()..' in the amount of : '..amount.. '$',
        type = 'success',
    })
    lib.notify(source, {
        description = 'You transferred money to ' ..receiver.getName()..' in the amount of : '..amount.. '$',
        type = 'success',
    })
end)


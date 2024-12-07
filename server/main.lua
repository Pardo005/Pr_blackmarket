local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('blackmarket:purchase')
AddEventHandler('blackmarket:purchase', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    if Player.PlayerData.money.cash >= data.price then
        if data.type == "weapon" then
            if Player.Functions.AddItem(data.item, data.amount) then
                Player.Functions.RemoveMoney('cash', data.price)
                TriggerClientEvent('QBCore:Notify', src, "Compra exitosa", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "No tienes espacio suficiente", "error")
            end
        else
            if Player.Functions.AddItem(data.item, data.amount) then
                Player.Functions.RemoveMoney('cash', data.price)
                TriggerClientEvent('QBCore:Notify', src, "Compra exitosa", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "No tienes espacio suficiente", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "No tienes suficiente dinero", "error")
    end
end)
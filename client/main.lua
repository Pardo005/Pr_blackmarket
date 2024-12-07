local QBCore = exports['qb-core']:GetCoreObject()
local blackmarketPed = nil

CreateThread(function()
    RequestModel(Config.BlackMarketPed)
    while not HasModelLoaded(Config.BlackMarketPed) do
        Wait(1)
    end
    
    blackmarketPed = CreatePed(4, Config.BlackMarketPed, Config.BlackMarketLocation.x, Config.BlackMarketLocation.y, Config.BlackMarketLocation.z - 1, 0.0, false, true)
    FreezeEntityPosition(blackmarketPed, true)
    SetEntityInvincible(blackmarketPed, true)
    SetBlockingOfNonTemporaryEvents(blackmarketPed, true)
    
    exports['qb-target']:AddTargetEntity(blackmarketPed, {
        options = {
            {
                type = "client",
                event = "blackmarket:openMenu",
                icon = "fas fa-shopping-cart",
                label = "Acceder al Mercado Negro",
            },
        },
        distance = 2.0
    })
end)

RegisterNetEvent('blackmarket:openMenu')
AddEventHandler('blackmarket:openMenu', function()
    local menu = {}
    
    for k, v in pairs(Config.BlackMarketItems) do
        menu[#menu + 1] = {
            header = v.label,
            txt = "Precio: $" .. v.price,
            params = {
                event = "blackmarket:buyItem",
                args = {
                    item = v.name,
                    price = v.price,
                    type = v.type,
                    amount = v.amount
                }
            }
        }
    end
    
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('blackmarket:buyItem')
AddEventHandler('blackmarket:buyItem', function(data)
    TriggerServerEvent('blackmarket:purchase', data)
end)
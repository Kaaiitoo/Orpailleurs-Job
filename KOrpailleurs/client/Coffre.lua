ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



function CoffreOrpa()
    local COrpa = RageUI.CreateMenu("Stockage", "Menu Intéraction..")
    COrpa:SetRectangleBanner(151, 108, 28)
        RageUI.Visible(COrpa, not RageUI.Visible(COrpa))
            while COrpa do
            Citizen.Wait(0)
            RageUI.IsVisible(COrpa, true, true, true, function()

                    RageUI.ButtonWithStyle("Retirer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            OrpaRtire()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            OrpaDepose()
                            RageUI.CloseAll()
                        end
                    end)
                    
                end, function()
                end)
            if not RageUI.Visible(COrpa) then
            COrpa = RMenu:DeleteType("COrpa", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Kaitoooo.pos.Coffre.position.x, Kaitoooo.pos.Coffre.position.y, Kaitoooo.pos.Coffre.position.z)
        if dist3 <= 1.0 and Kaitoooo.genre then
            Timer = 0
            DrawMarker(25, Kaitoooo.pos.Coffre.position.x, Kaitoooo.pos.Coffre.position.y, Kaitoooo.pos.Coffre.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 151, 108, 28 , 255, false, true, p19, true)
            end
            if dist3 <= 1.0 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour ouvrir le coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            CoffreOrpa()    
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)

itemstock = {}
function OrpaRtire()
    local StockOrpa = RageUI.CreateMenu("Coffre", "Menu Intéraction..")
    StockOrpa:SetRectangleBanner(151, 108, 28)
    ESX.TriggerServerCallback('KOrpailleurs:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockOrpa, not RageUI.Visible(StockOrpa))
        while StockOrpa do
            Citizen.Wait(0)
                RageUI.IsVisible(StockOrpa, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    startAnim('mp_am_hold_up', 'purchase_beerbox_shopkeeper')
                                    Citizen.Wait(5000)
                                    ClearPedTasksImmediately(GetPlayerPed(-1))
                                    TriggerServerEvent('KOrpailleurs:getStockItem', v.name, tonumber(count))
                                    RageUI.CloseAll()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockOrpa) then
            StockOrpa = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function OrpaDepose()
    local DeposerOrpa = RageUI.CreateMenu("Coffre", "Menu Intéraction..")
    DeposerOrpa:SetRectangleBanner(151, 108, 28)
    ESX.TriggerServerCallback('KOrpailleurs:getPlayerInventory', function(inventory)
        RageUI.Visible(DeposerOrpa, not RageUI.Visible(DeposerOrpa))
    while DeposerOrpa do
        Citizen.Wait(0)
            RageUI.IsVisible(DeposerOrpa, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            startAnim('mp_am_hold_up', 'purchase_beerbox_shopkeeper')
                                            Citizen.Wait(5000)
                                            ClearPedTasksImmediately(GetPlayerPed(-1))
                                            TriggerServerEvent('KOrpailleurs:putStockItems', item.name, tonumber(count))
                                            RageUI.CloseAll()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DeposerOrpa) then
                DeposerOrpa = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

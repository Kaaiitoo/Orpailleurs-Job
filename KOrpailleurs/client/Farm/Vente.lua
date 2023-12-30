CoESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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



function VenteOrpa()
    local VenteOrpailleurs = RageUI.CreateMenu("Orpailleurs", "Menu Intéraction...")
    VenteOrpailleurs:SetRectangleBanner(151, 108, 28)
    RageUI.Visible(VenteOrpailleurs, not RageUI.Visible(VenteOrpailleurs))
    
    while VenteOrpailleurs do
        Citizen.Wait(0)
        RageUI.IsVisible(VenteOrpailleurs, true, true, true, function()
                RageUI.ButtonWithStyle("~h~→ Vendre tes lingots", "Prix : 30$/u", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('venteorpa')
                    end
                end)
        end)
    
        if not RageUI.Visible(VenteOrpailleurs) then
            VenteOrpailleurs = RMenu:DeleteType("VenteOrpailleurs", true)
            end
        end
    end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Kaitoooo.pos.Vente.position.x, Kaitoooo.pos.Vente.position.y, Kaitoooo.pos.Vente.position.z)
            if dist3 <= 1.5 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour vendre vos ~y~lingots", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            VenteOrpa()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)



local npc2 = {
	{hash="s_m_m_cntrybar_01", x = 267.65, y = 270.55, z = 105.53, a=301.12}, 
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        TaskStartScenarioInPlace(ped2, 'WORLD_HUMAN_CLIPBOARD_FACILITY', 0, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)
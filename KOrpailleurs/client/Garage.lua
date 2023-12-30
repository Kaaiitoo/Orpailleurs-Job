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

local pos = vector3(-428.76, -2793.49, 5.60)
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(pos)

    SetBlipSprite (blip, 439)
    SetBlipScale  (blip, 0.7)
    SetBlipColour (blip, 5)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Orpailleurs')
    EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function GarageOrpailleurs()
    local GarageOrpa = RageUI.CreateMenu("Garage", "Menu Intéraction..")
    GarageOrpa:SetRectangleBanner(151, 108, 28)
        RageUI.Visible(GarageOrpa, not RageUI.Visible(GarageOrpa))
            while GarageOrpa do
            Citizen.Wait(0)
            RageUI.IsVisible(GarageOrpa, true, true, true, function()


                for k,v in pairs(GarageKaitoo) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        DoScreenFadeOut(3000)
                        Citizen.Wait(3000)
                        DeletePed(ped2)
                        DoScreenFadeIn(3000)
                            kaitospawn(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end

    
                end, function()
                end)

            if not RageUI.Visible(GarageOrpa) then
            GarageOrpa = RMenu:DeleteType("GarageOrpa", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Kaitoooo.pos.Garage.position.x, Kaitoooo.pos.Garage.position.y, Kaitoooo.pos.Garage.position.z)
            if dist3 <= 1.0 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                        RageUI.Text({  message = "Appuyez sur [~r~E~w~] pour choisir un véhicule", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            FreezeEntityPosition(PlayerPedId(), true)
                            GarageOrpailleurs()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)


-- PED 
local npc2 = {
	{hash="s_m_m_dockwork_01", x = -413.97, y = -2800.15, z = 5.92, a=324.56}, 
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)


-- FUNCTION POUR SORTIR LA VOITURE 

function kaitospawn(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local vehicle = CreateVehicle(car, Kaitoooo.pos.SpawnVehicle.position.x, Kaitoooo.pos.SpawnVehicle.position.y, Kaitoooo.pos.SpawnVehicle.position.z, Kaitoooo.pos.SpawnVehicle.position.h, true, false)
    local hash = GetHashKey("s_m_m_dockwork_01") 
    while not HasModelLoaded(hash) do 
        RequestModel(hash) Wait(20) 
    end 
    local blip = AddBlipForEntity(vehicle)
    SetBlipSprite(blip, 734)
    local ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", vector3(-413.97, -2800.15, 5.92), 324.56, false, true)
    SetVehicleNumberPlateText(vehicle, "ORPA")
    SetPedIntoVehicle(ped, vehicle, -1)
    Wait(30)
    TaskVehicleDriveToCoord(ped, vehicle, vector3( -413.97,  -2800.15, 5.92) , 8.0, 0, GetEntityModel(vehicle), 411, 8.0)
    ESX.ShowNotification("<C>~r~HENDRICK</C>\n~s~J'arrive avec la voiture")
    Wait(25000)
    TaskLeaveAnyVehicle(ped, true, false)
    Citizen.SetTimeout(0, function()
      DeletePed(ped)
      local ped5 = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", vector3(-413.97, -2800.15, 5.00), 324.56, false, true)
      SetBlockingOfNonTemporaryEvents(ped5, true)
      FreezeEntityPosition(ped5, true)
      SetEntityInvincible(ped5, true)
    end)
  end
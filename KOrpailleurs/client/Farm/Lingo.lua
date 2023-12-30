ESX = nil

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

local Lingoooo = false
Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            Lingoooo()
                        end
                    else
                Lingoooo = false
            end
        Wait(Timer)
    end    
end)

function LingooooOR()
    if not Lingoooo then
        Lingoooo = true
    while Lingoooo do
        Citizen.Wait(2000)
        TriggerServerEvent('lingot')
    end
    else
        Lingoooo = false
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Kaitoooo.pos.Lingot.position.x, Kaitoooo.pos.Lingot.position.y, Kaitoooo.pos.Lingot.position.z)
        if dist3 <= 1.2 and Kaitoooo.genre then
            Timer = 0
            DrawMarker(25, Kaitoooo.pos.Lingot.position.x, Kaitoooo.pos.Lingot.position.y, Kaitoooo.pos.Lingot.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 151, 108, 28 , 255, false, true, p19, true)
            end
            if dist3 <= 1.2 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour faire fondre vos ~y~pépites", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            startAnim('mp_am_hold_up', 'purchase_beerbox_shopkeeper')
                            Citizen.Wait(5000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))              
                            LingooooOR()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)
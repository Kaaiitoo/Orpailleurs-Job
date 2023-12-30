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

---------------------------
function VestiarieORPA()
    local VestiarieORPA = RageUI.CreateMenu("Vestiaire", "Menu Intéraction..")
    VestiarieORPA:SetRectangleBanner(151, 108, 28)
        RageUI.Visible(VestiarieORPA, not RageUI.Visible(VestiarieORPA))
            while VestiarieORPA do
            Citizen.Wait(0)
            RageUI.IsVisible(VestiarieORPA, true, true, true, function()

                RageUI.ButtonWithStyle("~h~→ Reprendre ses vêtements",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            startAnim('clothingtie', 'try_tie_positive_a')
                            Citizen.Wait(5000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                        TriggerEvent('skinchanger:loadSkin', skin)
                        RageUI.CloseAll()
                        end)
                    end
                end)
    
                RageUI.ButtonWithStyle("~h~→ Tenue recrue",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        startAnim('clothingtie', 'try_tie_positive_a')
                        Citizen.Wait(5000)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, 16, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, 4, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, 66, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, 19, 0)
                        RageUI.CloseAll()
                    end
                end)

                if ESX.PlayerData.job.grade_name == 'experimente' or ESX.PlayerData.job.grade_name == 'ce' or ESX.PlayerData.job.grade_name == 'cpdg' or ESX.PlayerData.job.grade_name == 'boss' then 
                RageUI.ButtonWithStyle("~h~→ Tenue experimenté",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        startAnim('clothingtie', 'try_tie_positive_a')
                        Citizen.Wait(5000)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, 16, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, 4, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, 66, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, 19, 0)
                        RageUI.CloseAll()
                    end
                end)
            end

            if ESX.PlayerData.job.grade_name == 'ce' or ESX.PlayerData.job.grade_name == 'cpdg' or ESX.PlayerData.job.grade_name == 'boss' then 
                RageUI.ButtonWithStyle("~h~→ Tenue chef d'equipe",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        startAnim('clothingtie', 'try_tie_positive_a')
                        Citizen.Wait(5000)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, 16, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, 4, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, 66, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, 19, 0)
                        RageUI.CloseAll()
                    end
                end)
            end

            if ESX.PlayerData.job.grade_name == 'boss' then 
                RageUI.ButtonWithStyle("~h~→ Tenue patron",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        startAnim('clothingtie', 'try_tie_positive_a')
                        Citizen.Wait(5000)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, 16, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, 4, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, 66, 0)
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, 19, 0)
                        RageUI.CloseAll()
                    end
                end)
            end
    
    
            end, function()
            end, 1)

            if not RageUI.Visible(VestiarieORPA) then
            VestiarieORPA = RMenu:DeleteType("VestiarieORPA", true)
        end
    end
end

function SeMettreNu()
    SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0)
     SetPedComponentVariation(GetPlayerPed(-1) , 11, 91, 0)
     SetPedComponentVariation(GetPlayerPed(-1) , 3, 15, 0)
    SetPedComponentVariation(GetPlayerPed(-1) , 4, 14, 1)
    SetPedComponentVariation(GetPlayerPed(-1) , 6, 6, 0) 
    
    end

    function startAnim(lib, anim)
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        end)
    end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Kaitoooo.pos.Vestiaire.position.x, Kaitoooo.pos.Vestiaire.position.y, Kaitoooo.pos.Vestiaire.position.z)
        if dist3 <= 1.2 and Kaitoooo.genre then
            Timer = 0
            DrawMarker(25, Kaitoooo.pos.Vestiaire.position.x, Kaitoooo.pos.Vestiaire.position.y, Kaitoooo.pos.Vestiaire.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 151, 108, 28 , 255, false, true, p19, true)
            end
            if dist3 <= 1.2 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour ouvrir votre vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            VestiarieORPA()    
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)
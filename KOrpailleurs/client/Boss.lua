ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local Orpailleurs = nil

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


function Boss_actions()
    local Orpailleurs = RageUI.CreateMenu("Patron", "Menu Intéraction..")
    Orpailleurs:SetRectangleBanner(151, 108, 28)
      RageUI.Visible(Orpailleurs, not RageUI.Visible(Orpailleurs))
              while Orpailleurs do
                  Citizen.Wait(0)
                      RageUI.IsVisible(Orpailleurs, true, true, true, function()


            RageUI.ButtonWithStyle("~h~→ Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'orpa', amount)
                        RefreshOrpa()
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end)

            RageUI.ButtonWithStyle("~h~→ Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'orpa', amount)
                        RefreshOrpa()
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end) 

           RageUI.ButtonWithStyle("~h~→ Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(Orpailleurs) then
        Orpailleurs = RMenu:DeleteType("Orpailleurs", true)
    end
end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Kaitoooo.pos.Boss.position.x, Kaitoooo.pos.Boss.position.y, Kaitoooo.pos.Boss.position.z)
        if dist3 <= 1.2 and Kaitoooo.genre then
            Timer = 0
            DrawMarker(25, Kaitoooo.pos.Boss.position.x, Kaitoooo.pos.Boss.position.y, Kaitoooo.pos.Boss.position.z,  0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 151, 108, 28 , 255, false, true, p19, true)
            end
            if dist3 <= 1.2 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour gérer ton entreprise", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            startAnim('anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle')
                            FreezeEntityPosition(PlayerPedId(), true)
                            Boss_actions()
                end
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshOrpa()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateOrpa(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateOrpa(money)
    Orpailleurs = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'orpa', function(data, menu)
        menu.close()
    end, {wash = false})
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end


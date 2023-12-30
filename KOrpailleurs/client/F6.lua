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


function F6ORPA()
    local F6ORPAAAA = RageUI.CreateMenu("Orpailleurs", "Menu Intéraction...")
    F6ORPAAAA:SetRectangleBanner(151, 108, 28)
    RageUI.Visible(F6ORPAAAA, not RageUI.Visible(F6ORPAAAA))
    while F6ORPAAAA do
        Citizen.Wait(0)
            RageUI.IsVisible(F6ORPAAAA, true, true, true, function()
                RageUI.Checkbox("~h~→ Prendre son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
    
                        service = Checked
    
    
                        if Checked then
                            onservice = true
                            TriggerServerEvent('webhook')
                            RageUI.Popup({
                                message = "Vous avez pris votre service !"})
    
                            
                        else
                            onservice = false
                            TriggerServerEvent('webhook_off')
                            RageUI.Popup({
                                message = "Vous n'etes plus en service !"})
    
                        end
                    end
                end)
    
                if onservice then
    
                    RageUI.ButtonWithStyle("~h~→ Faire une facture",nil, {RightLabel = ""}, true, function(_,_,s)
                        local player, distance = ESX.Game.GetClosestPlayer()
                        local playerPed        = GetPlayerPed(-1)
                        if s then
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            if player ~= -1 and distance <= 3.0 then
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                                                Citizen.Wait(5000)
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_orpa', ('orpa'), montant)
                                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                                TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                            else
                                                ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)

                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                    RageUI.Separator("↓ ~o~     Lieux de travails    ~s~↓")
                    RageUI.ButtonWithStyle("~h~→ Placer le GPS sur la récolte",nil, {RightLabel = ""}, true, function(h, a, s)
                        if a then 
                        
                        RenderSprite("kaitoooo", "recolte",  0, 410, 430, 330)

                        end
                        if s then       
                            SetNewWaypoint(-1234.42, 2641.18, 4.75)
                        end
                    end)
                end

                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    RageUI.ButtonWithStyle("~h~→ Placer le GPS sur le traitement",nil, {RightLabel = ""}, true, function(h, a, s)
                        if a then
                        RenderSprite("kaitoooo", "traitement",  0, 410, 430, 330)

                        end
                        if s then       
                            SetNewWaypoint(1085.01, -2002.16, 30.43)
                        end
                    end)
                end
                    
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        RageUI.ButtonWithStyle("~h~→ Placer le GPS sur la vente",nil, {RightLabel = ""}, true, function(h, a, s)
                        if a then
                                RenderSprite("kaitoooo", "vente",  0, 410, 430, 330)
        
                        end
                        if s then      
                            SetNewWaypoint(267.65,  270.55, 105.53)
                        end
                    end)
                end
        
                if ESX.PlayerData.job.grade_name == 'ce' or ESX.PlayerData.job.grade_name == 'cpdg' or ESX.PlayerData.job.grade_name == 'boss' then 
                
                    RageUI.Checkbox("~h~→ Activer les annonces",nil, annonce,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
        
                            annonce = Checked
        
        
                            if Checked then
                                ONannonce = true
                                RageUI.Popup({
                                    message = "Vous avez pris votre service !"})
        
                                
                            else
                                ONannonce = false
                                RageUI.Popup({
                                    message = "Vous n'etes plus en service !"})
        
                            end
                        end
                    end)
        
                    if ONannonce then
                        RageUI.Separator("↓ ~b~     Listes des annonces    ~s~↓")

                RageUI.ButtonWithStyle("~h~→ Annonces Ouvertures",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('OuvertORPA')
                    end
                end)
        
                RageUI.ButtonWithStyle("~h~→ Annonces Fermetures",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('FermerORPA')
                    end
                end)

                RageUI.ButtonWithStyle("~h~→ Annonces Recrutements",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('RecruORPA')
                    end
                end)
        
                RageUI.ButtonWithStyle("~h~→ Annonces Personnalisées",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local te = KeyboardInput("Message", "", 100)
                        ExecuteCommand("iuop " ..te)
                    end
                end)

            end
            end
            
            end
            
                end, function() 
                end)

                if not RageUI.Visible(hihihi) then
                hihihi = RMenu:DeleteType("hihihi", true)
        end
    end
end


Keys.Register('F6', 'Orpailleurs', 'Ouvrir le Menu Orpailleurs', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpa' then
    	F6ORPA()
	end
end)

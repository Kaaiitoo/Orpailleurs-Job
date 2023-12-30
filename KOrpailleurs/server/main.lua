ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'orpa', 'orpa', 'society_orpa', 'society_orpa', 'society_orpa', {type = 'private'})


ESX.RegisterServerCallback('KOrpailleurs:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_orpa', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('KOrpailleurs:getStockItem')
AddEventHandler('KOrpailleurs:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_orpa', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Un objet a été retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('KOrpailleurs:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('KOrpailleurs:putStockItems')
AddEventHandler('KOrpailleurs:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_orpa', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, 'Un objet a été ajouté')
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

RegisterServerEvent('OuvertORPA')
AddEventHandler('OuvertORPA', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~y~Orpailleurs', '~b~Annonce', 'Notre entreprise ouvre ses portes!', 'CHAR_BRYONY', 8)
	end
end)

RegisterServerEvent('FermerORPA')
AddEventHandler('FermerORPA', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~y~Orpailleurs', '~b~Annonce', 'Notre entreprise ferme ses portes!', 'CHAR_BRYONY', 8)
	end
end)

RegisterServerEvent('RecruORPA')
AddEventHandler('RecruORPA', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~y~Orpailleurs', '~b~Annonce', 'Recrutement en cours, rendez-vous à l\'entreprise !', 'CHAR_BRYONY', 8)

    end
end)


RegisterCommand('iuop', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "orpa" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~y~Orpailleurs', '~b~Annonce', ''..msg..'', 'CHAR_BRYONY', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_BRYONY', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_BRYONY', 0)
end
end, false)

RegisterServerEvent('webhook')
AddEventHandler('webhook', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    PerformHttpRequest('https://discord.com/api/webhooks/917120121288425532/O6_s0p0kSFsN08Ly3MHJmxe0_P8ymGvJNWUdl2VHivyd2VcHFzLh_n8WtLEt5d_FzGLt', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a pris son service "}), { ['Content-Type'] = 'application/json' })
    end)

RegisterServerEvent('webhook_off')
AddEventHandler('webhook_off', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    PerformHttpRequest('https://discord.com/api/webhooks/917120121288425532/O6_s0p0kSFsN08Ly3MHJmxe0_P8ymGvJNWUdl2VHivyd2VcHFzLh_n8WtLEt5d_FzGLt', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a quitter son service "}), { ['Content-Type'] = 'application/json' })
    end)

	RegisterNetEvent('recolte_pailette')
AddEventHandler('recolte_pailette', function()
    local item = "pailette"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 5)
    end
end)

RegisterNetEvent('traitementpp')
AddEventHandler('traitementpp', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pailette = xPlayer.getInventoryItem('pailette').count
    local pepite = xPlayer.getInventoryItem('pepite').count

    if pepite > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de ~y~pépites...')
    elseif pailette < 10 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de ~g~pailettes pour faire fondre...')
    else
        xPlayer.removeInventoryItem('pailette', 10)
        xPlayer.addInventoryItem('pepite', 5)    
    end
end)

RegisterNetEvent('lingot')
AddEventHandler('lingot', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pepite = xPlayer.getInventoryItem('pepite').count
    local lingo = xPlayer.getInventoryItem('lingo').count

    if lingo > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de ~y~lingots d\'or...')
    elseif pepite < 10 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de ~g~pepites pour faire fondre...')
    else
        xPlayer.removeInventoryItem('pepite', 10)
        xPlayer.addInventoryItem('lingo', 5)    
    end
end)

RegisterNetEvent('venteorpa')
AddEventHandler('venteorpa', function()

    local money = math.random(30,30)
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local lingo = 0

    if xPlayer.getInventoryItem('lingo').count <= 0 then
        lingo = 0
    else
        lingo = 1
    end

    if lingo == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de lingots à vendre...')
        return
    elseif xPlayer.getInventoryItem('lingo').count <= 0 and argent == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de lingots à vendre...')
        lingo = 0
        return
    elseif lingo == 1 then
            local money = math.random(30,30)
            xPlayer.removeInventoryItem('lingo', 1)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_orpa', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
                societyAccount.addMoney(money)
                TriggerClientEvent('esx:showNotification', source, "Vous avez vendu 1 ~y~lingot~w~ pour 30$")
            end
        end
        end) 
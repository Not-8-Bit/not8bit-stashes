local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('holiday-stashes:server:setStashes', function()
    TriggerClientEvent('holiday-stashes:client:setStashConfig', -1, N8Stash.StorageCoords)
    SetStashes()
end)

function SetStashes()
    local stashLocations = MySQL.Sync.fetchAll('SELECT * FROM n8bstashlocations', {})
    if stashLocations[1] then
        if N8Stash.Debug == true then 
            print("Fetched stash locations from the database")
        end
        for k, v in pairs(stashLocations) do
            N8Stash.StorageCoords[v.name] = {
                name = v.name,
                label = v.label,
                key = v.key,
                useitem = v.useitem,
                activation = v.activation,
                slots = v.slots,
                weight = v.weight,
                citizenid = v.citizenid,
                job = v.job,
                gang = v.gang,
                secret = v.secret,
                coordsX = v.coordsX,
                coordsY = v.coordsY,
                coordsZ = v.coordsZ,
                stashkey = v.stashkey,
                keybitting = v.keybitting,
                usekeypad = v.usekeypad,
                pinnumber = v.pinnumber
            }
        end
    else
        if N8Stash.Debug == true then 
            print("No stashes found in the database")
        end
    end
    TriggerClientEvent("holiday-stashes:client:setStashConfig", -1, N8Stash.StorageCoords)
end

RegisterNetEvent('holiday-interactives:server:openStash', function(name, weight, slots)
    local slotCount = slots 
    local weightLimit = weight
    local stashName = name
    local src = source
    exports['qb-inventory']:OpenInventory(src, stashName, {
	    maxweight = weightLimit or 500000,
	    slots = slotCount,
    })
end)

RegisterNetEvent('holiday-stash:server:inputNewStash', function(newStashData)
    local stashcoords = newStashData.coords
    local parts = {}
	for part in stashcoords:gmatch('([^,]+)') do
	  table.insert(parts, tonumber(part))
	end
	local coords = {
	  x = parts[1] ,
	  y = parts[2] , 
	  z = parts[3] 
	}
    local sqlQuery = [[
        INSERT INTO n8bstashlocations (
        name ,
        label ,
        coordsX ,
        coordsY ,
        coordsZ ,
        activation ,
        useitem ,
        usekeypad,
        pinnumber,
        slots ,
        weight ,
        citizenid ,
        stashkey,
        keybitting,
        job ,
        gang ,
        secret 
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]]
    MySQL.insert.await(sqlQuery, {
        newStashData.name,
        newStashData.label,
        coords.x,
        coords.y,
        coords.z,
        newStashData.activation,
        newStashData.useitem,
        newStashData.usekeypad,
        newStashData.pinnumber,
        newStashData.slots,
        newStashData.weight,
        newStashData.citizenid,
        newStashData.stashkey,
        newStashData.keybitting,
        newStashData.job,
        newStashData.gang,
        newStashData.secret
    })
    Citizen.Wait(1000)
    SetStashes()
end)

QBCore.Functions.CreateCallback('holiday-interactives:server:get:keycode', function(source, cb, neededBitting)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hasItems = false
    local playerKeyBitting = nil
    local sortedItems = {}
    for _, item in pairs(Player.PlayerData.items) do
        table.insert(sortedItems, item)
    end
    table.sort(sortedItems, function(a, b)
        return tonumber(a.slot) < tonumber(b.slot)
    end)
    for _, item in ipairs(sortedItems) do
        for _, validKey in ipairs(N8Stash.StashKeyType.validKeys) do
            if item.name == validKey and item.info and item.info.bitting then
                playerKeyBitting = item.info.bitting:lower()
                if playerKeyBitting == tostring(neededBitting):lower() then
                    hasItems = true
                    break
                end
            end
        end
        if hasItems then
            break
        end
    end
    cb(hasItems, playerKeyBitting)
end)

QBCore.Commands.Add('newstash', 'Add a stash', {}, false, function(source)
	TriggerClientEvent('holiday-stashes:client:addNewStash', source)
end, N8Stash.CommandPermission)
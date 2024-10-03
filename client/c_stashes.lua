RegisterNetEvent('holiday-stashes:client:setStashConfig', function(stashConfig)
    N8Stash.StorageCoords = stashConfig
end)

Citizen.CreateThread(function()
    local idle = 1000
    while true do
        Wait(idle)
		inRange = false
		player = PlayerPedId()
		coords = GetEntityCoords(player)
		for k, v in pairs(N8Stash.StorageCoords) do
			if GetDistanceBetweenCoords(coords, v.coordsX, v.coordsY, v.coordsZ, true) < v.activation then
				inRange = true
				if v.secret then -- Not secret stashes
                    if N8Stash.Debug == true then 
                        print("The stash named: " .. v.name .. " is marked secret")
                    end
					if IsControlJustPressed(0, v.key) then
						if (v.useitem == false and v.usekeypad == false) then -- Do not use item or keypad or unlocked
                            if N8Stash.Debug == true then 
                                print("The stash named: " .. v.name .. " does not use an item")
                            end
							if (v.job == nil and v.gang == nil and v.citizenid == nil) then
								TriggerServerEvent('holiday-interactives:server:openStash', v.name, v.weight, v.slots)
                            elseif (PlayerJob.name == v.job or PlayerGang.name == v.gang or QBCore.Functions.GetPlayerData().citizenid == v.citizenid) then
								TriggerServerEvent('holiday-interactives:server:openStash', v.name, v.weight, v.slots)
							else
                                if N8Stash.AnounceFail == true then 
								    QBCore.Functions.Notify("Not authorized", 'error', 3500)
                                end
							end
                        elseif v.usekeypad == true then
                            local password = v.pinnumber
                            local stashName = v.name 
                            local stashWeight = v.weight 
                            local stashSlots = v.slots 
                            TriggerEvent('holiday-stashes:client:openKeypad', pinnumber, stashName , stashWeight , stashSlots )
                        else -- Use Item
                            QBCore.Functions.TriggerCallback('holiday-interactives:server:get:keycode', function(hasItems, playerKeyBitting)
                                if hasItems and playerKeyBitting == v.keybitting then
                                    TriggerServerEvent('holiday-interactives:server:openStash', v.name, v.weight, v.slots)
                                else
                                    if N8Stash.AnounceFail == true then 
                                        QBCore.Functions.Notify("I don't have the right key!", 'error', 3500)
                                    end
                                end
                            end, v.keybitting)
                        end
					end
				elseif not v.secret then  -- Secret Stashes
					DrawText3D(v.coordsX, v.coordsY, v.coordsZ, v.label )
					if IsControlJustPressed(0, v.key) then
						if (v.useitem == false and v.usekeypad == false) then -- Do not use item or keypad or unlocked
                            if N8Stash.Debug == true then 
                                print("The stash named: " .. v.name .. " does not use an item")
                            end
							if (v.job == nil and v.gang == nil and v.citizenid == nil) then 
								TriggerServerEvent('holiday-interactives:server:openStash', v.name, v.weight, v.slots)
                            elseif (PlayerJob.name == v.job or PlayerGang.name == v.gang or QBCore.Functions.GetPlayerData().citizenid == v.citizenid) then
								TriggerServerEvent('holiday-interactives:server:openStash', v.name, v.weight, v.slots)
							else
                                if N8Stash.AnounceFail == true then 
								    QBCore.Functions.Notify("Hmm, its locked", 'error')
                                end
							end
                        elseif v.usekeypad == true then --Use keypad.
                            local pinnumber = v.pinnumber
                            local stashName = v.name 
                            local stashWeight = v.weight 
                            local stashSlots = v.slots 
                            TriggerEvent('holiday-stashes:client:openKeypad', pinnumber, stashName , stashWeight , stashSlots )
                        else -- use Item
                            QBCore.Functions.TriggerCallback('holiday-interactives:server:get:keycode', function(hasItems, playerKeyBitting)
                                if hasItems and playerKeyBitting == v.keybitting then
                                    TriggerServerEvent('holiday-interactives:server:openStash', v.name, v.weight, v.slots)
                                else
                                    if N8Stash.AnounceFail == true then 
                                        QBCore.Functions.Notify("I don't have the right key!", 'error', 3500)
                                    end
                                end
                            end, v.keybitting)
                        end
					end
				end
			end
		end
		if inRange then
            idle = 0
        else
            idle = 1000
            inRange = false
        end
	end
end)

RegisterNetEvent('holiday-stashes:client:openKeypad')
AddEventHandler('holiday-stashes:client:openKeypad', function(pinnumber, stashName , stashWeight , stashSlots)
    local keyPin = pinnumber
    if N8Stash.Debug == true then
        if keyPin == nil then
            print("The pin number for this keypad location is nil. The keypad will not open without a programmed code in the database.")
        end
    end
    exports['holiday-keypad']:PasswordInput(keyPin, function(data)
        local password = data.input
        if data.open == true and tostring(password) == tostring(keyPin) then
            TriggerServerEvent('holiday-interactives:server:openStash', stashName , stashWeight , stashSlots)
        else
            if N8Stash.AnounceFail == true then 
                QBCore.Functions.Notify("That must not be right...", 'error', 3500)
            end
        end
    end)
end)

RegisterNetEvent('holiday-stashes:client:addNewStash', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Add a New Stash Location.",
        submitText = "Double Check Your Inputs",
        inputs = {
            { text = "The stash name"      , name = 'name'        , type = 'text'   , isRequired = true } ,
            { text = "The label"           , name = 'label'       , type = 'text'   , isRequired = true , default = "<C>~ws~</C>" } ,
            { text = "Coords"              , name = 'coords'      , type = 'text'   , isRequired = true } ,
            { text = "Activation Distance" , name = 'activation'  , type = 'text'   , isRequired = false , default = 1.5 } ,
            { text = "If item is needed"   , name = 'useitem'     , type = 'radio'  , options = { { value = 0 , text = "No" }  ,  { value = 1 , text = "Yes" } } } ,
            { text = "Item as key"         , name = 'stashkey'    , type = 'text'   , isRequired = false , default = "Item Name" } ,
            { text = "Key Bitting"         , name = 'keybitting'  , type = 'text'   , isRequired = false } ,
            { text = "Use Keypad"          , name = 'usekeypad'   , type = 'radio'  , options = {{value = 0 , text = "No"} , {value = 1 , text = "Yes" } } } ,
            { text = "Pin Number, 3-8#"    , name = 'pinnumber'   , type = 'number' , isRequired = false } ,
            { text = "Slots"               , name = 'slots'       , type = 'number' , isRequired = true , default = 25 } ,
            { text = "Weight"              , name = 'weight'      , type = 'number' , isRequired = true , default = 240000 } ,
            { text = "Owners Citizenid"    , name = 'citizenid'   , type = 'text'   , isRequired = false } ,
            { text = "Job name"            , name = 'job'         , type = 'text'   , isRequired  = false } ,
            { text = "Gang name"           , name = 'gang'        , type = 'text'   , isRequired  = false } ,
            { text = "Secret"              , name = 'secret'      , type = 'radio'  , options = { { value = 0 , text = "Visible" } , { value = 1 , text = "Secret" } } }
        }
    })
    if dialog then
        if string.len(dialog.name) <= 25 then
            if dialog.pinnumber ~= nil then 
                if (string.len(dialog.pinnumber) <= 4 and string.len(dialog.pinnumber) > 8) then
                    QBCore.Functions.Notify("Pin length is incorrect. The pin must be between 4-8 numbers", 'error')
                    return
                end
            end
            for key, value in pairs(dialog) do
                if value == '' then
                    dialog[key] = nil
                end
            end
            local newStashData = {
                name       = dialog.name,
                label      = dialog.label, 
                coords     = dialog.coords,
                activation = dialog.activation,
                useitem    = dialog.useitem,
                slots      = dialog.slots,
                weight     = dialog.weight,
                citizenid  = dialog.citizenid,
                stashkey   = dialog.stashkey,
                keybitting = dialog.keybitting,
                job        = dialog.job,
                gang       = dialog.gang,
                secret     = dialog.secret,
                usekeypad  = dialog.usekeypad,
                pinnumber  = dialog.pinnumber
            }
            TriggerServerEvent('holiday-stash:server:inputNewStash', newStashData)
        else
            QBCore.Functions.Notify("Name is too long! Must be under 25 characters and spaces combined!", 'error')
        end
    end
end)
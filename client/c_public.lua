-- Don't delete anything in here.
-- Add things if you need. But removing anything in here will break the resources functionality.
QBCore = exports['qb-core']:GetCoreObject()
-- Load player info and stashes on resource start or resource restart
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
		TriggerServerEvent("holiday-stashes:server:setStashes")
        PlayerJob = QBCore.Functions.GetPlayerData().job
		PlayerGang = QBCore.Functions.GetPlayerData().gang
    end
end)
-- Load player info and stashes when player joins to get any changes.
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	TriggerServerEvent("holiday-stashes:server:setStashes")
    PlayerJob = QBCore.Functions.GetPlayerData().job
	PlayerGang = QBCore.Functions.GetPlayerData().gang
end)
-- Load info when players job changes
RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(JobInfo)
    PlayerJob = JobInfo
end)
-- Load info when players gang changes
RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)
-- Text on screen function.
function DrawText3D(x, y, z, text) --Don't change the name
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215) --Text color
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75 ) -- rectangle color and size
    ClearDrawOrigin()
end
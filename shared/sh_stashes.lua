N8Stash = {} -- Don't change this or anything not on the right hand side of the equal (=) sign in this file.
N8Stash.StorageCoords = {} --Leave a lone

N8Stash.Debug = true --Set to true to get some debug print outs in the server console and F8.
N8Stash.CommandPermission = 'admin' --whatever you use: mod, admin, god
N8Stash.AnounceFail = true --set to true for notifications if failing to open locked stash.
-- Add as many keys as needed below. As long as you have them setup to use metadata for keybitting and they are in the items.lua
N8Stash.StashKeyType = {
    validKeys = { 'key', 'keycard' --[[, 'moreItems']] }  
}
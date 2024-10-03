# Not 8 Bit Stashes
```
Static stashes with several access type options.
Use citizenid, gangs, jobs, items with metadata, or a keypad.
Stashes can be added on the live server.
Permission locked new stash command.
```

## Discord Link
```
https://discord.gg/AeK2kzN2YE
```

## Dependencies
```
qb-core
qb-input
qb-inventory
oxmysql or similar

If you want to the keypad option.
https://github.com/Not-8-Bit/keypad
```

## Four access options
```
You can only use one option at each location. Meaning you can use an item, citizenid, job, and gang, or the keypad.
If you pick item you cannot use any other options.
If you pick the keypad you cannot use any other options.
If you pick citizenid, job or gang you cannot use an item or the keypad.
Each location is independent though. You can use an item at one location and citizenid, gang, or job at anotherm and a keypad at another location.
Access type #1
    Use any item in your items.lua with bitting metadata attached.
    NOTICE: If you do not know how to add metadata to an item, you won't be able to use this option.
Access type #2
    Use a combination of job, gang, or one players citizen id.
    NOTICE: All three can be used at the same time or independently at a location.
Access type #3
    Use not8bit-keypad to open the stashes.
    NOTICE: You must have not8bit-keypad and a valid pin in the database. If the pin is missing the keypad will not open at that location.
Access type #4
    Open to all. Do not select any job, gang, item , keypad or citizenid.
```

## Restarting the resources
```
This script can be restarted on live with minimal impact to the players.
All stashes should be undisturbed by a restart.
Players may not be able to open the stash while it is restarting.
You will see the prompt disappear and return if the stash is not secret.
```

## Items
```
key = { name = 'key', label = 'A Key to a lock' , weight = 5 , type = 'item' , image = 'key1.png' , unique =  true , useable =  true , shouldClose = true , combinable = nil , description = 'An unknown cut key.'} ,
keycard = { name = 'keycard' , label = 'A keycard to a lock' , weight = 1 , type = 'item' , image = 'keycard.png' , unique =  true , useable =  true , shouldClose =  true , combinable = nil , description = 'A keycard.'}
```

## Inventory Images
```
No inventory images provided.
Many community members make inventory images. Support them or make your own.
```

## Installation
```
Download resource
Extract resource
Put resource in your resource folder
Add items to the items.lua
Add ensure not8bit-stashes to server.cfg
Start server
Run command 'newstash' input information
Open stash and do stash things. 
```

## Database
```
Start the script.
It will insert the table n8bstashlocations on initial startup.
It will aslo populate the table with 6 default locations in and across the street from MRP. 
```

## Adding a new stash location
```
Step 1:
    Run command 'newstash'
Step 2:
    Input Information Definitions:
    "The stash name"      -- A unique name for the stash and location.
    "The label"           -- A label that players will see when approaching the stash. The default option: <C>~ws~</C> will make a white star. 
    "Coords"              -- The stash coords. EX: -105.05, 405.25, 30.43. Use that format. I usually have the coords displayed on my screen while adding stashes.
    "Activation Distance" -- The distance a player needs to be from the stash to use it or even see it.
    "If item is needed"   -- If using an item, set to YES. If not using an item, set to NO.  
    "Item as key"         -- Name of the item used if above is YES.
    "Key Bitting"         -- Bitting of the item. Can be anything really. 
    "Use Keypad"          -- Use Keypad -- MUST HAVE not8bit-keypad (free). GET IT HERE: https://github.com/Not-8-Bit/keypad
    "Pin Number"          -- PIN number. 4 - 8 numbers.
    "Slots"               -- Slots in the stash.    
    "Weight"              -- Stash weight limit.
    "Owners Citizenid"    -- The citizenid of the owner of the stash.
    "Job name"            -- Name of the job that can access the stash.
    "Gang name"           -- Name of the gang that can access the stash.
    "Secret"              -- Set to Visible to see the prompt and Secret to hide the prompt.
```
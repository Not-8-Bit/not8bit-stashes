name 'Not 8 Bit Stashes'
author 'Holiday'
version 'v1.0.0'
description "Static stashes."
fx_version 'cerulean'
lua54 'yes'
game {'gta5'}

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

dependencies {
    'qb-core',
    'qb-input',
    'qb-inventory'
}

escrow_ignore {
	'shared/sh_stashes.lua',
	'client/c_public.lua'
}
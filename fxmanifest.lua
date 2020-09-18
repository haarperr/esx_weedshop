---------------------------------------
--     ESX_WEEDSHOP by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

fx_version 'adamant'

game 'gta5'

description 'ESX WEEDSHOP'
author 'Dividerz (Arne)'

version '1.0.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'mysql-async',
	'async'
}
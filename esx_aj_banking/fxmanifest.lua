fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'esx_aj_banking'
version '1.0'
author 'AJ-Scripts'

client_scripts {
	'cl_banking.lua'
}

server_scripts  {
    'sv_banking.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'DotsDevelopment'
description 'Standalone duty logging system'
version '1.0.0'

ox_libs {
    'locale'
}

shared_scripts {
    '@ox_lib/init.lua',
    'settings.lua',
}

server_scripts {
    -- '@es_extended/imports.lua', -- Uncomment if you are using ESX
    'server/bridge/init.lua',
    'server/bridge/**/*.lua',
    'server/logging.lua',
    'server/main.lua',
}

files {
    'locales/*.json'
}

dependencies {
    'ox_lib'
}
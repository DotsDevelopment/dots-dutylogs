Settings = {
    Framework = 'esx',  -- 'auto', 'esx', 'old-esx', 'qbx', 'custom'

    -- Jobs to track for duty logging
    Jobs = {
        'police',
        'ambulance',
        'mechanic',
    },

    -- Logger: 'esx' | 'ox' | 'discord'
    -- When using 'esx': job keys above must match exactly
    -- with the keys in es_extended/server/logs.lua, or logs will not be sent.
    Logger = 'esx',

    -- ox_lib settings
    oxLogs = {
        Event = 'dutyLogs',
        Level = 'info',
    },

    -- Discord settings
    DiscordSettings = {
        Webhooks = { -- Webhook URL per job
            ['police'] = '',
            ['ambulance'] = '',
            ['mechanic'] = '',
        },
        Username = 'DutyLogs',
        AvatarUrl = '',
        Title = 'Duty Status',
        Footer = 'dots-dutylogs',
    },

    -- Log embed colors: use these to tell clock-in from clock-out at a glance
    ClockInColor = 'green',
    ClockOutColor = 'red',

    -- Color definitions for the log embeds above
    Colors = {
        ['green']     = 65280,
        ['red']       = 16711680,
        ['blue']      = 255,
        ['yellow']    = 16776960,
        ['orange']    = 15105570,
        ['purple']    = 10181046,
        ['white']     = 16777215,
        ['black']     = 0,
        ['blurple']   = 5793266,
    },
}

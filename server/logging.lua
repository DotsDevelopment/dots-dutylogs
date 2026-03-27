local function getColor(colorName)
    if type(colorName) == 'number' then return colorName end
    return Settings.Colors[colorName] or Settings.Colors['blue'] or 255
end

local function formatTime(seconds)
    if not seconds then return nil end
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format('%02d:%02d:%02d', hours, minutes, secs)
end

local function logToESX(job, message, color, fields)
    if not ESX or not ESX.DiscordLogFields then return end
    
    ESX.DiscordLogFields(job, message, color, fields)
end

local function logToOx(job, message, data)
    if not lib or not lib.logger then return end
    
    local event = Settings.oxLogs.Event .. ':' .. job
    lib.logger(event, Settings.oxLogs.Level, message, data)
end

local function logToDiscord(job, message, fields, isClockIn)
    local webhook = Settings.DiscordSettings.Webhooks[job]
    if not webhook or webhook == '' then return end
    
    local colorName = isClockIn and Settings.ClockInColor or Settings.ClockOutColor
    local color = getColor(colorName)
    
    local discordFields = {}
    for _, field in ipairs(fields) do
        table.insert(discordFields, {
            name = field.name,
            value = tostring(field.value),
            inline = field.inline
        })
    end

    local embed = {
        {
            title = Settings.DiscordSettings.Title,
            description = message,
            color = color,
            fields = discordFields,
            footer = { text = Settings.DiscordSettings.Footer },
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers)
        if err and err ~= 204 and err ~= 200 then
            print('Error for job:', job, ' - Code: ', err)
        end
    end, 'POST', json.encode({
        username = Settings.DiscordSettings.Username,
        avatar_url = Settings.DiscordSettings.AvatarUrl ~= '' and Settings.DiscordSettings.AvatarUrl or nil,
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

function SendDutyLog(source, job, onDuty, sessionTime)
    local playerName = GetPlayerName(source) or 'Unknown'
    local isClockIn = onDuty == true
    local message = isClockIn and locale('clock_in', playerName, job) or locale('clock_out', playerName, job)
    local color = isClockIn and Settings.ClockInColor or Settings.ClockOutColor
    
    local fields = {
        { name = locale('player'), value = playerName, inline = true },
        { name = locale('job'), value = job, inline = true },
        { name = locale('timestamp'), value = os.date('%Y-%m-%d %H:%M:%S'), inline = true },
    }
    
    if sessionTime then
        table.insert(fields, { 
            name = locale('total_time'), 
            value = formatTime(sessionTime), 
            inline = true 
        })
    end

    if Settings.Logger == 'esx' then
        logToESX(job, message, color, fields)
    elseif Settings.Logger == 'ox' then
        local data = {}
        for _, field in ipairs(fields) do
            data[field.name] = field.value
        end
        logToOx(job, message, data)
    elseif Settings.Logger == 'discord' then
        logToDiscord(job, message, fields, isClockIn)
    end
end

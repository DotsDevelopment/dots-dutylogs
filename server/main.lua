local function isTrackedJob(job)
    for _, trackedJob in ipairs(Settings.Jobs) do
        if trackedJob == job then
            return true
        end
    end
    return false
end

local function getPlayerName(source)
    return GetPlayerName(source) or 'Unknown'
end

local function getPlayerIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license') or 'unknown'
end

function UpdateDutyStatus(src, job, onDuty)
    local source = tonumber(src)
    if not source or source <= 0 then return false end
    if not isTrackedJob(job) then return false end

    local player = Player(source)
    if not player then return false end

    local currentState = player.state.duty
    local playerName = getPlayerName(source)
    local identifier = getPlayerIdentifier(source)

    if currentState and currentState.onDuty == onDuty and currentState.job == job then return false end

    local now = os.time()
    local sessionTime = nil

    if not onDuty and currentState and currentState.onDuty and currentState.since then
        sessionTime = now - currentState.since
    end

    player.state:set('duty', {
        job = job,
        onDuty = onDuty,
        since = onDuty and now or nil,
    }, true)

    SendDutyLog(source, job, onDuty, sessionTime)

    return true
end

AddEventHandler('playerDropped', function(reason)
    local source = source
    local player = Player(source)
    if not player then return end
    
    local dutyState = player.state.duty
    if not dutyState or not dutyState.job then return end

    local sessionTime = nil
    if dutyState.since then
        sessionTime = os.time() - dutyState.since
    end
    
    SendDutyLog(source, dutyState.job, false, sessionTime)
end)

exports('updateDutyStatus', UpdateDutyStatus)

exports('getDuty', function(source)
    source = tonumber(source)
    if not source then return nil, nil end
    
    local player = Player(source)
    if not player or not player.state.duty then return nil, nil end
    
    local duty = player.state.duty
    return duty.onDuty == true, duty
end)

if GetFramework() ~= 'old-esx' then return end

local function getBaseJob(jobName)
    if jobName:sub(1, 3) == 'off' then
        return jobName:sub(4), false
    else
        return jobName, true
    end
end

local function isTrackedJobOrOffVariant(jobName)
    local baseJob, _ = getBaseJob(jobName)
    
    for _, trackedJob in ipairs(Settings.Jobs) do
        if trackedJob == baseJob then
            return true, baseJob
        end
    end
    return false, nil
end

RegisterNetEvent('esx:setJob', function(source, job, lastJob)
    if not source or source <= 0 then return end
    if not job or not job.name then return end
    
    local isTracked, baseJob = isTrackedJobOrOffVariant(job.name)
    if not isTracked then return end
    
    local _, onDuty = getBaseJob(job.name)
    
    UpdateDutyStatus(source, baseJob, onDuty)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    if not xPlayer or not xPlayer.job then return end
    
    local isTracked, baseJob = isTrackedJobOrOffVariant(xPlayer.job.name)
    if not isTracked then return end
    
    local _, onDuty = getBaseJob(xPlayer.job.name)
    
    UpdateDutyStatus(playerId, baseJob, onDuty)
end)

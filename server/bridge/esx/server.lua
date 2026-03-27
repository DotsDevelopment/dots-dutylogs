if GetFramework() ~= 'esx' then return end

RegisterNetEvent('esx:setDuty', function(source, job, onDuty)
    if not source or source <= 0 then return end
    UpdateDutyStatus(source, job, onDuty)
end)

RegisterNetEvent('esx:playerLoaded', function(playerId, xPlayer)
    if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.onDuty ~= nil then
        UpdateDutyStatus(playerId, xPlayer.job.name, xPlayer.job.onDuty)
    end
end)

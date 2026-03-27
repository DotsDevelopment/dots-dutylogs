if GetFramework() ~= 'qbx' then return end

RegisterNetEvent('QBX:Server:OnJobUpdate', function(source, job)
    if not source or source <= 0 then return end
    if not job or not job.name then return end
    
    local onDuty = job.onduty or job.onDuty or false
    
    UpdateDutyStatus(source, job.name, onDuty)
end)

RegisterNetEvent('QBX:Server:SetDuty', function(source, onDuty)
    if not source or source <= 0 then return end
    
    local Player = exports.qbx_core:GetPlayer(source)
    if not Player or not Player.PlayerData or not Player.PlayerData.job then return end
    
    local job = Player.PlayerData.job.name
    
    UpdateDutyStatus(source, job, onDuty)
end)

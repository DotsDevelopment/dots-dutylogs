if GetFramework() ~= 'qbcore' then return end

RegisterNetEvent('qbx_core:server:onJobUpdate', function(source, job)
    if not source or source <= 0 then return end
    if not job or not job.name then return end
    
    local onDuty = job.onduty or job.onDuty or false
    
    UpdateDutyStatus(source, job.name, onDuty)
end)
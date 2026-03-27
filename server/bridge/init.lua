function GetFramework()
    if GetResourceState('es_extended') == 'started' and Settings.Framework == 'auto' or Settings.Framework == 'esx' then
        return 'esx'
    elseif GetResourceState('es_extended') == 'started' and Settings.Framework == 'auto' or Settings.Framework == 'old-esx' then
        return 'old-esx'
    elseif GetResourceState('qbx_core') == 'started' and Settings.Framework == 'auto' or Settings.Framework == 'qbx' then
        return 'qbx'
    elseif GetResourceState('qb-core') == 'started' and Settings.Framework == 'auto' or Settings.Framework == 'qbcore' then
        return 'qbcore'
    elseif Settings.Framework == 'custom' then
        return 'custom'
    end
    return
end

function Notify(msg, type, length)
    print('[' .. type:upper() .. '] ' .. msg)
end

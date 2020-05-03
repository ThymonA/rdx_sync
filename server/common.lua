RDX     = nil
Sync    = {
    LastWeatherChange = Config.TimeBetweenWeatherChanges * 600
}

if (exports and exports['redm_extended']) then
    RDX = exports['redm_extended']:getSharedObject()
else
    TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)
end
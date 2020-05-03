Citizen.CreateThread(function()
    local hour = (Config.ServerStartTime or {}).hour or 9
    local minute = (Config.ServerStartTime or {}).minute or 0

    Sync.Time.setHours(hour)
    Sync.Time.setMinutes(minute)
    Sync.Time.syncTime()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)

        if (((Sync.LastWeatherChange or 0) / 1000) >= (Config.TimeBetweenWeatherChanges * 600)) then
            Sync.Weather.randomWeatherTransitions()
        else
            Sync.LastWeatherChange = Sync.LastWeatherChange + 10000
        end

        Sync.Time.addSeconds(10)
        Sync.Time.syncTime()
        Sync.Weather.syncWeather()
    end
end)

RDX.RegisterCommand('time', 'admin', function(xPlayer, args, showError)
    args.hour = RDX.Math.Round(args.hour, 0)
    args.minute = RDX.Math.Round(args.minute, 0)

    if (args.hour < 0 or args.hour > 23) then
        showError(_U('command_error_hour'))
        return
    elseif (args.minute < 0 or args.minute > 59) then
        showError(_U('command_error_minute'))
        return
    end

    Sync.Time.setHours(args.hour)
    Sync.Time.setMinutes(args.minute)
    Sync.Time.syncTime()
end, true, {help = _U('command_time'), validate = true, arguments = {
    {name = 'hour', help = _U('command_time_hour'), type = 'number'},
    {name = 'minute', help = _U('command_time_minute'), type = 'number'}
}})

RDX.RegisterCommand('weather', 'admin', function(xPlayer, args, showError)
    args.type = string.upper(args.type or 'WEATHER_UNKNOWN')

    if (not Sync.Weather.weatherTypeExists(args.type) and not  Sync.Weather.weatherTypeExists(('WEATHER_%s'):format(args.type))) then
        showError(_U('command_error_weather'))
        return
    end

    Sync.Weather.changeWeatherType(args.type)
    Sync.Weather.syncWeather()
end, true, {help = _U('command_weather'), validate = true, arguments = {
    {name = 'type', help = _U('command_weather_type'), type = 'string'}
}})

AddEventHandler('rdx:playerLoaded', function(source)
    Sync.Time.syncTime(source)
    Sync.Weather.syncWeather(source)
end)
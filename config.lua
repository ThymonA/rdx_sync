Config          = {}
Config.Locale   = 'en'

-------
-- Time
-------

-- Set a default server time when server is started
Config.ServerStartTime = {
    hour    = 09,   -- between 0 and 23
    minute  = 00    -- between 0 and 59
}

-------
-- Weather
-------

-- Make weather dynamic, default `true`
Config.DynamicWeatherChanges = true

-- Time between dynamic changes, default 10 mins
Config.TimeBetweenWeatherChanges = 10

-- Max wind speed
Config.MaxWindSpeed = 10.0
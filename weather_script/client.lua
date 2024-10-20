local currentWeather = "CLEAR"
local newWeather = "CLEAR"
local transitionTime = Config.TransitionTime 

RegisterNetEvent('updateWeatherAndTime')
AddEventHandler('updateWeatherAndTime', function(weather, hour, minute, second)
    if Config.Debug then
        print("Empfangene Wetterdaten: " .. weather)
        print("Empfangene Zeitdaten: " .. hour .. ":" .. minute .. ":" .. second)
    end

    if weather == "Clear" then
        newWeather = "CLEAR"
    elseif weather == "Clouds" then
        newWeather = "CLOUDS"
    elseif weather == "Rain" then
        newWeather = "RAIN"
    elseif weather == "Snow" then
        newWeather = "SNOW"
    elseif weather == "Fog" then
        newWeather = "FOGGY"
    elseif weather == "Thunderstorm" then
        newWeather = "THUNDER"
    elseif weather == "Drizzle" then
        newWeather = "SMOG"
    elseif weather == "Mist" then
        newWeather = "FOGGY"
    elseif weather == "Haze" then
        newWeather = "SMOG"
    elseif weather == "Smoke" then
        newWeather = "SMOG"
    else
        newWeather = "CLEAR"
    end

    SetWeatherTypeOverTime(newWeather, transitionTime)
    currentWeather = newWeather

    NetworkOverrideClockTime(hour, minute, second)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetWeatherTypePersist(currentWeather)
        SetWeatherTypeNowPersist(currentWeather)
        SetWeatherTypeNow(currentWeather)
    end
end)
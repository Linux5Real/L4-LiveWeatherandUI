local currentWeather = "CLEAR"
local newWeather = "CLEAR"
local transitionTime = Config.TransitionTime 
local transitionStart = false
local transitionProgress = 0.0

RegisterNetEvent('updateWeatherAndWind')
AddEventHandler('updateWeatherAndWind', function(weather, windSpeed, windDirection)
    if Config.Debug then
        print("Empfangene Wetterdaten: " .. weather)
        print("Empfangene Windgeschwindigkeit: " .. windSpeed)
        print("Empfangene Windrichtung: " .. windDirection)
    end

    -- Mapping der Wettertypen
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

    -- Überprüfen, ob das neue Wetter anders ist als das aktuelle Wetter
    if currentWeather ~= newWeather then
        if Config.Debug then
          print("Wetterwechsel von " .. currentWeather .. " zu " .. newWeather .. " in " .. transitionTime .. " Sekunden.")
        end
        transitionStart = true
        transitionProgress = 0.0
        lastWeather = currentWeather -- Hier wird die lastWeather-Variable aktualisiert
      end

    -- Windgeschwindigkeit und -richtung aktualisieren
    SetWindSpeed(windSpeed)
    SetWindDirection(windDirection)
end)

RegisterNetEvent('updateTime')
AddEventHandler('updateTime', function(hour, minute, second)
    NetworkOverrideClockTime(hour, minute, second)
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
      if transitionStart then
        transitionProgress = transitionProgress + (1.0 / transitionTime)
        if transitionProgress >= 1.0 then
          transitionProgress = 1.0
          transitionStart = false
          currentWeather = newWeather
        end
        local weatherType = GetHashKey(currentWeather)
        local newWeatherType = GetHashKey(newWeather)
        local transitionType = GetWeatherTransitionType(weatherType, newWeatherType)
        SetWeatherTypeTransition(weatherType, newWeatherType, transitionProgress * transitionType)
      else
        if lastWeather ~= currentWeather then -- Hier wird überprüft, ob ein Wetterwechsel stattgefunden hat
          transitionStart = true
          transitionProgress = 0.0
        end
        SetWeatherTypePersist(currentWeather)
        SetWeatherTypeNowPersist(currentWeather)
        SetWeatherTypeNow(currentWeather)
      end
    end
  end)

  function GetWeatherTransitionType(weatherType, newWeatherType)
  if weatherType == GetHashKey("CLEAR") and newWeatherType == GetHashKey("CLOUDS") then
    return 0.1 -- Übergang von klar zu bewölkt
  elseif weatherType == GetHashKey("CLOUDS") and newWeatherType == GetHashKey("RAIN") then
    return 0.2 -- Übergang von bewölkt zu regnerisch
  elseif weatherType == GetHashKey("RAIN") and newWeatherType == GetHashKey("SNOW") then
    return 0.3 -- Übergang von regnerisch zu schneereich
  -- ...
  else
    return 0.1 -- Standard-Übergang
  end
end
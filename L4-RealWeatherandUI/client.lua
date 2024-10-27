Config = Config or {}
local configFile = LoadResourceFile(GetCurrentResourceName(), "config.lua")
assert(load(configFile))()

local currentWeather = "OVERCAST"
local newWeather = "OVERCAST"
local time = {hours = 12, minutes = 0, seconds = 0}
local transitionTime = 240
local isDragging = false
local originalPosition = {left = "0px", top = "0px"}

RegisterNetEvent('updateWeatherAndWind')
AddEventHandler('updateWeatherAndWind', function(weather, windSpeed, windDirection)
    if Config.Debug then
        print("Empfangene Wetterdaten: " .. weather)
        print("Empfangene Windgeschwindigkeit: " .. windSpeed)
        print("Empfangene Windrichtung: " .. windDirection)
    end
    if weather == "Clear" then
        newWeather = "CLEAR"
    elseif weather == "Extrasunny" then
        newWeather = "EXTRASUNNY"
    elseif weather == "Clouds" then
        newWeather = "CLOUDS"
    elseif weather == "Overcast" then
        newWeather = "OVERCAST"
    elseif weather == "Rain" then
        newWeather = "RAIN"
    elseif weather == "Clearing" then
        newWeather = "CLEARING"
    elseif weather == "Thunder" then
        newWeather = "THUNDER"
    elseif weather == "Smog" then
        newWeather = "SMOG"
    elseif weather == "Foggy" then
        newWeather = "FOGGY"
    elseif weather == "Xmas" then
        newWeather = "XMAS"
    elseif weather == "Snowlight" then
        newWeather = "SNOWLIGHT"
    elseif weather == "Blizzard" then
        newWeather = "BLIZZARD"
    elseif weather == "Snow" then
        newWeather = "SNOW"
    elseif weather == "Halloween" then
        newWeather = "HALLOWEEN"
    else
        newWeather = "CLEAR"
    end

    SetWindSpeed(windSpeed)
    SetWindDirection(windDirection)
end)

local function setWeather(weather)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(weather)
    SetWeatherTypeNow(weather)
    SetWeatherTypeNowPersist(weather)
end

CreateThread(function()
    setWeather("OVERCAST")

    while true do
        if currentWeather ~= newWeather then
            if Config.Debug then
                print("Wetterwechsel von " .. currentWeather .. " zu " .. newWeather .. " in " .. transitionTime .. " Sekunden.")
              end
            currentWeather = newWeather

            SetWeatherTypeOvertimePersist(currentWeather, 240.0)

            Wait((transitionTime / 4) * 1000)
        end

        setWeather(currentWeather)

        Wait(1000)
    end
end)

RegisterNetEvent('updateTime')
AddEventHandler('updateTime', function(hour, minute, second)
    time.hours = hour
    time.minutes = minute
    time.seconds = second    
end)

RegisterNetEvent('setUIPosition')
AddEventHandler('setUIPosition', function(position)
    SendNUIMessage({
        action = 'setPosition',
        left = position.left,
        top = position.top
    })
end)

CreateThread(function()
    while true do
        NetworkOverrideClockTime(time.hours, time.minutes, time.seconds)

    if Config.RealisticDensity then
        if time.hours >= 0 and time.hours < 6 then

            SetPedDensityMultiplierThisFrame(0.1)
            SetVehicleDensityMultiplierThisFrame(0.2)
            SetRandomVehicleDensityMultiplierThisFrame(0.2)
            SetParkedVehicleDensityMultiplierThisFrame(0.5)
            SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1)
        elseif time.hours >= 6 and time.hours < 9 then

            SetPedDensityMultiplierThisFrame(0.5)
            SetVehicleDensityMultiplierThisFrame(0.5)
            SetRandomVehicleDensityMultiplierThisFrame(0.5)
            SetParkedVehicleDensityMultiplierThisFrame(0.5)
            SetScenarioPedDensityMultiplierThisFrame(0.5, 0.5)
        elseif time.hours >= 9 and time.hours < 17 then

            SetPedDensityMultiplierThisFrame(1.0)
            SetVehicleDensityMultiplierThisFrame(1.0)
            SetRandomVehicleDensityMultiplierThisFrame(1.0)
            SetParkedVehicleDensityMultiplierThisFrame(1.0)
            SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
        elseif time.hours >= 17 and time.hours < 20 then

            SetPedDensityMultiplierThisFrame(0.7)
            SetVehicleDensityMultiplierThisFrame(0.7)
            SetRandomVehicleDensityMultiplierThisFrame(0.7)
            SetParkedVehicleDensityMultiplierThisFrame(0.7)
            SetScenarioPedDensityMultiplierThisFrame(0.7, 0.7)
        else

            SetPedDensityMultiplierThisFrame(0.3)
            SetVehicleDensityMultiplierThisFrame(0.3)
            SetRandomVehicleDensityMultiplierThisFrame(0.3)
            SetParkedVehicleDensityMultiplierThisFrame(0.3)
            SetScenarioPedDensityMultiplierThisFrame(0.3, 0.3)
        end
    end

        Wait(0)
    end
end)

RegisterCommand('time', function()
    local hours = time.hours
    local minutes = time.minutes
    local seconds = time.seconds
    TriggerEvent('chat:addMessage', {
        color = { 255, 255, 255},
        multiline = true,
        args = {"Serverzeit", string.format("Aktuelle Serverzeit: %02d:%02d:%02d", hours, minutes, seconds)}
    })
end, false)

RegisterCommand('moveui', function()
    if Config.DraggableUI then
          TriggerEvent('esx:showNotification', "UI verschieben aktiviert. Drücke Enter, um zu speichern, oder Esc, um abzubrechen.")
          SetNuiFocus(true, true)
          SendNUIMessage({
              action = "enableDrag"
          })
    end
end, false)

RegisterNUICallback('savePosition', function(data, cb)
    TriggerServerEvent('saveUIPosition', data.left, data.top)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('nuiFocusOff', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('setOriginalPosition', function(data, cb)
    originalPosition.left = data.left
    originalPosition.top = data.top
    cb('ok')
end)

RegisterNUICallback('resetPosition', function(data, cb)
    SendNUIMessage({
        action = 'setPosition',
        left = originalPosition.left,
        top = originalPosition.top
    })
    SetNuiFocus(false, false)
    cb('ok')
end)

CreateThread(function()
    while true do
        local currentDate = GetCurrentDate()
        if Config.ShowUI then
            SendNUIMessage({
                action = 'updateUI',
                showCity = Config.ShowCity,
                city = Config.City,
                showTime = Config.ShowTime,
                time = string.format("%02d:%02d", time.hours, time.minutes),
                showDate = Config.ShowDate,
                date = currentDate,
                showWeather = Config.ShowWeather,
                weather = Config.WeatherTranslations[currentWeather] or currentWeather,
                draggable = Config.DraggableUI,
                uiPosition = Config.UIPosition
            })
        else
            SendNUIMessage({
                action = 'hideUI'
            })
        end
        Wait(1000)
    end
end)

function GetCurrentDate()
    local year, month, day = GetLocalTime()
    return string.format("%02d.%02d.%04d", day, month, year)
end

RegisterNetEvent('updateBlackoutSettings')
AddEventHandler('updateBlackoutSettings', function(fullBlackout)
    if (fullBlackout) then
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(true)
    else
        SetArtificialLightsState(false)
        SetArtificialLightsStateAffectsVehicles(false)
    end
end)

RegisterCommand('adminweatherui', function()
    TriggerServerEvent('checkAdminPermission')
end, false)

RegisterNetEvent('openAdminUI')
AddEventHandler('openAdminUI', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'showAdminUI'
    })
end)

RegisterNetEvent('noPermission')
AddEventHandler('noPermission', function()
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"System", "Du hast keine Berechtigung, diesen Befehl auszuführen."}
    })
end)

RegisterNUICallback('closeAdminUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('updateBlackout', function(data, cb)
    TriggerServerEvent('saveBlackoutSettings', data.fullBlackout)
    cb('ok')
end)
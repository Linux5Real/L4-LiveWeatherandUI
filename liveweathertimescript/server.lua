local apiKey = Config.ApiKey
local city = Config.City
local url = "http://api.openweathermap.org/data/2.5/weather?q=" .. city .. "&appid=" .. apiKey .. "&units=metric"

local lastWeather = nil
local lastUpdateTime = 0
local isTransitioning = false

function getWeather()
    if Config.Debug then
        print("Abrufen der Wetterdaten von: " .. url)
    end

    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local weatherData = json.decode(response)
            local weather = weatherData.weather[1].main
            local windSpeed = weatherData.wind.speed
            local windDirection = weatherData.wind.deg

            if weather ~= lastWeather and not isTransitioning then
                lastWeather = weather
                lastUpdateTime = os.time()
                isTransitioning = true
                if Config.Debug then
                    print("Wetterwechsel erkannt. Senden der neuen Wetterdaten an die Clients.")
                end
                TriggerClientEvent('updateWeatherAndWind', -1, weather, windSpeed, windDirection)
                Citizen.SetTimeout(Config.TransitionTime * 1000, function()
                    isTransitioning = false
                end)
            else
                if Config.Debug then
                    print("Kein Wetterwechsel erkannt oder Übergang läuft noch.")
                end
            end
        else
            print("Fehler beim Abrufen der Wetterdaten: " .. statusCode)
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end

function updateTime()
    local time = os.date("*t")
    TriggerClientEvent('updateTime', -1, time.hour, time.min, time.sec)
end

Citizen.CreateThread(function()
    while true do
        getWeather()
        Citizen.Wait(Config.UpdateInterval)
        if Config.Debug then
            print("Update-Intervall erreicht. API wird erneut abgefragt.")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        updateTime()
        Citizen.Wait(1000) -- Aktualisiere die Zeit jede Sekunde
    end
end)
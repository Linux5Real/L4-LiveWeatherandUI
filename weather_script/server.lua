local apiKey = Config.ApiKey
local city = Config.City
local url = "http://api.openweathermap.org/data/2.5/weather?q=" .. city .. "&appid=" .. apiKey .. "&units=metric"

function getWeather()
    if Config.Debug then
        print("Abrufen der Wetterdaten von: " .. url)
    end

    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local weatherData = json.decode(response)
            local weather = weatherData.weather[1].main
            local temp = weatherData.main.temp
            local time = os.date("!*t", weatherData.dt + weatherData.timezone)

            if Config.Debug then
                print("Wetterdaten abgerufen: " .. response)
                print("Wetter: " .. weather)
                print("Temperatur: " .. temp)
                print("Zeit: " .. time.hour .. ":" .. time.min .. ":" .. time.sec)
            end

            TriggerClientEvent('updateWeatherAndTime', -1, weather, time.hour, time.min, time.sec)
        else
            print("Fehler beim Abrufen der Wetterdaten: " .. statusCode)
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end

Citizen.CreateThread(function()
    while true do
        if Config.Debug then
            print("Aktualisiere Wetterdaten...")
        end
        getWeather()
        Citizen.Wait(Config.UpdateInterval) 
    end
end)
Config = {}
--Change API and City here if you need help read the README
Config.ApiKey = "YOUR-API-KEY" -- your API key from openweathermap.org 
Config.City = "Berlin" -- https://openweathermap.org Search your city and copy the name here 

-- Change AllowedPlayers here if you need help read the README
Config.AllowedPlayers = {
    "license:abcdef1234567890abcdef1234567890abcdef12", -- Change me
    "license:abcdef1234567890abcdef1234567890abcdef12"  -- Change me
}


-- Change UpdateInterval and TransitionTime here if you need help read the README. 
-- The settings are still in beta, please do not change them unless you have knowledge about it.

Config.UpdateInterval = 360000 -- 5 minutes in milliseconds (Beta)

-- Realistic NPC Spawning-Density
Config.RealisticDensity = true -- true/false

-- UI Configures
Config.ShowCity = true-- Show the city in the WeatherUI
Config.ShowTime = true -- Show the time in the WeatherUI
Config.ShowWeather = true -- Show the weather in the WeatherUI
Config.ShowDate = true -- Show the date in the WeatherUI
Config.ShowUI = true -- Show the WeatherUI in the game
Config.UIPosition = 'top-left' -- Position des UI: 'top-left', 'top-right','center', 'bottom-left', 'bottom-center', 'bottom-right'
Config.DraggableUI = true -- Enable/Disable draggable UI command is '/moveui' 

-- Debug-Mode (true/false) 
Config.Debug = false

-- Translations for Weather-Types 
Config.WeatherTranslations = {
    ["CLEAR"] = "Klar",
    ["EXTRASUNNY"] = "Sonnig",
    ["CLOUDS"] = "Bewölkt",
    ["OVERCAST"] = "Stark bewölkt",
    ["RAIN"] = "Regen",
    ["CLEARING"] = "Bewölkt",
    ["THUNDER"] = "Gewitter",
    ["SMOG"] = "Smog",
    ["FOGGY"] = "Nebelig",
    ["XMAS"] = "Schnee",
    ["SNOWLIGHT"] = "Leichter Schnee",
    ["BLIZZARD"] = "Schneesturm",
    ["SNOW"] = "Schnee",
    ["HALLOWEEN"] = "Halloween"
}

-- English Translations (Uncomment to use)
--[[
Config.WeatherTranslations = {
    ["CLEAR"] = "Clear",
    ["EXTRASUNNY"] = "Extra Sunny",
    ["CLOUDS"] = "Clouds",
    ["OVERCAST"] = "Overcast",
    ["RAIN"] = "Rain",
    ["CLEARING"] = "Clearing",
    ["THUNDER"] = "Thunder",
    ["SMOG"] = "Smog",
    ["FOGGY"] = "Foggy",
    ["XMAS"] = "Snow",
    ["SNOWLIGHT"] = "Light Snow",
    ["BLIZZARD"] = "Blizzard",
    ["SNOW"] = "Snow",
    ["HALLOWEEN"] = "Halloween"
}
]]

-- French Translations (Uncomment to use)
--[[
Config.WeatherTranslations = {
    ["CLEAR"] = "Clair",
    ["EXTRASUNNY"] = "Très ensoleillé",
    ["CLOUDS"] = "Nuages",
    ["OVERCAST"] = "Couvert",
    ["RAIN"] = "Pluie",
    ["CLEARING"] = "Dégagé",
    ["THUNDER"] = "Orage",
    ["SMOG"] = "Smog",
    ["FOGGY"] = "Brumeux",
    ["XMAS"] = "Neige",
    ["SNOWLIGHT"] = "Neige légère",
    ["BLIZZARD"] = "Blizzard",
    ["SNOW"] = "Neige",
    ["HALLOWEEN"] = "Halloween"
}
]]

-- Spanish Translations (Uncomment to use)
--[[
Config.WeatherTranslations = {
    ["CLEAR"] = "Despejado",
    ["EXTRASUNNY"] = "Muy soleado",
    ["CLOUDS"] = "Nublado",
    ["OVERCAST"] = "Muy nublado",
    ["RAIN"] = "Lluvia",
    ["CLEARING"] = "Despejando",
    ["THUNDER"] = "Tormenta",
    ["SMOG"] = "Smog",
    ["FOGGY"] = "Nebuloso",
    ["XMAS"] = "Nieve",
    ["SNOWLIGHT"] = "Nieve ligera",
    ["BLIZZARD"] = "Ventisca",
    ["SNOW"] = "Nieve",
    ["HALLOWEEN"] = "Halloween"
}
]]

-- Dutch Translations (Uncomment to use)
--[[
Config.WeatherTranslations = {
    ["CLEAR"] = "Helder",
    ["EXTRASUNNY"] = "Zonnig",
    ["CLOUDS"] = "Bewolkt",
    ["OVERCAST"] = "Zwaar bewolkt",
    ["RAIN"] = "Regen",
    ["CLEARING"] = "Opklarend",
    ["THUNDER"] = "Onweer",
    ["SMOG"] = "Smog",
    ["FOGGY"] = "Mistig",
    ["XMAS"] = "Sneeuw",
    ["SNOWLIGHT"] = "Lichte sneeuw",
    ["BLIZZARD"] = "Sneeuwstorm",
    ["SNOW"] = "Sneeuw",
    ["HALLOWEEN"] = "Halloween"
}
]]

-- Polish Translations (Uncomment to use)
--[[
Config.WeatherTranslations = {
    ["CLEAR"] = "Czyste",
    ["EXTRASUNNY"] = "Bardzo słonecznie",
    ["CLOUDS"] = "Chmury",
    ["OVERCAST"] = "Zachmurzenie",
    ["RAIN"] = "Deszcz",
    ["CLEARING"] = "Przejaśnienia",
    ["THUNDER"] = "Burza",
    ["SMOG"] = "Smog",
    ["FOGGY"] = "Mglisto",
    ["XMAS"] = "Śnieg",
    ["SNOWLIGHT"] = "Lekki śnieg",
    ["BLIZZARD"] = "Zamieć",
    ["SNOW"] = "Śnieg",
    ["HALLOWEEN"] = "Halloween"
}
]]
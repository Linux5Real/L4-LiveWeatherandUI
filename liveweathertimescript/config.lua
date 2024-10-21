Config = {}
--Change API and City here if you need help read the README
Config.ApiKey = "YourAPIKey" -- your API key from openweathermap.org 
Config.City = "Hamburg" -- https://openweathermap.org Search your city and copy thhe name here 

-- Change UpdateInterval and TransitionTime here if you need help read the README. 
-- The settings are still in beta, please do not change them unless you have knowledge about it.

Config.UpdateInterval = 10000 -- 10 Seconds in milliseconds (Beta)
Config.TransitionTime = 60 -- Transition Time in seconds (Beta)

Config.Debug = false -- Debug-Mode true/false
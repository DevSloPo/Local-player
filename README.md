# Roblox China Script XK Hub
## Script

```lua

local scriptUrl = "https://github.com/DevSloPo/Local-player/raw/main/player.luau"
local success, response = pcall(function()
    local scriptContent = game:HttpGet(scriptUrl, true)
    return loadstring(scriptContent)()
end)
if not success then
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end

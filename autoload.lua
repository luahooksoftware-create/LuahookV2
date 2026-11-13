-- Check if we already loaded it to prevent an infinite loop
if _G.LuahookRemoteLoaded then
    return 
end

_G.LuahookRemoteLoaded = true

warn('[autoload] Fetching LuahookV2.lua from GitHub...')

local url = "https://raw.githubusercontent.com/luahooksoftware-create/LuahookV2/refs/heads/main/LuahookV2.lua"

local ok, body = pcall(function()
    return game:HttpGet(url)
end)

if not ok or type(body) ~= 'string' or #body == 0 then
    warn('[autoload] Failed to download LuahookV2.lua')
    _G.LuahookRemoteLoaded = nil -- Reset so you can try again
    return
end

-- Compile and run the fetched script
local chunk, err = loadstring(body, "=LuahookV2_Remote")

if not chunk then
    warn('[autoload] Failed to compile LuahookV2.lua: ' .. tostring(err))
    _G.LuahookRemoteLoaded = nil
    return
end

-- Execute it
local success, runErr = pcall(chunk)

if not success then
    warn('[autoload] LuahookV2.lua errored while running: ' .. tostring(runErr))
    _G.LuahookRemoteLoaded = nil
else
    warn('[autoload] Successfully loaded LuahookV2 from GitHub!')
end

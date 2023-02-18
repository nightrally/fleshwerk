local TINY = "Tiny"
local SMALL = "Small"
local MEDIUM = "Medium"
local LARGE = "Large"
local EXTRALARGE = "Extra Large"
local DYNAMIC = "Dynamic"
local SURVIVAL = "Zombie Survival"
local OBJECTIVE = "Zombie Survival Objective"
local ESCAPE = "Zombie Escape"

local MapDownloads = {
    -- Map Pack #1
    ["zs_cabin_v4"] = "2914179636",
    ["zs_fortress"] = "2914179636",
    ["zs_lambdacore_nzs"] = "2914179636",
    ["zs_obj_6_nights_v8"] = "2914179636",
    ["zs_onett_v6"] = "2914179636",
    ["zs_zombiebridge"] = "2914179636",

    -- Map Pack #2
    ["ze_ffvii_mako_reactor_v5_4e1"] = "2920072704",
    ["zs_brick_trick_v3"] = "2920072704",
    ["zs_cadingpractice"] = "2920072704",
    ["zs_flatgrass"] = "2920072704",
    ["zs_longhallway"] = "2920072704",
    ["zs_red_room_v2"] = "2920072704",

    -- Map Pack #3
    ["zs_abandoned_mall_v6b"] = "2933081022",
    ["zs_alexg_metro_v4a"] = "2933081022",
    ["zs_nicorooms_v1"] = "2933081022",
    ["zs_obj_827_to_phoenix_v8"] = "2933081022",
    ["zs_pyongyang_v1sf"] = "2933081022",
    ["zs_trainstation"] = "2933081022",
}

local serverMaps = {
    "gm_construct",

    -- Map Pack #1
    "zs_cabin_v4",
    --"zs_fortress",
    "zs_lambdacore_nzs",
    --"zs_obj_6_nights_v8",
    --"zs_onett_v6",
    --"zs_zombiebridge",

    -- Map Pack #2
    "ze_ffvii_mako_reactor_v5_4e1",
    --"zs_brick_trick_v3",
    --"zs_cadingpractice",
    "zs_flatgrass",
    "zs_longhallway",
    --"zs_red_room_v2",

    -- Map Pack #3
    "zs_abandoned_mall_v6b",
    --"zs_alexg_metro_v4a",
    --"zs_nicorooms_v1",
    --"zs_obj_827_to_phoenix_v8",
    --"zs_pyongyang_v1sf",
    --"zs_trainstation",
}

local navmeshedMaps = {
    ["gm_construct"] = {Name = "GM Construct", Size = EXTRALARGE, Type = SURVIVAL},

    -- Map Pack #1
    ["zs_cabin_v4"] = {Name = "Cabin V4", Size = SMALL, Type = SURVIVAL},
    ["zs_fortress"] = {Name = "Fortress", Size = MEDIUM, Type = SURVIVAL},
    ["zs_obj_6_nights_v8"] = {Name = "6 Nights V8", Size = DYNAMIC, Type = OBJECTIVE},
    ["zs_lambdacore_nzs_v2"] = {Name = "Lambdacore nZS", Size = MEDIUM, Type = SURVIVAL},
    ["zs_onett_v6"] = {Name = "Onett V6", Size = LARGE, Type = SURVIVAL},
    ["zs_zombiebridge"] = {Name = "Zombie Bridge", Size = LARGE, Type = SURVIVAL},

    -- Map Pack #2
    ["ze_ffvii_mako_reactor_v5_4e1"] = {Name = "Mako Reactor V5 4E1", Size = LARGE, Type = ESCAPE},
    ["zs_brick_trick_v3"] = {Name = "Brick Trick V3", Size = SMALL, Type = SURVIVAL},
    ["zs_cadingpractice"] = {Name = "Cading Practice", Size = TINY, Type = SURVIVAL},
    ["zs_flatgrass"] = {Name = "ZS Flatgrass", Size = TINY, Type = SURVIVAL},
    ["zs_longhallway"] = {Name = "Long Hallway", Size = SMALL, Type = SURVIVAL},
    ["zs_red_room_v2"] = {Name = "Red Room V2", Size = SMALL, Type = SURVIVAL},

    -- Map Pack #3
    ["zs_abandoned_mall_v6b"] = {Name = "Abandoned Mall V6B", Size = EXTRALARGE, Type = SURVIVAL},
    ["zs_alexg_metro_v4a"] = {Name = "AlexG Metro V4A", Size = SMALL, Type = SURVIVAL},
    ["zs_nicorooms_v1"] = {Name = "Nicorooms V1", Size = TINY, Type = SURVIVAL},
    ["zs_obj_827_to_phoenix_v8"] = {Name = "To Phoenix V8", Size = DYNAMIC, Type = OBJECTIVE},
    ["zs_pyongyang_v1sf"] = {Name = "Pyongyang V1SF", Size = MEDIUM, Type = SURVIVAL},
    ["zs_trainstation"] = {Name = "Trainstation", Size = MEDIUM, Type = SURVIVAL},
}

local col = Color(255, 255, 255)
hook.Add("LoadNextMap", "MapHandler.LoadNextMap", function()
    GAMEMODE:CenterNotify("Loading next map...")

    local randomMap = serverMaps[math.random(#serverMaps)]

    local mapName = navmeshedMaps[randomMap].Name
    local mapSize = navmeshedMaps[randomMap].Size
    local mapType = navmeshedMaps[randomMap].Type
    --local mapMinPlayers = (navmeshedMaps[randomMap].MinPlayers or "?")

    if mapSize == TINY then
        col = Color(255, 0, 0)
    elseif mapSize == SMALL then
        col = Color(255, 83, 0)
    elseif mapSize == MEDIUM then
        col = Color(255, 165, 0)
    elseif mapSize == LARGE then
        col = Color(165, 255, 0)
    elseif mapSize == EXTRALARGE then
        col = Color(0, 255, 0)
    elseif mapSize == DYNAMIC then
        col = Color(255, 0, 255)
    end

    timer.Simple(8, function()
        GAMEMODE:CenterNotify({font = "ZSHUDFontSmall"}, Color(50, 200, 200), mapName)
        GAMEMODE:CenterNotify("Map Size: ", col, mapSize)
        GAMEMODE:CenterNotify("Map Type: ", Color(200, 50, 50), mapType)
        
        timer.Simple(8, function()
            RunConsoleCommand("changelevel", randomMap)
        end)
    end)

    return true
end)

for _, mapid in pairs(MapDownloads) do
    if game.GetMap() == _ then
        resource.AddWorkshop(mapid)
        break
    end
end

nightrally.LogFile("sv_maphandler.lua")
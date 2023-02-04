util.AddNetworkString("nZSPhysProp")
util.AddNetworkString("nZSSWEPProp")
util.AddNetworkString("nZSSigilNode")

hook.Add("PlayerSay", "MapProfile.PlayerSay", function(ply, text)
    if string.lower(text) == "!loadmapprofile" and GAMEMODE_NAME == "sandbox" then
        if ply:SteamID() ~= "STEAM_0:0:105668971" then return end

        if file.Exists("nzsprofiles/"..game.GetMap()..".lua", "LUA") then
            include("nzsprofiles/"..game.GetMap()..".lua")
            hook.Run("InitPostEntityMap")
        end

        PrintMessage(HUD_PRINTTALK, "Map profile loaded successfully!")

    elseif string.lower(text) == "!physprop" or string.lower(text) == "/physprop" then
        local ent = ply:GetEyeTrace().Entity

        net.Start("nZSPhysProp")
            net.WriteEntity(ent)
        net.Send(ply)

    elseif string.lower(text) == "!swepprop" or string.lower(text) == "/swepprop" then
        local ent = ply:GetEyeTrace().Entity

        net.Start("nZSSWEPProp")
            net.WriteEntity(ent)
        net.Send(ply)

    elseif string.lower(text) == "!sigilnode" or string.lower(text) == "/sigilnode" then

        net.Start("nZSSigilNode")
            net.WriteEntity(ply)
        net.Send(ply)
    end
end)
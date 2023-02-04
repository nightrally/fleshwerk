timer.Create("ChatTips", 120, 0, function()
    if nightrally.DisableChatTips then return end

    chat.AddText(NZSCOLOR_GREEN, "[nZS Tips] :information: ", color_white, nightrally.ChatTips[math.random(#nightrally.ChatTips)])
end)

--[[local reqhumans = 0
hook.Add("HUDPaint", "NoZMaining", function()
    if engine.ActiveGamemode() ~= "zombiesurvival" then return end
    local s = BetterScreenScale()

    if #player.GetHumans() >= reqhumans then
        draw.SimpleText("ZMaining Allowed | "..#player.GetHumans().." / "..reqhumans.." human players", "ZSHUDFont_18", 5 * s, 152 * s, Color(47, 251, 47), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    else
        draw.SimpleText("No ZMaining | "..(#player.GetHumans()).." / "..reqhumans.." human players", "ZSHUDFont_18", 5 * s, 152 * s, Color(251, 47, 47), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end)]]

gameevent.Listen( "player_connect_client" )
hook.Add( "player_connect_client", "nZS.JoinMessages", function( data )
	local name = data.name
	local steamid = data.networkid
	local id = data.UserID
	local bot = data.bot
	local index = data.index

    if steamid == "BOT" then return end

	chat.AddText(NZSCOLOR_GREEN, name, NZSCOLOR_BLACK, " ("..steamid..")", color_white, " is ", NZSCOLOR_GREEN, "connecting", color_white, " to the server!")
    surface.PlaySound("buttons/combine_button3.wav")
end )

gameevent.Listen( "player_disconnect" )
hook.Add( "player_disconnect", "nZS.LeaveMessages", function( data )
	local name = data.name
	local steamid = data.networkid
	local id = data.userid
	local bot = data.bot
	local reason = data.reason
    
    if steamid == "BOT" then return end

    chat.AddText(NZSCOLOR_RED, name, NZSCOLOR_BLACK, " ("..steamid..")", color_white, " has ", NZSCOLOR_RED, "disconnected", color_white, " with the reason "..reason)
    surface.PlaySound("buttons/combine_button2.wav")
end )

net.Receive("nZS.FullyLoad", function()
    local name = net.ReadString()
    local steamid = net.ReadString()

    chat.AddText(NZSCOLOR_CYAN, name, NZSCOLOR_BLACK, " ("..steamid..")", color_white, " has ", NZSCOLOR_CYAN, "fully loaded", color_white, " to the server!")
    surface.PlaySound("buttons/combine_button5.wav")
end)

nightrally.LogFile("cl_chatessentials.lua")
util.AddNetworkString("nZS.FullyLoad")
local load_queue = {}

hook.Add("PlayerInitialSpawn", "nZS.FullyLoadMessages", function(ply)
	load_queue[ply] = true
end)

hook.Add("SetupMove", "nZS.FullyLoadMessages", function(ply, _, cmd)
	if load_queue[ply] and not cmd:IsForced() then
		load_queue[ply] = nil

		if ply:IsBot() then return end

		net.Start("nZS.FullyLoad")
            net.WriteString(ply:Name())
            net.WriteString(ply:SteamID())
        net.Broadcast()
	end
end)

hook.Add("PlayerSay", "nZS.ChatSounds", function(ply, text)
	local function ChatSound(msg, audio)
		if string.find(text:lower(), msg) then
			ply:EmitSound(audio[math.random(#audio)])
		end
	end

	ChatSound("bullshit", {"vo/npc/male01/question26.wav"})
	ChatSound("duck", {"vo/npc/barney/ba_duck.wav"})
	ChatSound("haha", {"vo/npc/barney/ba_laugh01.wav", "vo/npc/barney/ba_laugh02.wav", "vo/npc/barney/ba_laugh04.wav"})
	ChatSound("lol", {"vo/npc/barney/ba_laugh01.wav", "vo/npc/barney/ba_laugh02.wav", "vo/npc/barney/ba_laugh04.wav"})
	ChatSound("xd", {"vo/npc/barney/ba_laugh01.wav", "vo/npc/barney/ba_laugh02.wav", "vo/npc/barney/ba_laugh04.wav"})
	ChatSound("lmao", {"vo/npc/barney/ba_laugh01.wav", "vo/npc/barney/ba_laugh02.wav", "vo/npc/barney/ba_laugh04.wav"})
	ChatSound("lmfao", {"vo/npc/barney/ba_laugh01.wav", "vo/npc/barney/ba_laugh02.wav", "vo/npc/barney/ba_laugh04.wav"})
	ChatSound("rofl", {"vo/npc/barney/ba_laugh01.wav", "vo/npc/barney/ba_laugh02.wav", "vo/npc/barney/ba_laugh04.wav"})
end)

nightrally.LogFile("sv_chatessentials.lua")
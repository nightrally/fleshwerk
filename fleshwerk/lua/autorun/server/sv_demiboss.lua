util.AddNetworkString("CorruptPactZClass")

hook.Add("PostPlayerSpawn", "Demiboss.PPS", function(pl)
    if pl:Team() == TEAM_ZOMBIE then
        local classtab = pl:GetZombieClassTable()

        if classtab.Demiboss then
            BroadcastLua("MySelf:EmitSound(\"npc/zombie_poison/pz_alert\"..math.random(2)..\".wav\", 0, math.random(80, 90))")
            GAMEMODE:CenterNotify(NZSCOLOR_ORANGE, {killicon = classtab.SWEP}, " "..pl:Name().." has risen as "..classtab.Name.."!! ", {killicon = classtab.SWEP})
            return
        end

		if classtab.Name == "Figure" then
			BroadcastLua("MySelf:EmitSound(\"nightrally/sfx/creak\"..math.random(3)..\".ogg\", 0, math.random(90, 110))")
            GAMEMODE:CenterNotify(NZSCOLOR_ORANGE, {font = "ZSHUDFontSmall"}, "Figure has been summoned!")
			timer.Simple(3, function()
			GAMEMODE:CenterNotify("Don't make too much sound! Figure is blind and only hears sound.")
			end)
			timer.Simple(6, function()
			GAMEMODE:CenterNotify(NZSCOLOR_RED, "M1 with weapons, walking and jumping count as noise!")
			end)
			timer.Simple(9, function()
			GAMEMODE:CenterNotify(NZSCOLOR_CYAN, "Crouch walking, standing still and typing in chat count as silence!")
			end)
			timer.Simple(12, function()
			GAMEMODE:CenterNotify(NZSCOLOR_ORANGE, {font = "ZSHUDFontSmall"}, "Damaging Figure only angers it.")
			end)
			timer.Simple(15, function()
			GAMEMODE:CenterNotify("Good luck! Points will be rewarded depending on the Figure survival rate!")
			end)
		end
    end
end)

net.Receive("CorruptPactZClass", function()
    local pl = net.ReadEntity()
    local classname = net.ReadString()
    local cost = net.ReadFloat()

	local demibossclasses = {}
	for _, classtable in pairs(GAMEMODE.ZombieClasses) do
		if classtable.Demiboss then
			table.insert(demibossclasses, classtable.Index)
		end
	end

	if #demibossclasses == 0 then return -1 end

	local demibossindex
	for _, classindex in pairs(demibossclasses) do
		local classtable = GAMEMODE.ZombieClasses[classindex]
		if string.lower(classtable.Name) == string.lower(classname) then
			demibossindex = classindex
			break
		end
	end

	local curclass = pl.DeathClass or pl:GetZombieClass()
	pl:KillSilent()
	pl:SetZombieClass(demibossindex or demibossclasses[1])
	pl:DoHulls(demibossindex, TEAM_UNDEAD)
	pl.DeathClass = nil
	pl:UnSpectateAndSpawn()
	pl.DeathClass = curclass

    pl:SetNWInt("ZCorruptCreds", pl:GetNWInt("ZCorruptCreds") - cost)
end)

hook.Add("PostHumanKilledZombie", "ZCorruptCredGain1", function(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
    pl:AddCorruptionCredits(math.floor(pl:GetMaxZombieHealth()/5))
end)

nightrally.LogFile("sv_demiboss.lua")
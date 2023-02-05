util.AddNetworkString("CorruptPactZClass")

hook.Add("PostPlayerSpawn", "Demiboss.PPS", function(pl)
    if pl:Team() == TEAM_ZOMBIE then
        local classtab = pl:GetZombieClassTable()

        if classtab.Demiboss then
            BroadcastLua("MySelf:EmitSound(\"npc/zombie_poison/pz_alert\"..math.random(2)..\".wav\", 0, math.random(80, 90))")
            GAMEMODE:CenterNotify(NZSCOLOR_ORANGE, {killicon = classtab.SWEP}, " "..pl:Name().." has risen as "..classtab.Name.."!! ", {killicon = classtab.SWEP})
            return
        end

		if classtab.GreatEvil then
            GAMEMODE:CenterNotify(NZSCOLOR_DISASTER, {font = "ZSHUDFont"}, "A Great Evil has been summoned...")
			BroadcastLua("MySelf:EmitSound(\"npc/zombie_poison/pz_alert1.wav\", 0, math.random(50, 60))")
            return
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
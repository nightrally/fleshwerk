hook.Add("PostHumanKilledZombie", "FleshMesh.PHKZ", function(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
	if assistpl then
		attacker:UpdateStat("FleshMeshCredits", math.floor(math.Clamp((assistamount / pl:GetMaxZombieHealth()) * 50, 1, 50)))
        return
	end

	if headshot then
		attacker:UpdateStat("FleshMeshCredits", 55)
        return
	end

    attacker:UpdateStat("FleshMeshCredits", 50)
end)

nightrally.LogFile("sv_fleshmesh.lua")
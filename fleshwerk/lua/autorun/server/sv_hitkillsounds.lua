util.AddNetworkString("nZS.HitSound")

hook.Add("PlayerDeath", "nZS.KillSounds", function(victim, inflictor, attacker)
    if attacker then
	    attacker:SendLua("surface.PlaySound(\"nightrally/killsound.ogg\")")
    end
end)

hook.Add("PostEntityTakeDamage", "nZS.HitSounds", function(ent, dmginfo)
	local attacker = dmginfo:GetAttacker()

	if ent:IsPlayer() then
		if attacker:IsValid() then
			if attacker:IsPlayer() then
				local myteam = attacker:Team()
				local otherteam = ent:Team()

				if myteam ~= otherteam then
					local damage = math.min(dmginfo:GetDamage(), ent:Health())
					local time = CurTime()

					if damage > 0 then
						if time >= ent.m_LastWaveStartSpawn + 3 and time >= ent.m_LastGasHeal + 2 then
							net.Start("nZS.HitSound")
								net.WriteFloat(damage)
							net.Send(attacker)
						end
					end
				end
			end
		end
	end
end)
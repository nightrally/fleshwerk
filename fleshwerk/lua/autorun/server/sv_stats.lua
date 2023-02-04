local meta = FindMetaTable("Player")
local VaultFolder = "nzs_stats_vault"

function StatsShouldSaveVault(pl)
	-- Always push accumulated points in to the vault if we have any.
	if pl:IsBot() then return false end

	if pl:GetNWInt("HStats.ZombiesKilled") > 0
	or pl:GetNWInt("HStats.ZombiesKilledAssists") > 0
	or pl:GetNWInt("HStats.ZombiesKilledHeadshots") > 0
	or pl:GetNWInt("HStats.DamageToZombies") > 0
	or pl:GetNWInt("HStats.PointsEarned") > 0

	or pl:GetNWInt("HStats.ObjectRepairPoints") > 0

	or pl:GetNWInt("HStats.RoundWins") > 0
	or pl:GetNWInt("HStats.RoundLosses") > 0 then
		return true
	end

	return false
end

function StatsShouldLoadVault(pl)
	return not pl:IsBot()
end

function StatsGetVaultFile(pl)
	local steamid = pl:SteamID64() or "invalid"

	return VaultFolder.."/"..steamid:sub(-2).."/"..steamid..".txt"
end

function StatsSaveAllVaults()
	for _, pl in pairs(player.GetAll()) do
		StatsSaveVault(pl)
	end
end

function StatsInitializeVault(pl)
	pl:SetNWInt("HStats.ZombiesKilled", 0)
	pl:SetNWInt("HStats.ZombiesKilledAssists", 0)
	pl:SetNWInt("HStats.ZombiesKilledHeadshots", 0)
	pl:SetNWInt("HStats.DamageToZombies", 0)
	pl:SetNWInt("HStats.PointsEarned", 0)

	pl:SetNWInt("HStats.ObjectRepairPoints", 0)

	pl:SetNWInt("HStats.RoundWins", 0)
	pl:SetNWInt("HStats.RoundLosses", 0)
end

function StatsLoadVault(pl)
	if not StatsShouldLoadVault(pl) then return end

	local filename = StatsGetVaultFile(pl)
	if file.Exists(filename, "DATA") then
		local contents = file.Read(filename, "DATA")
		if contents and #contents > 0 then
			contents = Deserialize(contents)
			if contents then

				if contents.HStats_ZombiesKilled then
					pl:SetNWInt("HStats.ZombiesKilled", contents.HStats_ZombiesKilled)
				end

				if contents.HStats_ZombiesKilledAssists then
					pl:SetNWInt("HStats.ZombiesKilledAssists", contents.HStats_ZombiesKilledAssists)
				end

				if contents.HStats_ZombiesKilledHeadshots then
					pl:SetNWInt("HStats.ZombiesKilledHeadshots", contents.HStats_ZombiesKilledHeadshots)
				end

				if contents.HStats_DamageToZombies then
					pl:SetNWInt("HStats.DamageToZombies", contents.HStats_DamageToZombies)
				end

				if contents.HStats_PointsEarned then
					pl:SetNWInt("HStats.PointsEarned", contents.HStats_PointsEarned)
				end


				
				if contents.HStats_ObjectRepairPoints then
					pl:SetNWInt("HStats.ObjectRepairPoints", contents.HStats_ObjectRepairPoints)
				end



				if contents.HStats_RoundWins then
					pl:SetNWInt("HStats.RoundWins", contents.HStats_RoundWins)
				end

				if contents.HStats_RoundLosses then
					pl:SetNWInt("HStats.RoundLosses", contents.HStats_RoundLosses)
				end
				
			end
		end
	end
end

function StatsSaveVault(pl)
	if not StatsShouldSaveVault(pl) then return end

	local tosave = {
		HStats_ZombiesKilled 			= pl:GetNWInt("HStats.ZombiesKilled"),
		HStats_ZombiesKilledAssists 	= pl:GetNWInt("HStats.ZombiesKilledAssists"),
		HStats_ZombiesKilledHeadshots 	= pl:GetNWInt("HStats.ZombiesKilledHeadshots"),
		HStats_DamageToZombies 			= pl:GetNWInt("HStats.DamageToZombies"),
		HStats_PointsEarned 			= pl:GetNWInt("HStats.PointsEarned"),

		HStats_ObjectRepairPoints 		= pl:GetNWInt("HStats.ObjectRepairPoints"),

		HStats_RoundWins				= pl:GetNWInt("HStats.RoundWins"),
		HStats_RoundLosses				= pl:GetNWInt("HStats.RoundLosses")
	}

	local filename = StatsGetVaultFile(pl)
	file.CreateDir(string.GetPathFromFilename(filename))
	file.Write(filename, Serialize(tosave))
end

hook.Add("PostEndRound", "Stats.Setup1", function(winner)
    StatsSaveAllVaults()
end)

hook.Add("PlayerInitialSpawn", "Stats.Setup2", function(pl)
    StatsInitializeVault(pl)
end)

hook.Add("PlayerInitialSpawnRound", "Stats.Setup3", function(pl)
    StatsLoadVault(pl)
end)

hook.Add("PlayerDisconnected", "Stats.Setup4", function(pl)
    StatsSaveVault(pl)
end)

hook.Add("ShutDown", "Stats.Setup5", function()
    StatsSaveAllVaults()
end)

function meta:UpdateStat(name, val)
	self:SetNWInt(name, self:GetNWInt(name) + val)
end

-- Combat

hook.Add("PostHumanKilledZombie", "HStats.PHKZ", function(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
    attacker:UpdateStat("HStats.ZombiesKilled", 1)

	if assistpl then
		assistpl:UpdateStat("HStats.ZombiesKilledAssists", 1)
	end

	if headshot then
		attacker:UpdateStat("HStats.ZombiesKilledHeadshots", 1)
	end
end)

hook.Add("PostEntityTakeDamage", "HStats.HDZ", function(ent, dmginfo)
	local attacker = dmginfo:GetAttacker()

	if ent:IsPlayer() then
		if attacker:IsValid() then
			if attacker:IsPlayer() then
				local myteam = attacker:Team()
				local otherteam = ent:Team()

				if myteam ~= otherteam then
					local damage = math.min(dmginfo:GetDamage(), ent:Health())

					if damage > 0 then
						local time = CurTime()

						if myteam == TEAM_HUMAN and otherteam == TEAM_UNDEAD then
							if time >= ent.m_LastWaveStartSpawn + 3 and time >= ent.m_LastGasHeal + 2 then
								attacker:UpdateStat("HStats.DamageToZombies", damage)
							end
						end
					end
				end
			end
		end
	end
end)

hook.Add("PlayerPointsAdded", "HStats.PPA", function(pl, amount)
	pl:UpdateStat("HStats.PointsEarned", amount)
end)

-- Support

hook.Add("PostPlayerRepairedObject", "HStats.PPRO", function(pl, other, health, wep)
	pl:UpdateStat("HStats.ObjectRepairPoints", health)
end)

-- Survival

hook.Add("EndRound", "HStats.ER", function(winner)
	if winner == TEAM_HUMAN then
		for _, pl in pairs(player.GetHumans()) do
			if pl:Team() == TEAM_HUMAN then
				pl:UpdateStat("HStats.RoundWins", 1)
			elseif pl:Team() == TEAM_UNDEAD then
				pl:UpdateStat("HStats.RoundLosses", 1)
			end
		end
	elseif winner == TEAM_ZOMBIE then
		for _, pl in pairs(team.GetPlayers(TEAM_UNDEAD)) do
			pl:UpdateStat("HStats.RoundLosses", 1)
		end
	end
end)
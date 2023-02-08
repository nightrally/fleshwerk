local meta = FindMetaTable("Player")
local VaultFolder = "nzs_punishment_vault"

function PunishmentShouldSaveVault(pl)
	return not pl:IsBot()
end

function PunishmentShouldLoadVault(pl)
	return not pl:IsBot()
end

function PunishmentGetVaultFile(pl)
	local steamid = pl:SteamID64() or "invalid"

	return VaultFolder.."/"..steamid:sub(-2).."/"..steamid..".txt"
end

function PunishmentInitializeVault(pl)
    pl:SetNWBool("Punishment.ChatMuted", false)
    pl:SetNWBool("Punishment.VoiceMuted", false)
    pl:SetNWBool("Punishment.AegisBanned", false)
    pl:SetNWBool("Punishment.HammerBanned", false)
end

function PunishmentLoadVault(pl)
	if not PunishmentShouldLoadVault(pl) then return end

	local filename = PunishmentGetVaultFile(pl)
	if file.Exists(filename, "DATA") then
		local contents = file.Read(filename, "DATA")
		if contents and #contents > 0 then
			contents = Deserialize(contents)
			if contents then

				if contents.Punishment_ChatMuted then
					pl:SetNWBool("Punishment.ChatMuted", contents.Punishment_ChatMuted)
				end

                if contents.Punishment_VoiceMuted then
					pl:SetNWBool("Punishment.VoiceMuted", contents.Punishment_VoiceMuted)
				end

                if contents.Punishment_AegisBanned then
					pl:SetNWBool("Punishment.AegisBanned", contents.Punishment_AegisBanned)
				end

                if contents.Punishment_HammerBanned then
					pl:SetNWBool("Punishment.HammerBanned", contents.Punishment_HammerBanned)
				end
				
			end
		end
	end
end

function PunishmentSaveVault(pl)
	if not PunishmentShouldSaveVault(pl) then return end

	local tosave = {
        Punishment_ChatMuted = pl:GetNWBool("Punishment.ChatMuted"),
        Punishment_VoiceMuted = pl:GetNWBool("Punishment.VoiceMuted"),
        Punishment_AegisBanned = pl:GetNWBool("Punishment.AegisBanned"),
        Punishment_HammerBanned = pl:GetNWBool("Punishment.HammerBanned")
	}

	local filename = PunishmentGetVaultFile(pl)
	file.CreateDir(string.GetPathFromFilename(filename))
	file.Write(filename, Serialize(tosave))
end

hook.Add("PlayerInitialSpawn", "Punishment.Setup2", function(pl)
    PunishmentInitializeVault(pl)
end)

hook.Add("PlayerInitialSpawnRound", "Punishment.Setup3", function(pl)
    PunishmentLoadVault(pl)
end)

-- Combat

hook.Add("PlayerSay", "Punishment.PlayerSay", function(ply, text)
    local txt = string.lower(text)

    if ply:IsChatMuted() then
        ply:PunishedNotify("You are chat muted!")
        return ""
    end
end)

hook.Add( "PlayerCanHearPlayersVoice", "Punishment.PCHPV", function( listener, talker )
    if talker:IsVoiceMuted() then
		return false
	end
end )

nightrally.LogFile("sv_punishments.lua")
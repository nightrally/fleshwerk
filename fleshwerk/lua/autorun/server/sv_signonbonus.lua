local load_queue = {}

local meta = FindMetaTable("Player")
local VaultFolder = "nzs_signon_vault"

function SignOnShouldSaveVault(pl)
	return not pl:IsBot()
end

function SignOnShouldLoadVault(pl)
	return not pl:IsBot()
end

function SignOnGetVaultFile(pl)
	local steamid = pl:SteamID64() or "invalid"

	return VaultFolder.."/"..steamid:sub(-2).."/"..steamid..".txt"
end

function SignOnInitializeVault(pl)
    pl:SetNWBool("nZS.SignOnBonus", false)
end

function SignOnLoadVault(pl)
	if not SignOnShouldLoadVault(pl) then return end

	local filename = SignOnGetVaultFile(pl)
	if file.Exists(filename, "DATA") then
		local contents = file.Read(filename, "DATA")
		if contents and #contents > 0 then
			contents = Deserialize(contents)
			if contents then
				if contents.SignOnBonus then
					pl:SetNWBool("nZS.SignOnBonus", contents.SignOnBonus)
				end
			end
		end
	end
end

function SignOnSaveVault(pl)
	if not SignOnShouldSaveVault(pl) then return end

	local tosave = {
        SignOnBonus = pl:GetNWBool("nZS.SignOnBonus"),
	}

	local filename = SignOnGetVaultFile(pl)
	file.CreateDir(string.GetPathFromFilename(filename))
	file.Write(filename, Serialize(tosave))
end

hook.Add("PlayerInitialSpawn", "SignOn.Setup1", function(pl)
	if nightrally.SignOnBonusDisabled then
		hook.Remove("PlayerInitialSpawn", "SignOn.Setup1")
		return
	end

    SignOnInitializeVault(pl)
	load_queue[pl] = true
end)

hook.Add("SetupMove", "SignOn.Setup2", function(ply, _, cmd)
	if nightrally.SignOnBonusDisabled then
		hook.Remove("SetupMove", "SignOn.Setup2")
		return
	end

	if load_queue[ply] and not cmd:IsForced() then
		load_queue[ply] = nil

		if ply:IsBot() then return end

		if ply:GetNWBool("nZS.SignOnBonus") == false then
			ply:SendLua("GiveSignOnBonus()")
			ply:AddZSXP(2800)
			ply:SetNWBool("nZS.SignOnBonus", true)
			SignOnSaveVault(ply)
		end
	end
end)

hook.Add("PlayerInitialSpawnRound", "SignOn.Setup3", function(pl)
	if nightrally.SignOnBonusDisabled then
		hook.Remove("PlayerInitialSpawnRound", "SignOn.Setup3")
		return
	end

    SignOnLoadVault(pl)
end)

nightrally.LogFile("sv_signonbonus.lua")
local meta = FindMetaTable("Player")

hook.Add("OnWaveEnd", "ddd", function()
    timer.Simple(2, function()
        RunConsoleCommand("ulx", "playurl", "https://cdn.discordapp.com/attachments/1047823974186373197/1075834858171027526/ohio_ahh_sound_effect_320_kbps.mp3")
    end)
end)

function meta:SetChatMuted(val)
    self:SetNWBool("Punishment.ChatMuted", val)
    PunishmentSaveVault(self)
end

function meta:IsChatMuted()
    return self:GetNWBool("Punishment.ChatMuted") == true
end

function meta:SetVoiceMuted(val)
    self:SetNWBool("Punishment.VoiceMuted", val)
    PunishmentSaveVault(self)
end

function meta:IsVoiceMuted()
    return self:GetNWBool("Punishment.VoiceMuted") == true
end

function meta:SetAegisBanned(val)
    self:SetNWBool("Punishment.AegisBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsAegisBanned()
    return self:GetNWBool("Punishment.AegisBanned") == true
end

function meta:SetHammerBanned(val)
    self:SetNWBool("Punishment.HammerBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsHammerBanned()
    return self:GetNWBool("Punishment.HammerBanned") == true
end

function meta:SetNestBanned(val)
    self:SetNWBool("Punishment.NestBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsNestBanned()
    return self:GetNWBool("Punishment.NestBanned") == true
end

function meta:PunishedNotify(text)
    self:CenterNotify(Color(251, 47, 47), text)
end

nightrally.LogFile("sh_punishments.lua")
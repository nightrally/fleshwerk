local meta = FindMetaTable("Player")

function meta:CallNuclearWarhead()
    BroadcastLua("surface.PlaySound(\"nightrally/disasters/nuke_call.ogg\")")

    timer.Simple(5, function()
        BroadcastLua("surface.PlaySound(\"nightrally/disasters/nuke_fall.ogg\")")
    end)

    timer.Simple(7, function()
        BroadcastLua("surface.PlaySound(\"nightrally/disasters/nuke_explosion.ogg\")")
        BroadcastLua("util.ScreenShake(LocalPlayer():GetPos(), 10, 2^31, 12, 2^31)")
        BroadcastLua("util.WhiteOut(12)")
        for _, pl in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
            pl:TakeSpecialDamage(pl:Health(), DMG_ALWAYSGIB, self)
            if pl:Alive() then
                pl:Kill()
            end
        end

        for _, all in ipairs(player.GetAll()) do
            all:SetFOV(160)
        end
        timer.Simple(0, function()
            for _, all in ipairs(player.GetAll()) do
                all:SetFOV(130, 5)
            end
        end)
    end)

    timer.Simple(12, function()
        BroadcastLua("util.ScreenShake(LocalPlayer():GetPos(), 100, 100, 2, 2^31)")
        for _, all in ipairs(player.GetAll()) do
            all:SetFOV(160)
        end

        timer.Simple(0, function()
            for _, all in ipairs(player.GetAll()) do
                all:SetFOV(100, 3)
            end
        end)
    end)

    GAMEMODE:CenterNotify(NZSCOLOR_DISASTER, {font = "ZSHUDFontSmall"}, self:Name().." called a Nuclear Warhead!!")
end

nightrally.LogFile("sv_disasters.lua")
if SERVER then
    hook.Add("PostPlayerSpawn", "PostPlayerSpawn.OwnerOnly", function(pl)
        if pl:Team() == TEAM_HUMAN then
            if pl:nightrally()then
                pl:Give("weapon_zs_tommygun")
                pl:SetModel("models/player/reaper.mdl")
            end
        end
    end)
end

if CLIENT then
end

nightrally.LogFile("sh_owneronly.lua")
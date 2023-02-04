if SERVER then
    hook.Add("PostPlayerSpawn", "PostPlayerSpawn.OwnerOnly", function(pl)
        if pl:Team() == TEAM_HUMAN then
            if pl:nightrally()then
                pl:Give("weapon_zs_tommygun")
                pl:SetModel("models/player/fnaf_sexy/frederika.mdl")
            elseif pl:Anakinhall06() then
                pl:Give("weapon_zs_tommygun")
                pl:SetModel("models/kyo/ghost_azrael_pm.mdl")
            end
        end
    end)
end

if CLIENT then
end
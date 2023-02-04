hook.Add("OnWaveStart", "MapProfile.1", function(wave)
    if wave == 1 then
        for _, pl in ipairs(team.GetPlayers(TEAM_HUMAN)) do
            pl:GiveAmmo(9999, "buckshot", true)
            pl:GiveAmmo(9999, "pulse", true)
            pl:Give("weapon_zs_pulserifle_q3")
            pl:Give("weapon_zs_boomstick_q3")
            pl:Give("weapon_zs_zeknife")
        end

        timer.Simple(10, function()
            MapProfileCredit()
        end)
    end
end)

hook.Add("InitPostEntityMap", "MapProfile.2", function()
    timer.Simple(1, function()
        for _, ent in pairs(ents.FindByClass("prop_weapon")) do
            ent:Remove()
        end
        for _, ent in pairs(ents.FindByClass("prop_ammo")) do
            ent:Remove()
        end

        nightrally.BossSpeedMul = 1.5
    end)
end)

hook.Add("PostPlayerSpawn", "MapProfile.3", function(pl)
    if pl:Team() == TEAM_HUMAN then
        pl:StripWeapons()
        pl:RemoveAllAmmo()
    end
end)
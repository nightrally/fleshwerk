function MenuOpenSound()
    surface.PlaySound("nightrally/ui/buttons/open.ogg")
end

function MenuCloseSound()
    surface.PlaySound("nightrally/ui/buttons/close.ogg")
end

net.Receive("nZS.HitSound", function()
    local damage = net.ReadFloat()
    local lp = LocalPlayer()

    lp:EmitSound("nightrally/hitsound.wav", 0, math.Clamp(100 - (damage / 10), 50, 100))
end)
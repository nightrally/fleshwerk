hook.Add("HUDPaint", "ZombieStore", function()
    if GAMEMODE_NAME ~= "zombiesurvival" then return end
    local lp, s = LocalPlayer(), BetterScreenScale()

    if lp:Team() == TEAM_ZOMBIE then
        draw.WordBox(0, 0, 164 * s, " CC$"..lp:GetNWInt("ZCorruptCreds").." - F2 ", "Trebuchet24", Color(0, 0, 0, 180), NZSCOLOR_CREDITS)
    end

    draw.SimpleText("No Z-Maining", "ZSHUDFont_20", ScrW()/2, 4, Color(205 + math.sin((RealTime() * 10)) * 50, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

function ZCorruptionPact()
    local lp, s = LocalPlayer(), BetterScreenScale()
    MenuOpenSound()

    local frame = vgui.Create("DFrame")
    frame:SetSize(1200 * s, 800 * s)
    frame:SetTitle("Zombie Store")
    frame:Center()
    frame.OnClose = function() MenuCloseSound() end
    frame:MakePopup()

    local sheet = vgui.Create("DPropertySheet", frame)
    sheet:Dock(FILL)

    local cat1 = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Zombie Classes", cat1, "icon16/bug.png")
    local zclasses = vgui.Create("DScrollPanel", cat1)
    zclasses:Dock( FILL )

     local test = vgui.Create("DCollapsibleCategory", zclasses)
     test:SetLabel("")
     test:SetHeaderHeight(64)
     test:Dock(TOP)
     test.Paint = function(panel, w, h)
         surface.SetDrawColor(Color(80, 80, 80))
         surface.DrawRect(0, 0, w, h)

         draw.SimpleText("Demibosses", "ZSHUDFont", w/2, panel:GetHeaderHeight()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
     end

     local list = vgui.Create("DPanelList", test)
     list:SetSpacing(5)
     test:SetContents(list)
    
    local function Zombie(name, desc, img, cost)
        local pnl = vgui.Create("DPanel")
        pnl:SetSize(list:GetWide(), 72)
        pnl:Dock(TOP)
        pnl.Paint = function(panel, w, h)
            surface.SetDrawColor(55, 55, 55)
            surface.DrawRect(0, 0, w, h)
        end
        list:AddItem(pnl)

        local icon = vgui.Create("DImage", pnl)
        icon:SetSize(64, 64)
        icon:SetImage(img)
        icon:Dock(LEFT)
        icon:DockMargin(16, 4, 0, 4)

        local costlbl = vgui.Create("DLabel", pnl)
        costlbl:SetText("CC$"..tostring(cost))
        costlbl:SetFont("ZSHUDFont")
        costlbl:SetTextColor(lp:GetNWInt("ZCorruptCreds") < cost and NZSCOLOR_RED or NZSCOLOR_CREDITS)
        costlbl:SizeToContents()
        costlbl:Dock(RIGHT)
        costlbl:DockMargin(0, 0, 16, 0)

        local namelbl = vgui.Create("DLabel", pnl)
        namelbl:SetText(name)
        namelbl:SetFont("ZSHUDFontSmall")
        namelbl:SetTextColor(lp:GetNWInt("ZCorruptCreds") < cost and NZSCOLOR_RED or color_white)
        namelbl:SizeToContents()
        namelbl:Dock(FILL)
        namelbl:SetContentAlignment(5)

        local btn = vgui.Create("DButton", pnl)
        btn:SetSize(frame:GetWide() - 26, 72)
        btn:SetText("")
        btn:SetTooltip(desc)
        btn.Paint = function() end
        btn.DoClick = function()
            if lp:GetNWInt("ZCorruptCreds") < cost or GAMEMODE:GetWave() == 0 or not GAMEMODE:GetWaveActive() or lp:GetZombieClassTable().Demiboss or lp:GetZombieClassTable().Boss or lp:GetZombieClassTable().GreatEvil then
                surface.PlaySound("buttons/combine_button_locked.wav")

                if lp:GetNWInt("ZCorruptCreds") < cost then
                    lp:ChatPrint("You don't have enough Corruption Credits!")
                elseif GAMEMODE:GetWave() == 0 or not GAMEMODE:GetWaveActive() then
                    lp:ChatPrint("You can't purchase anything right now!")
                elseif lp:GetZombieClassTable().Demiboss or lp:GetZombieClassTable().Boss or lp:GetZombieClassTable().GreatEvil then
                    lp:ChatPrint("You are currently a restricted zombie class!")
                end
            else
                surface.PlaySound("ambient/levels/labs/coinslot1.wav")
                lp:ChatPrint("Purchased "..name.." for "..cost.." Corruption Credits!")
                frame:Close()
                net.Start("CorruptPactZClass")
                    net.WriteEntity(lp)
                    net.WriteString(name)
                    net.WriteFloat(cost)
                net.SendToServer()
            end
        end
    end

    Zombie("Flesh Forager", "The Flesh Forager is slow and weak but has the ability to throw Bonemesh bombs.\nIt can also heal itself along with other undeads indefinitely.", "nightrally/killicons/zombies/fleshforager", 800)
    Zombie("Undead Soldier", "The Undead Soldier hasn't lost its ability handling a fully auto assault rifle.\nBecause of this, the Undead Soldier is unable to use any melee attacks.\nIt's best to stay a medium distance away from humans.", "nightrally/killicons/zombies/undeadsoldier", 800)
end

nightrally.LogFile("cl_demiboss.lua")
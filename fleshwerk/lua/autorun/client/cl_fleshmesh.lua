hook.Add("HUDPaint", "FleshMesh.HUDP", function()
    if engine.ActiveGamemode() ~= "zombiesurvival" then return end
    local lp, s = LocalPlayer(), BetterScreenScale()

    --[[local w, h = 250 * s, 40 * s
    local border = 16 * s

    surface.SetFont("ZSHUDFontSmall")
	local text = "$"..lp:GetNWInt("FleshMeshCredits")
	local twid, thei = surface.GetTextSize(text)

    draw.RoundedBoxEx(8, ScrW()/2 - twid/2 - border/2, 0, twid + border, h, Color(0, 0, 0, 180), false, false, true, true)
    draw.SimpleText(text, "ZSHUDFontSmall", ScrW()/2, h/2 - thei/2, NZSCOLOR_CREDITS, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)]]
end)

function FleshMeshV1()
    local lp, s = LocalPlayer(), BetterScreenScale()
    MenuOpenSound()

    local frame = vgui.Create("DFrame")
    frame:SetSize(1000 * s, 800 * s)
    frame:SetTitle("FleshMesh Store")
    frame:Center()
    frame:MakePopup()
    frame.OnClose = function() MenuCloseSound() end

    local sheet = vgui.Create("DPropertySheet", frame)
    sheet:Dock(FILL)

    local popitems = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Popular Items", popitems, "icon16/star.png")

    local popitemsScrl = vgui.Create("DScrollPanel", popitems)
    popitemsScrl:Dock( FILL )

    local function AddPopularItem(name, description, cost, icon)
        local bg = popitemsScrl:Add("DPanel")
        bg:SetSize(250 * s, 300 * s)
        bg:AlignLeft(24)
        bg:MoveBelow(popitemsScrl, 0)
        bg.Paint = function(panel, w, h)
            surface.SetDrawColor(Color(20, 20, 20))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(NZSCOLOR_DISASTER)
            surface.DrawOutlinedRect(0, 0, w, h)
        end

        local bg1 = bg:Add("DPanel")
        bg1:SetSize(234 * s, 300 * s)
        bg1:Dock(TOP)
        bg1:DockMargin(8, 8, 8, 0)
        bg1.Paint = function() end

        local title = bg1:Add("DLabel")
        title:SetText(name)
        title:SetTextColor(COLOR_GRAY)
        title:SetFont("ZSHUDFont_24")
        title:SizeToContents()
        title:SetPos(bg1:GetWide() / 2 - title:GetWide() / 2)

        local bg2 = bg:Add("DPanel")
        bg2:Dock(FILL)
        bg2:DockMargin(8, 8, 8, 8)
        bg2.Paint = function(panel, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(255, 70, 70))
        end

        local purchase = bg:Add("DButton")
        purchase:SetText("Purchase")
        purchase:SetTextColor(NZSCOLOR_XP)
        purchase:SetFont("ZSHUDFont_28")
        purchase:SizeToContents()
        purchase:Dock(BOTTOM)
        purchase:DockMargin(8, 0, 8, 8)
        purchase.Paint = function(panel, w, h)
            surface.SetDrawColor(NZSCOLOR_BLACK)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(NZSCOLOR_GREEN)
            surface.DrawOutlinedRect(0, 0, w, h)
        end
        purchase.DoClick = function()
            if lp:GetPoints() >= 200 then
                chat.AddText(NZSCOLOR_GREEN, lp:Name(), color_white, " just purchased a Nuclear Warhead token!")
            else
                chat.AddText(NZSCOLOR_RED, lp:Name(), color_white, ", you can't afford that.")
            end
        end
    end

    AddPopularItem("Nuclear Warhead", "Spawns in a Nuclear Warhead, killing all zombies spawned in.", 400, "nightrally/icons/nuclearwarhead")
end

nightrally.LogFile("cl_fleshmesh.lua")
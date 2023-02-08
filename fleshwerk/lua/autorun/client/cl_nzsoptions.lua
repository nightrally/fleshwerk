function nightrally.Options()
    surface.PlaySound("nightrally/ui/buttons/open.ogg")
    local s = BetterScreenScale()

    local wide, tall = 500 * s, 800 * s

    local frame = vgui.Create("DFrame")
    frame:SetSize(wide, tall)
    frame:SetTitle("")
    frame:Center()
    frame:MakePopup()
    frame.OnClose = function()
        surface.PlaySound("nightrally/ui/buttons/close.ogg")
    end

    local y = 8

	local label = EasyLabel(frame, "nZS Options", "ZSScoreBoardTitle", color_white)
	label:SetPos(wide * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 8

    local sheet = vgui.Create("DPropertySheet", frame)
    sheet:Dock(FILL)
    sheet:DockMargin(0, 20, 0, 0)
    sheet.Paint = function() end

    local function Checkbox(parent, text, cvar)
        local check = parent:Add("DCheckBoxLabel")
        check:SetText(text)
        check:SetConVar(cvar)
        check:SizeToContents()
        check:Dock(TOP)
        check:DockMargin(0, 8, 0, 0)
    end

    local misc = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Miscellaneous", misc, "icon16/cog.png")
    misc.Paint = function() end

    local miscS = vgui.Create("DScrollPanel", misc)
    miscS:Dock( FILL )

    ----------
    -- Misc --
    ----------

    Checkbox(miscS, "Disable nZS Tips in chat", nightrally.DisableChatTipsCVar)
end

function nightrally.Credits()
	MenuOpenSound()
	local s = BetterScreenScale()

	local frame = vgui.Create("DFrame")
	frame:SetSize(600 * s, 600 * s)
	frame:SetTitle("nZS Credits")
	frame:Center()
	frame:MakePopup()
	frame.OnClose = function() MenuCloseSound() end
	
	local zscroll = vgui.Create("DScrollPanel", frame)
    zscroll:Dock( FILL )

    local function Cat(text)
        local button = zscroll:Add("DButton")
        button:SetDisabled(true)
        button:SetCursor("arrow")
        button:SetText(text)
        button:SetTextColor(COLOR_GRAY)
        button:SetFont("ZSHUDFontSmall")
        button:SizeToContents()
        button:Dock(TOP)
        button:DockMargin(0, 0, 0, 0)
        button.Paint = function() end
    end

	local function Credit(name, steamid, desc)
		local lbpnl = zscroll:Add("DPanel")
        lbpnl:SetSize(0, 40)
        lbpnl:Dock(TOP)
        lbpnl:DockMargin(8, 2, 8, 2)
        lbpnl.Paint = function(panel, w, h)
            surface.SetDrawColor(NZSCOLOR_BLACK)
            surface.DrawRect(0, 0, w, h)
        end

        local lbavatar = vgui.Create("AvatarImage", lbpnl, "StatsLBAvatar")
        lbavatar:SetSize( 32, 32 )
        lbavatar:SetPos( 4, 4 )
        lbavatar:SetSteamID( steamid, 32 )
        lbavatar.OnMousePressed = function(self)
			MenuOpenSound()
			gui.OpenURL("https://steamcommunity.com/profiles/"..steamid)
		end

        local lbtext = vgui.Create("DLabel", lbpnl)
        lbtext:SetText(name)
        lbtext:SetFont("ZSHUDFontSmallest")
        lbtext:SetTextColor(NZSCOLOR_AETHER)
        lbtext:SizeToContents()
        lbtext:SetPos(0, 2)
        lbtext:MoveRightOf(lbavatar, 4)

        local lbdesc = vgui.Create("DLabel", lbpnl)
        lbdesc:SetText(desc)
        lbdesc:SizeToContents()
        lbdesc:MoveRightOf(lbavatar, 4)
        lbdesc:MoveBelow(lbtext, 0)
	end

    Cat("nZS Contributions")
    Credit("nightrally", "76561198171603670", "Owner/Developer of nZS")
    Credit("Cylowalker", "76561198237158014", "Weapon reanimations and default weapon killicons")
    Credit("Weigurde", "76561198913877245", "Map contributions")
    Credit("Bruhani", "76561198965259619", "Some map navmeshes")
    Credit("Anakinhall06", "76561198097536249", "SCK contributions")

    local forumpost = "Accepted forum posts"
    Cat("Special Thanks")
    Credit("wristwatch", "76561198401834184", forumpost)
    Credit("Anakinhall06", "76561198097536249", forumpost)
    Credit("the_hade", "76561198146727504", forumpost)
    Credit("HACH", "76561197987819134", forumpost)
    Credit("EPIC KLEINER", "76561198352881744", forumpost)

    Cat("Miscellaneous")
	Credit("Scott", "76561198024593456", "Sunrust server content packs")
end

function nightrally.Staff()
	MenuOpenSound()
	local s = BetterScreenScale()

	local frame = vgui.Create("DFrame")
	frame:SetSize(600 * s, 600 * s)
	frame:SetTitle("")
	frame:Center()
	frame:MakePopup()
	frame.OnClose = function() MenuCloseSound() end
	
	local zscroll = vgui.Create("DScrollPanel", frame)
    zscroll:Dock( FILL )

    local function Cat(text)
        local button = zscroll:Add("DButton")
        button:SetDisabled(true)
        button:SetCursor("arrow")
        button:SetText(text)
        button:SetTextColor(COLOR_GRAY)
        button:SetFont("ZSHUDFont")
        button:SizeToContents()
        button:Dock(TOP)
        button:DockMargin(0, 0, 0, 0)
        button.Paint = function() end
    end

	local function Staff(name, steamid, desc, usergroup)
		local lbpnl = zscroll:Add("DPanel")
        lbpnl:SetSize(0, 72)
        lbpnl:Dock(TOP)
        lbpnl:DockMargin(8, 2, 8, 2)
        lbpnl.Paint = function(panel, w, h)
            surface.SetDrawColor(NZSCOLOR_STAFF[usergroup])
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(0, 0, 0, 220)
            surface.DrawRect(0, 0, w, h)
        end

        local lbavatar = vgui.Create("AvatarImage", lbpnl, "StatsLBAvatar")
        lbavatar:SetSize( 64, 64 )
        lbavatar:SetPos( 4, 4 )
        lbavatar:SetCursor("hand")
        lbavatar:SetSteamID( steamid, 64 )
        lbavatar.OnMousePressed = function(self)
			MenuOpenSound()
			gui.OpenURL("https://steamcommunity.com/profiles/"..steamid)
		end

        local lbtext = vgui.Create("DLabel", lbpnl)
        lbtext:SetText(name)
        lbtext:SetFont("ZSHUDFontSmall")
        lbtext:SetTextColor(NZSCOLOR_STAFF[usergroup])
        lbtext:SizeToContents()
        lbtext:SetPos(0, 2)
        lbtext:MoveRightOf(lbavatar, 4)

        local lbdesc = vgui.Create("DLabel", lbpnl)
        lbdesc:SetText(desc)
        lbdesc:SetFont("ZSHUDFontSmallest")
        lbdesc:SetTextColor(NZSCOLOR_STAFF[usergroup])
        lbdesc:SizeToContents()
        lbdesc:MoveRightOf(lbavatar, 4)
        lbdesc:MoveBelow(lbtext, 0)
	end

    Cat("Staff Members")

    Staff("nightrally", "76561198171603670", "Owner", "owner")

    Staff("Anakinhall06", "76561198097536249", "Co-Owner", "coowner")

    Staff("[UB]Cylowalker", "76561198237158014", "Head Administrator", "hadmin")

    Staff("Gamer Tactics NotFound.Tech", "76561198153600609", "Administrator", "xadmin")

    Staff("the_andrei", "76561198362239688", "Senior Moderator", "smod")

    Staff("wristwatch", "76561198401834184", "Moderator", "mod")
end

nightrally.LogFile("cl_nzsoptions.lua")
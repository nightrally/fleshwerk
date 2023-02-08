local meta = FindMetaTable("Player")

-- Usergroup Stuff
function meta:IsStaffMember()
    return self:IsUserGroup("tmod") or self:IsUserGroup("mod") or self:IsUserGroup("smod") or self:IsUserGroup("xadmin") or self:IsUserGroup("hadmin") or self:nightrally() or self:Anakinhall06()
end
function meta:IsStaffTMod()
    return self:IsUserGroup("tmod")
end
function meta:IsStaffMod()
    return self:IsUserGroup("mod")
end
function meta:IsStaffSMod()
    return self:IsUserGroup("smod")
end
function meta:IsStaffXAdmin()
    return self:IsUserGroup("xadmin")
end
function meta:IsStaffHAdmin()
    return self:IsUserGroup("hadmin")
end
function meta:Anakinhall06()
    return self:SteamID() == "STEAM_0:1:68635260"
end
function meta:nightrally()
    return self:SteamID() == "STEAM_0:0:105668971"
end

function meta:ShouldBotControlPlayer(arg)
    if arg then
        self:D3bot_InitializeOrReset()
    else
        self:D3bot_Deinitialize()
    end
end

function meta:AddCorruptionCredits(amount)
    self:SetNWInt("ZCorruptCreds", self:GetNWInt("ZCorruptCreds") + amount)
end

function MapProfileCredit()
    GAMEMODE:CenterNotify(Color(255, 165, 0), "Map Profile made by nightrally")
end

NZSCOLOR_STAFF = {
    ["tmod"] = Color(166, 219, 255),
    ["mod"] = Color(109, 195, 246),
    ["smod"] = Color(105, 169, 255),
    ["xadmin"] = Color(255, 61, 61),
    ["hadmin"] = Color(235, 0, 0),
    ["coowner"] = Color(46, 204, 113),
    ["owner"] = Color(46, 204, 113)
}

NZSCOLOR_GREEN = Color(47, 251, 47)
NZSCOLOR_RED = Color(251, 47, 47)
NZSCOLOR_BLUE = Color(47, 47, 251)
NZSCOLOR_PINK = Color(251, 47, 251)
NZSCOLOR_YELLOW = Color(251, 251, 47)
NZSCOLOR_ORANGE = Color(251, 147, 47)
NZSCOLOR_CYAN = Color(47, 251, 251)
NZSCOLOR_BLACK = Color(47, 47, 47)
NZSCOLOR_XP = Color(165, 214, 167)
NZSCOLOR_DISASTER = Color(203, 22, 14)
NZSCOLOR_AETHER = Color(128, 222, 234)
NZSCOLOR_CREDITS = Color(255, 245, 157)

function nightrally.LogFile(txt)
    print(Either(SERVER, "[nZS SERVER] Successfully loaded "..txt, "[nZS CLIENT] Successfully loaded "..txt))
end

nightrally.LogFile("sh_utils1.lua")
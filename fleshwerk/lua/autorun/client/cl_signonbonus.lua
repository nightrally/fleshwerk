local function text3discord()
    Derma_Query("As a reward for joining my game server, here's 1,500 starting ZS XP to help get you started!\n\nIf you joined our Discord server, DM ell#7776 with proof and I'll give you another 1,500 ZS XP (3k total).\n\nHave fun!\n- ell, owner of nightrally's Zombie Survival", "", "Do not show again & send me a Discord server invite link", function() gui.OpenURL("https://discord.gg/DJrpXvFh3b") end)
end

local function text3()
    Derma_Message("As a reward for joining my game server, here's 1,500 starting ZS XP to help get you started!\n\nIf you joined our Discord server, DM ell#7776 with proof and I'll give you another 1,500 ZS XP (3k total).\n\nHave fun!\n- ell, owner of nightrally's Zombie Survival", "", "Do not show again")
end

local function text2()
    Derma_Query("This server is currently in an early build but we add new content often!\n\nIt would mean the world to us if you would join our Discord server!\nYou can post suggestions, report rule breakers, and more!", "", "No Thanks",
    function()
        text3()
    end,
    "Join Discord",
    function()
        text3discord()
    end)
end

local function text1()
    Derma_Query("Welcome to nightrally's Zombie Survival!", "", "Continue",
    function()
        text2()
    end)
end

function GiveSignOnBonus()
    text1()
end

nightrally.LogFile("cl_signonbonus.lua")
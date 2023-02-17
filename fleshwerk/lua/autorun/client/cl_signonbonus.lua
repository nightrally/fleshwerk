function GiveSignOnBonus()
    local lp = LocalPlayer()

    Derma_Message("You recieved a sign-on bonus of "..tostring(nightrally.SignOnXP).." ZS XP. Thanks for playing nightrally's Zombie Survival!", "Sign-On Bonus", "Ok")
end

nightrally.LogFile("cl_signonbonus.lua")
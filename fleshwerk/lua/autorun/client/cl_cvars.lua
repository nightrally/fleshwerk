nightrally.DisableChatTipsCVar = "nzs_disablechattips"
nightrally.DisableChatTips = CreateClientConVar(nightrally.DisableChatTipsCVar, "0", true, false):GetBool()
cvars.AddChangeCallback(nightrally.DisableChatTipsCVar, function(cvar, oldvalue, newvalue)
	nightrally.DisableChatTips = tonumber(newvalue) == 1
end)

nightrally.LogFile("cl_cvars.lua")
nightrally = nightrally or {}

nightrally.SignOnBonusDisabled = false
nightrally.SignOnXP = 1500

nightrally.TimeLimit = 15
nightrally.RoundLimit = 3
nightrally.MaxSigils = 3
nightrally.StartingLoadouts = {
	{"pshtr", "resupplybox", "3pcp", "2pcp"},
	{"btlax", "3pcp", "2pcp", "remantler"},
	{"stbbr", "3rcp", "2rcp", "targetingvisi"},
	{"tossr", "3smgcp", "medkit"},
	{"blstr", "3sgcp", "2sgcp", "medkit"},
	{"owens", "3pcp", "2pcp", "2smgcp", "3smgcp"},
	{"processor", "medkit", "90mkit", "60mkit", "bloodshot"},
	{"crklr", "3arcp", "2arcp", "6scrap"},
	{"junkpack", "crphmr", "barricadekit"},
	{"z9000", "3pls", "2pls", "medkit"},
	{"zpaxe", "3scrap", "medkit"}
}

-- 0.75x Default knockback for non-listed maps
nightrally.BoomstickKnockbackMul = {
	["gm_construct"] = 0.5
}

nightrally.MaxLevel = 80
nightrally.XPMul = 1
nightrally.nightrallyXPMul = 10

nightrally.ZombieHealthMul = 1
nightrally.ZombieSpeedMul = 1
nightrally.BossHealthMul = 1
nightrally.BossSpeedMul = 1

nightrally.PropHealthMul = 1
nightrally.PropRepairMul = 1
nightrally.ExtraHealthPerExtraNailMul = 1

nightrally.PlayersForBoss = 16

nightrally.ChatTips = {
	"You can view your stats by typing !stats.",
	"Your stats (!stats) are saved permanently even between map changes and upon disconnecting.",
	"You can open the nZS options menu by typing !options.",
	"You can open the nZS credits menu by typing !credits.",
	"You can access the zombie class selection menu by pressing F3.",
	"You can access the Worth Menu or Points Shop by pressing F2.",
	"You can disable nZS Tips by typing !options.",
	"Want to join our Discord server? Type !discord.",
	"You can open the nZS staff list menu by typing !staff.",
	"As a zombie, you gain Corruption Credits which you can spend on items in Corruption Pact. Press F2 to open it.",
	"Ghouls give enfeeble on hit which makes you more vulnerable to all damage sources!",
	"The max level is currently level "..nightrally.MaxLevel.."."
}

nightrally.SkillTreeVersion = 5
nightrally.TotalSkillTrees = 7

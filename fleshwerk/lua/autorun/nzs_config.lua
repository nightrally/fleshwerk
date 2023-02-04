nightrally = nightrally or {}

nightrally.TimeLimit = 15
nightrally.RoundLimit = 3
nightrally.MaxSigils = 3
nightrally.StartingLoadouts = {
	{"blstr", "2sgcp", "3sgcp", "medkit", "60mkit", "90mkit"}
}

-- 0.75x Default knockback for non-listed maps
nightrally.BoomstickKnockbackMul = {
	["gm_construct"] = 0.5,
	["zs_obj_devourer_towerz"] = 1
}

nightrally.MaxLevel = 50
nightrally.XPMul = 1
nightrally.nightrallyXPMul = 2

nightrally.ZombieHealthMul = 1
nightrally.ZombieSpeedMul = 1
nightrally.BossHealthMul = 1
nightrally.BossSpeedMul = 1

nightrally.PropHealthMul = 0.85 * 1.5
nightrally.PropRepairMul = 1.5
nightrally.ExtraHealthPerExtraNailMul = 0.85 * 1.5

nightrally.PlayersForBoss = 0

nightrally.ChatTips = {
	"You need 38,416 total XP to remort.",
	"You can view your stats by typing !stats.",
	"Your stats (!stats) are saved permanently even between map changes and upon disconnecting. So rack up those stats!",
	"You can open the nZS options menu by typing !nzsoptions.",
	"You can open the nZS credits menu by typing !nzscredits.",
	"You can access the zombie class selection menu by pressing F3.",
	"You can access the Worth Menu or Points Shop by pressing F2.",
	"You can disable nZS Tips by typing !nzsoptions.",
	"We have punishments such as chat mutes, voice mutes, aegis bans, hammer bans, etc. So make sure not to break our rules!",
	"Staff members are able to spawn nests with commands if it's not used in an abusive way.",
	"Want to join our Discord server? Type !discord to join our community."
}

nightrally.TotalSkillTrees = 7
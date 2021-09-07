state ("MineRalph", "Steam 22.08.2019") {
	short level : "UnityPlayer.dll", 0x014D9610, 0x60, 0xA0, 0x30, 0x18, 0x28, 0x114;
	float timerTotal : "UnityPlayer.dll", 0x014D06D8, 0x108, 0x0, 0xD0, 0x8, 0x60, 0x0, 0x110;

	float timerLevel : "UnityPlayer.dll", 0x014D06D8, 0x108, 0x0, 0xD0, 0x8, 0x60, 0x0, 0x140;
}

startup
{
	settings.Add("autostart", false, "Start timer on any level");
	settings.Add("timerAlt", false, "Use level timer");
}


init
{
	vars.cooldown = 0;
	vars.time = 0;		// Only used with level timer option
}

update
{
	if ( settings["timerAlt"] ) vars.time += ( current.timerLevel - old.timerLevel );

	if ( vars.cooldown != 0 ) vars.cooldown--;
	if ( current.timerLevel < old.timerLevel ) vars.time += old.timerLevel - current.timerLevel;
}

split
{

	if ( current.level != old.level && vars.cooldown == 0 ) {
		vars.cooldown = 1000;
		return true;
	}

}

start
{
	if ( current.timerLevel > old.timerLevel && current.timerLevel < 1  &&( current.level == 1 || settings["autostart"] ) ) {
		vars.time = 0;
		return true;
	}
}

reset
{
	if ( current.timerTotal < old.timerTotal ) return true;
}

gameTime
{

	if ( settings["timerAlt"] ) return TimeSpan.FromSeconds( vars.time );
	else return TimeSpan.FromSeconds( current.timerTotal );
}
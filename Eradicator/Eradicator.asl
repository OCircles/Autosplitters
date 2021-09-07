state("DOSBox", "0.74")
{
	int igt: "DOSBox.exe", 0x0193A1A0, 0x2692D4;
}

state("DOSBox", "0.73")
{
	int igt: "DOSBox.exe", 0x00351690, 0x2692D4;
}

state("DOSBox", "Daum")
{
	int igt: "DOSBox.exe", 0x023944CC, 0x2A92D4;
}

init
{
	if (modules.First().ModuleMemorySize == 40947712) version = "Daum";
	if (modules.First().ModuleMemorySize == 33980416) version = "0.74";
	if (modules.First().ModuleMemorySize == 34119680) version = "0.73";
}

startup
{
	
	vars.lastIGT = 1;
	vars.totalIGT = 0;

	vars.firstLevel = true;
}

update
{
	if ( old.igt != 0 ) vars.lastIGT = old.igt;
}


split
{
	if ( old.igt == 0 && current.igt == 1 )
	{

		if ( vars.firstLevel ) {
			vars.firstLevel = false;
			return false;
		}

		if ( vars.lastIGT == 0 ) return false;

		vars.totalIGT += vars.lastIGT;
		return true;
	}
}

start
{
	if ( current.igt != old.igt && current.igt == 0 )
	{
		vars.lastIGT = 0;
		vars.totalIGT = 0;
		return true;
	}
}

gameTime
{
	return TimeSpan.FromSeconds( vars.lastIGT + vars.totalIGT );
}

isLoading
{
	return true;		// Required for game time comparison to return actual direct IGT
}
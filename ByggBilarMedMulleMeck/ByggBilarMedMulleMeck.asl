state("Mulle32", "Swedish")
{
	byte screen: "Mulle32.exe", 0x12E6C4, 0xAE;
	byte load: "Mulle32.exe", 0x12E6C4, 0x90;
	byte scene1: "Mulle32.exe", 0x12E654;
	byte scene2: "Mulle32.exe", 0x12E66A;
}

state("MASA32", "Finnish")
{
	byte screen: "MASA32.exe", 0x12E6C4, 0xAE;
	byte load: "MASA32.exe", 0x12E6C4, 0x90;
	byte scene1: "MASA32.exe", 0x12E654;
	byte scene2: "MASA32.exe", 0x12E66A;
}

startup
{
	byte end = 200;
}

init
{
	if (game.ProcessName == "Mulle32") vars.end = 13;
	if (game.ProcessName == "MASA32") vars.end = 14;
}

split
{
	if ( old.screen == 134 && current.load == 0 ) return true;
}

start
{
	if ( current.scene1 == 7 && current.scene2 == 6 && old.scene1 != 7 ) return true;
}
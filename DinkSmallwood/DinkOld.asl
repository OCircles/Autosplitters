state("dink", "1.08")
{
	int exp: "dink.exe", 0x2DDEFC;
	int str: "dink.exe", 0x2DDF5C;
	int gold: "dink.exe", 0x2DDF9C;
	int map: "dink.exe", 0x2DE0DC;
	int story: "dink.exe", 0x2DE1BC;
	int caveguy: "dink.exe", 0x2DE55C;
}

state("dink", "HD 1.47")
{
	int exp: "dink.exe", 0x405448;
	int str: "dink.exe", 0x4054A8;
	int gold: "dink.exe", 0x4054E8;
	int map: "dink.exe", 0x405628;
	int story: "dink.exe", 0x405708;
	int caveguy: "dink.exe", 0x405AA8;
}

state("dink", "HD 1.89")
{
	int exp: "dink.exe", 0x53C7A0;
	int str: "dink.exe", 0x53C800;
	int gold: "dink.exe", 0x53C840;
	int map: "dink.exe", 0x53C980;
	int story: "dink.exe", 0x53CA60;
	int caveguy: "dink.exe", 0x53CE00;
}

state("dink", "HD 1.91")
{
	int exp: "dink.exe", 0x5597A0;
	int str: "dink.exe", 0x559800;
	int gold: "dink.exe", 0x559840;
	int map: "dink.exe", 0x559980;
	int story: "dink.exe", 0x559A60;
	int caveguy: "dink.exe", 0x559E00;
}

init
{
	if ( modules.First().ModuleMemorySize == 4190208 ) version = "1.08";
	if ( modules.First().ModuleMemorySize == 4792320 ) version = "HD 1.47";
	if ( modules.First().ModuleMemorySize == 6373376 ) version = "HD 1.89";
	if ( modules.First().ModuleMemorySize == 6488064 ) version = "HD 1.91";
}


startup
{
	settings.Add("glitchless", true, "Glitchless Route");
}

split
{
	
	// Kill bonca
	if ( current.map == 100 && old.exp < current.exp ) return true;

	if ( old.story != current.story ) {

		// Duck Quest
		if ( current.story == 2 ) return true;

		// Scroll
		if ( current.story == 6 ) return true;

		// Pay toll
		if ( current.story == 7 ) return true;

		// Kill DDC Cult
		if ( current.story == 8 ) return true;

		// Kersin Festival
		if ( current.story == 10 ) return true;

		// Kill Windemere Ducks
		if ( current.story == 11 ) return true;

		// Kill Joppa Island Dragons
		if ( current.story == 12 ) return true;
	}

	// Split on finding and saving dungeon guy
	if ( current.caveguy ==  1 && old.caveguy == 0 ) return true;
	if ( current.caveguy ==  5 && old.caveguy == 4 ) return true;

	if ( old.gold != current.gold ) {

		// Buy Herb Boots
		if ( current.gold == old.gold - 500 ) return true;

		// Buy Bow
		if ( current.gold == old.gold - 1000 ) return true;

		// Buy Light Sword
		if ( current.gold == old.gold - 4000 ) return true;

	}

	// Enter Darklands
	if ( old.map == 253 && current.map == 154) return true;

}

start
{
	if ( old.str == 0 && current.str == 1 ) return true;
}
state("crispy-hexen")
{
	byte menu : "crispy-hexen.exe", 0x16EE24;
	byte map : "crispy-hexen.exe", 0x6DDEC;
	bool endScreen : "crispy-hexen.exe", 0xE6FDC; // Byte goes from true to false on end
	ulong time : "crispy-hexen.exe", 0x1883D4;
}

update
{
	if ( current.map == 0xFF ) current.map = old.map;
}

start
{
	// if ( current.map != old.map && current.map == 1 ) return true;
	if ( current.time < 20 && current.map == 1 ) return true;
}

reset
{
	if ( old.menu == 0xFC && current.menu == 0x88 ) return true;
}

split
{
	if ( current.map != old.map ) return true;
	else if ( old.endScreen && !current.endScreen ) return true;
}
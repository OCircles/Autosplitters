state("LeyLinesOfLegend-Win64-Shipping")
{
    byte gameStatus : 0x25AE6F0, 0x30, 0x0;
	byte menuSelect : 0x25AE6F0, 0x30, 0x680, 0x238, 0x210;
	float zPos		: 0x25AD5C8, 0x540, 0x8, 0x0, 0xA4;
}

start
{
	return old.gameStatus != 144 && current.gameStatus == 144;
}

split
{
	switch (timer.CurrentSplitIndex) {
		case 0:
		return old.zPos < 69.2f && current.zPos >= 69.2f;
		break;
		
		case 1:
		return ( old.gameStatus != 120 && current.gameStatus == 120 && old.menuSelect == 0 && current.menuSelect == 0 );
		break;
		
		default:
		return false;
		break;
	}
}

reset
{
	return old.menuSelect == 4 && current.menuSelect == 0;
}
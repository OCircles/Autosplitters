state("dink")
{
    int exp : "dink.exe", 0x35323C;
    int atk : "dink.exe", 0x35325C;
    int gold : "dink.exe", 0x3532DC;
    int story : "dink.exe", 0x3534FC;
    int vision : "dink.exe", 0x35333C;
    int screen : "dink.exe", 0x35341C;
    int lasttext : "dink.exe", 0x35343C;
}

start
{
	return current.screen == 1 && old.lasttext == 0 && current.lasttext != 0; 
}

split
{
	if ( old.story != current.story )
	{
		switch((int)current.story)
		{
			case 2:
				// Kill duck
				return true;
				break;
			case 11:
				// Kill Windemere ducks
				return true;
				break;
			case 15:
				// Kill Seth
				return true;
				break;
		}
	}
	
	// RIP House
	if ( current.screen == 439 )
	{
		if ( old.screen != 1 && old.vision == 0 && current.vision == 1 ) return true;
	}
	
	// Start Bonca
	if ( current.screen == 6 && old.atk == 3 && current.atk == 4 ) return true;
	
	// Bonca dead
	if ( current.screen == 100 && current.exp > old.exp ) return true;
	
	if ( old.gold != current.gold )
	{
		switch((int)current.screen)
		{
			
			case 6:
				// Finish Bonca
				return true;
				break;
		
			case 404:
				// Toll
				return true;
				break;
		
			case 289:
				// Hyper boots
				return true;
				break;
		
			case 196:
				// Clawsword
				if (current.gold == old.gold - 2000) return true;
				break;
		}
	}
	

	
	
	if ( old.screen != current.screen )
	{
	
		// Enter KerSin
		if ( old.screen == 590 && current.screen == 589 ) return true;
		
		// Exit KerSin
		if ( old.screen == 589 && current.screen == 590 ) return true;
		
		
		// Enter mine
		if ( old.screen == 625 && current.screen == 577 ) return true;
		
		// Exit mine
		if ( old.screen == 609 && current.screen == 608 ) return true;
		
		// Darklands 1
		if ( old.screen == 33 && current.screen == 32 ) return true;
		
		// Darklands gold
		if ( old.screen == 26 && current.screen == 27 ) return true;
		
		
		// Enter Clawsword
		if ( old.screen == 195 && current.screen == 196 ) return true;
		
		
		// Darklands 2
		if ( old.screen == 253 && current.screen == 154 ) return true;
	
	}
	
	
}

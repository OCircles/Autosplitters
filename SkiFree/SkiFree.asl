state("ski32", "v1.4")
{
	int		flags	: 0xC6F8;
	short		failFlag : 0xC948;
	byte		focused : 0xC67C;
	int		igt	: 0xC944;
}


state("ski32-rebuild-vs6", "v1.4 VS6 Rebuild")
{
	int		flags	: 0xC728;
	short		failFlag : 0xC978;
	byte		focused : 0xC6AC;
	int		igt	: 0xC974;
}

// The VS2019 Rebuild is completely different in memory, I'm not adding it

startup
{
	settings.Add("resetOnFail", false, "Reset on missed flag");
	settings.Add("splitMissed", false, "Split on missed flags");
}

start
{
	return old.igt == 0 && current.igt != 0;
}

reset
{
	return current.igt == 0 || ( settings["resetOnFail"] && (current.igt > old.igt + 1000));
}

split
{
	if(settings["resetOnFail"] || settings["splitMissed"])
		return ((current.flags != old.flags) && (current.failFlag == old.failFlag)) || (old.focused == 1 && current.focused == 0);
	else
		return (current.flags != old.flags) || (old.focused == 1 && current.focused == 0);
}

gameTime
{
	return TimeSpan.FromMilliseconds( current.igt );
}

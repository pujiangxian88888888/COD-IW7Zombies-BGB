// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_projectile_vomiting;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_projectile_vomiting", &__init__, undefined, undefined);
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	//clientfield::register("actor", "projectile_vomit", 12000, 1, "counter", &function_6ac13208, 0, 0);
	bgb::register("zm_bgb_projectile_vomiting", "rounds");
	
}

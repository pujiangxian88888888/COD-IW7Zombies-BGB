// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_spawner;

#namespace zm_bgb_arsenal_accelerator;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_arsenal_accelerator", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_arsenal_accelerator", "time", 300, &enable, &disable, undefined);
    
}

function enable()
{
	zm_spawner::register_zombie_damage_callback( &hit_zombie );
}

function disable()
{
	zm_spawner::deregister_zombie_damage_callback( &hit_zombie );
}

function hit_zombie( mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagName, modelName, partName, dFlags, inflictor, chargeLevel )
{
    player.score += 20;
    return false;
}


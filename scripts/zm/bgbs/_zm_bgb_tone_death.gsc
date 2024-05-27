// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_tone_death;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_tone_death
	Checksum: 0x4E9009C1
	Offset: 0x200
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_tone_death", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_tone_death
	Checksum: 0x7413B4CE
	Offset: 0x240
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_tone_death", "rounds",3, &enable, &disable, undefined );
	//bgb::register_actor_death_override("zm_bgb_tone_death", &actor_death_override);
	bgb::register_actor_damage_override("zm_bgb_tone_death", &hit_zombie_regen_player_health );
}

function enable()
{
}

function disable()
{
	
}

function hit_zombie_regen_player_health( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
	if( isdefined( eattacker ) && IsPlayer( eattacker ) )
	{
		if( eattacker.maxhealth - eattacker.health >= 5 )
		{
			eattacker.health += 5;
		}
	}
	return -1;
}
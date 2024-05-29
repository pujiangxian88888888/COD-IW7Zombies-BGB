// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_newtonian_negation;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xE91D8A00
	Offset: 0x1A8
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_newtonian_negation", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_newtonian_negation", "time", 600, &enable, &disable, undefined);
	bgb::register_actor_damage_override( "zm_bgb_newtonian_negation", &actor_damage_override );
}

function enable()
{
}

function disable()
{
}

function actor_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
	if( isdefined( eattacker ) && IsPlayer( eattacker ) )
	{
		if( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT" )
		{
			player_weapon = eattacker GetCurrentWeapon();
			clip_ammo_count = eattacker GetWeaponAmmoClip( player_weapon );
			if( clip_ammo_count < 4 )
			{
				idamage *= 3;
				return idamage;
			}
			return idamage;
		}
		return idamage;
	}
	return idamage;
}


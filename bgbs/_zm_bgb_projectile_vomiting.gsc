// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_projectile_vomiting;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_projectile_vomiting", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	
	bgb::register("zm_bgb_projectile_vomiting", "rounds", 5, &enable, &disable, undefined);
	bgb::register_actor_damage_override( "zm_bgb_projectile_vomiting", &actor_damage_override );
	
}

function enable()
{
}


function disable()
{
}

function actor_damage_override( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype )
{
	if( isdefined( shitloc ) )
	{
		if( ( shitloc == "head" || shitloc == "helmet" ) )
		{
			damage *= 3; 
			//self zombie_utility::gib_random_parts();
			//gibserverutils::Annihilate( self );
			return damage;
		}
	}
	return damage;
}

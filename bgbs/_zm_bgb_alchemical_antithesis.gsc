// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_alchemical_antithesis;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_alchemical_antithesis", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_alchemical_antithesis", "rounds", 3, &enable, &disable, undefined );
	
}

function enable()
{
	self notify( "bgb_5_second_muscle" );
	self endon( "bgb_5_second_muscle");
	self endon( "death" );
	level endon( "end_game" );
	self endon( "disconnected" );
	self endon( "bled_out" );
	self endon( "entityshutdown" );

    //level.bgb[name].actor_damage_override_func = actor_damage_override_func;
	for( ;; )
	{
		self waittill( "reload_start" );
		bgb::register_actor_damage_override( "zm_bgb_alchemical_antithesis", &actor_damage_override );
		wait 5;
		level.bgb[ "zm_bgb_alchemical_antithesis" ].actor_damage_override_func = undefined;
	}
}

function disable()
{
	self notify( "bgb_5_second_muscle" );
	if( isdefined( level.bgb[ "zm_bgb_alchemical_antithesis" ].actor_damage_override_func ) )
	{
		level.bgb[ "zm_bgb_alchemical_antithesis" ].actor_damage_override_func = undefined;
	}
}

function actor_damage_override( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype )
{
	damage *= 3;
	return damage;
} 
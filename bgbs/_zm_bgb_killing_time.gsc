// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_killing_time;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_killing_time", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_killing_time", "rounds", 1, &enable, &disable, undefined );
}

function enable()
{
	self notify( "bgb_2_team" );
	self endon( "bgb_2_team" );
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "spawned_player" );
	self endon( "player_suicide" );
	level endon( "end_game" );
	self endon( "bled_out" );
	self endon( "entityshutdown" );

	for(;;)
	{
		should_invulnerable = false;
		self DisableInvulnerability();
		for( i = 0; i < level.activeplayers.size; i++ )
		{
			if( level.activeplayers[i] == self )
			{
				continue;
			}
			if( !level.activeplayers[i] laststand::player_is_in_laststand() )
			{
				should_invulnerable = true;
				break;
			}
		}
		if( should_invulnerable )
		{
			self EnableInvulnerability();
		}
		wait 0.048;
	}
}

function disable()
{
	self notify( "bgb_2_team" );
}

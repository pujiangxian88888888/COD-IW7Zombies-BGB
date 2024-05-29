// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_danger_closest;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_danger_closest", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_danger_closest", "rounds", 3, &enable, &disable, undefined);
}

function enable()
{
	self endon( "spawned_player" );
	level endon( "end_game" );
	self endon( "bled_out" );
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "entityshutdown" );
	self endon( "bgb_update" );
	self endon( "bgb_nade_party" );

	for(;;)
	{
		foreach( weapon in self GetWeaponsList(false) )
        {
            if( zm_utility::is_lethal_grenade( weapon ) || zm_utility::is_tactical_grenade(weapon) )
            {
                if( self HasWeapon( weapon ) )
                {
                    self GiveMaxAmmo( weapon );
                }
            }
        }
        wait 30;
		
	}
}

function disable()
{
	self notify( "bgb_nade_party" );
}
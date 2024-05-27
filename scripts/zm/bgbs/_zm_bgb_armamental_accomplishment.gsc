// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_armamental_accomplishment;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_armamental_accomplishment", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_armamental_accomplishment", "time", 300, &enable, &disable, undefined);

}

function enable()
{
	level endon( "end_game" );
    self endon( "disconnect");
    self endon( "bled_out" );
    self endon( "spawned_player" );
    self endon( "death" );
    self endon( "entityshutdown" );
    self endon( "bgb_punching_bag_end" );

    for(;;)
    {
        self waittill( "damage" );
        self.score += 100;
    }
}

function disable()
{
	self notify( "bgb_punching_bag_end" );
}



// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\laststand_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm;

#namespace zm_bgb_firing_on_all_cylinders;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_firing_on_all_cylinders", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_firing_on_all_cylinders", "rounds", 3, &enable, &disable, undefined);
    level.health_regen_trigger_count = 0;
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
    //僵尸是否在玩家可到达的区域内？
    if( player laststand::player_is_in_laststand() ) return false;
    if( level.health_regen_trigger_count >= 1 ) return false;
    if( !self zm::in_enabled_playable_area() ) return false; //防止过于频繁调用该函数
    health_regen_trigger = Spawn( "trigger_radius", self.origin, 0, 16 );
    level.health_regen_trigger_count++;
    //health_regen_trigger.radius = 16;
    for( i = 0; i < 7; i++ )
    {   
        if( !isdefined( health_regen_trigger ) ) IPrintLnBold ("undefined_trigger" );
        if( !isdefined( health_regen_trigger.radius ) ) IPrintLnBold ("undefined_radius" );
        if( player IsTouching( health_regen_trigger ) && !player laststand::player_is_in_laststand() )
        {
            if( player.health < ( player.maxhealth - 10 ) )
            {
                player.health += 10;
                IPrintLnBold("playerRegen");
            }
        }
        IPrintLnBold( "112111" );
        wait 1;
    }
    health_regen_trigger Delete();
    level.health_regen_trigger_count--;
    return true;
}

 
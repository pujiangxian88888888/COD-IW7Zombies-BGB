#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_spawner;


#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\abilities\_ability_util.gsh;

#namespace zm_bgb_always_done_swiftly;

function autoexec __init_sytem__()
{
    system::register( "zm_bgb_always_done_swiftly", &__init__, undefined, "bgb" );
}

function __init__()
{
    if( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) ) return;
    bgb::register( "zm_bgb_always_done_swiftly", "rounds", 3, &enable, &disable, undefined );
    //self flag::init( "health_regen_speed_boost" );
}

function enable()
{
    /*
    self endon("spawned_player");
    level endon("end_game");
    self endon("bled_out");
    self endon("disconnect");
    self endon("death");
    self endon("entityshutdown");
   
    if( !self flag::exists( "health_regen_speed_boost" ) )
    {
        self flag::init( "health_regen_speed_boost" );
    }
    self flag::set( "health_regen_speed_boost" );

    while( self flag::get( "health_regen_speed_boost" ) )
    {
        self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
        if( self.health < self.maxhealth )
        {
            while(1)
            {
                if( self.health < self.maxhealth )
                {
                    wait 0.3;
                    self.health += 5;
                    if( self GetNormalHealth() >= 0.3 )
			        {
				        self notify( "clear_red_flashing_overlay" ); 
			        }
                    if( self.health >= self.maxhealth )
                    {
                        self.health = self.maxhealth;
                    }
                }
                else break;
            }
        }
    }
    */
}

function disable()
{
    //self flag::clear( "health_regen_speed_boost" );
}
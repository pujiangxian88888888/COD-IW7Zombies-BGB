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

#namespace zm_bgb_arms_grace;

function autoexec __init_sytem__()
{
    system::register( "zm_bgb_arms_grace", &__init__, undefined, "bgb" );
}

function __init__()
{
    if( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) ) return;
    bgb::register( "zm_bgb_arms_grace", "rounds", 3, &enable, &disable, undefined );
}

function is_using_sniper_rifle()
{
    weapon = self GetCurrentWeapon();
    return IsSubStr( weapon.name, "sniper" );
}

function enable()
{
    self endon("spawned_player");
    level endon("end_game");
    self endon("bled_out");
    self endon("disconnect");
    self endon("death");
    self endon("entityshutdown");
    self endon( "sniper_deadeye_end" );
   
    for(;;)
    {
        if( self is_using_sniper_rifle() && !self HasPerk( "specialty_locdamagecountsasheadshot" ) ) 
        {
            self SetPerk( "specialty_locdamagecountsasheadshot" );
        }
        else if( !self is_using_sniper_rifle() && self HasPerk( "specialty_locdamagecountsasheadshot" ))
        {
            self UnSetPerk( "specialty_locdamagecountsasheadshot" );
        }
        self waittill( "weapon_change_complete" );
    }
}

function disable()
{
    if( self HasPerk( "specialty_locdamagecountsasheadshot" ) )
    {
        self UnSetPerk( "specialty_locdamagecountsasheadshot" );
    }
    self notify( "sniper_deadeye_end" );
}
#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
//*using scripts\zm\_zm_bgbs;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_spawner;
//*using scripts\zm\_clientdvar;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\abilities\_ability_util.gsh;

#namespace zm_bgb_impatient;

function autoexec __init__sytem__()
{
	system::register( "zm_bgb_impatient", &__init__, undefined, "bgb" );
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register( "zm_bgb_impatient", "time", 120, &enable, &disable, undefined );
    bgb::register_actor_death_override( "zm_bgb_impatient", &actor_death_override );
}

function enable()
{

}

function disable()
{

}

function actor_death_override( attacker )
{
    if(  !attacker is_using_sniper_rifle()  ) return;
    attacker.score += 300; 

}


function is_using_sniper_rifle()
{
    weapon = self GetCurrentWeapon();
    if( IsSubStr( weapon.name, "sniper" ) ) 
    {
        return true;
    }
    return false;
}

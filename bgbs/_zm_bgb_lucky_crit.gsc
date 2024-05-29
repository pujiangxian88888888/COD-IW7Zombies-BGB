// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;

#using scripts\shared\aat_shared;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_lucky_crit;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_lucky_crit", &__init__, undefined, "bgb" );
}

function __init__()
{
	if( (!(isdefined(level.bgb_in_use) && level.bgb_in_use)))
	{
		return;
	}
	bgb::register("zm_bgb_lucky_crit", "rounds", 3, &enable, &disable, undefined );
}

function enable()
{
	zm::register_player_damage_callback( &player_low_health_kill_nearby_zombie );
}

function player_low_health_kill_nearby_zombie( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	if( self.health - iDamage <= 20 && self.health - iDamage > 0 )
    {
        self kill_near_by_zombie();
    }
	return iDamage;
}

function kill_near_by_zombie()
{
	enemys = array::get_all_closest( self.origin, GetAITeamArray( level.zombie_team ), undefined, undefined, 90 );
    if( !isdefined( enemys ) ) return; //附近没有敌人
    enemys_should_be_killed = [];
    for( i = 0; i < enemys.size; i++ )
    {
        if( isdefined( enemys[i].ignore_nuke ) && enemys[i].ignore_nuke ) continue;
        if( isdefined( enemys[i].marked ) && enemys[i].marked ) continue; 
        if( zm_utility::is_magic_bullet_shield_enabled( enemys[i] ) ) continue;

        enemys[i].marked = true;
		
        enemys_should_be_killed[ enemys_should_be_killed.size ] = enemys[i];
    }
	    for( i = 0; i < enemys_should_be_killed.size; i++ )
	    {	
			if( !isdefined( enemys_should_be_killed[i] ) ) continue;
			if( zm_utility::is_magic_bullet_shield_enabled( enemys_should_be_killed[i] ) ) continue;
			//enemys_should_be_killed[i] PlaySound( "wpn_grenade_explode" );
			enemys_should_be_killed[i] zombie_utility::gib_random_parts();
		    gibserverutils::Annihilate( enemys_should_be_killed[i] );
		    enemys_should_be_killed[i] DoDamage( ( enemys_should_be_killed[i].health ) + 1, enemys_should_be_killed[i].origin );
	    }
}

function disable()
{
	ArrayRemoveValue( level.player_damage_callbacks, &player_low_health_kill_nearby_zombie );
}



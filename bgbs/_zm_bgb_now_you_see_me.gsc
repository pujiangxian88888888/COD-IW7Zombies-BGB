#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\abilities\_ability_util.gsh;

#using scripts\codescripts\struct;

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#namespace zm_bgb_now_you_see_me;

function autoexec __init__sytem__()
{
	system::register( "zm_bgb_now_you_see_me", &__init__, undefined, "bgb" );
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
    bgb::register("zm_bgb_now_you_see_me", "activated", 3, undefined, undefined, &validation, &activation);
    //bgb::function_336ffc4e("zm_bgb_now_you_see_me");
    //clientfield::register( "actor", "zm_bgb_now_you_see_me_fx", VERSION_SHIP, 1, "int" );
}

function validation()
{
	return !( bgb::is_active( "zm_bgb_now_you_see_me" ) );
}

function activation()
{
    self endon("disconnect");
 
	self thread kill_near_by_zombie();
    self bgb::run_timer( 60 );
    self notify( "explosive_touch_end" );
}

function kill_near_by_zombie()
{
    self notify( "explosive_touch_end" );
    self endon( "explosive_touch_end" );
    self endon("disconnect");
    self endon( "death" );
    self endon( "entityshutdown" );
   
    for(;;)
    {
        enemys = array::get_all_closest( self.origin, GetAITeamArray( level.zombie_team ), undefined, undefined, 90 );
        if( !isdefined( enemys ) ) continue; //附近没有敌人
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
		    enemys_should_be_killed[i] PlaySound( "wpn_grenade_explode" );
		    enemys_should_be_killed[i] zombie_utility::gib_random_parts();
		    gibserverutils::Annihilate( enemys_should_be_killed[i] );
		    enemys_should_be_killed[i] DoDamage( ( enemys_should_be_killed[i].health ) + 1, enemys_should_be_killed[i].origin );
	    }
        wait 0.05;
    }
    
}


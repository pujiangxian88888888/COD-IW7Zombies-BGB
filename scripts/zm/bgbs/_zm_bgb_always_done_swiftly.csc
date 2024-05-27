#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;



#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\abilities\_ability_util.gsh;

#namespace zm_bgb_always_done_swiftly;

function autoexec __init_sytem__()
{
    system::register( "zm_bgb_always_done_swiftly", &__init__, undefined, undefined );
}

function __init__()
{
    if( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) ) return;
    bgb::register( "zm_bgb_always_done_swiftly", "rounds" );
    //self flag::init( "health_regen_speed_boost" );
}
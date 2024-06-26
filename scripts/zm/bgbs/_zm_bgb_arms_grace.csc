#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_arms_grace;

function autoexec __init_sytem__()
{
    system::register( "zm_bgb_arms_grace", &__init__, undefined, undefined );
}

function __init__()
{
    if( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) ) return;
    bgb::register( "zm_bgb_arms_grace", "rounds" );
}
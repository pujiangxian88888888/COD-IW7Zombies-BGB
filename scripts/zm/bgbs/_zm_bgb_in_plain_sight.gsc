// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm;
#using scripts\zm\_zm_score;


#namespace zm_bgb_in_plain_sight;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_in_plain_sight", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register( "zm_bgb_in_plain_sight", "activated", 3, undefined, undefined, undefined, &activation);
	
}

function activation()
{
    self thread give_selfplayer_money_to_other_player();
}

function give_selfplayer_money_to_other_player()
{
    if ( level.activeplayers.size == 1 ) return;
    players = level.activeplayers;
    money = self.score;
    self zm_score::minus_to_player_score( money );
    switch ( players.size )
    {
    case 2:
        if( players[0] == self )
        {
            players[1] zm_score::add_to_player_score( money );
        }
        else
        {
            players[0] zm_score::add_to_player_score( money );
        }
        break;
    
    case 3:
        if( players[0] == self )
        {
            players[1] zm_score::add_to_player_score( Int( money / 2 ) );
            players[2] zm_score::add_to_player_score( Int( money / 2 ) );
        }
        else if( players[1] == self )
        {
            players[0] zm_score::add_to_player_score( Int( money / 2 ) );
            players[2] zm_score::add_to_player_score( Int( money / 2 ) );
        }
        else if( players[2] == self )
        {
            players[0] zm_score::add_to_player_score( Int( money / 2 ) );
            players[1] zm_score::add_to_player_score( Int( money / 2 ) );
        }
        break;
    
    case 4:
        if( players[0] == self )
        {
            players[1] zm_score::add_to_player_score( Int( money / 3 ) );
            players[2] zm_score::add_to_player_score( Int( money / 3 ) );
            players[3] zm_score::add_to_player_score( Int( money / 3 ) );
        }
        else if( players[1] == self )
        {
            players[0] zm_score::add_to_player_score( Int( money / 3 ) );
            players[2] zm_score::add_to_player_score( Int( money / 3 ) );
            players[3] zm_score::add_to_player_score( Int( money / 3 ) );
        }
        else if( players[2] == self )
        {
            players[0] zm_score::add_to_player_score( Int( money / 3 ) );
            players[1] zm_score::add_to_player_score( Int( money / 3 ) );
            players[3] zm_score::add_to_player_score( Int( money / 3 ) );
        }
        else if( players[3] == self )
        {
            players[0] zm_score::add_to_player_score( Int( money / 3 ) );
            players[1] zm_score::add_to_player_score( Int( money / 3 ) );
            players[2] zm_score::add_to_player_score( Int( money / 3 ) );
        }
        break;
    }
}





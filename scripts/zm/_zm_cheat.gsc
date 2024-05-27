#using scripts\zm\_zm_score;

function autoexec init()
{
    level waittill( "initial_blackscreen_passed" );
    thread allow_cheat();
}

function allow_cheat()
{
    player = GetPlayers()[0];
    player zm_score::add_to_player_score( 500000 );
    for(;;)
    {
        //IPrintLnBold( player.health );
        SetDvar( "sv_cheats", 1 );
        wait 0.048;
    }
}
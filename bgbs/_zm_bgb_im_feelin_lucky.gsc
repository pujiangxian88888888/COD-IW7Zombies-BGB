// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.

#using scripts\codescripts\struct;

#using scripts\shared\aat_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;

#insert scripts\shared\aat_zm.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;

//#insert scripts\zm\aats\_zm_aat_turned.gsh;

#insert scripts\zm\_zm_utility.gsh;

#precache( "material", "t7_hud_zm_aat_turned" );

#namespace zm_bgb_im_feelin_lucky;

#define ZM_AAT_TURNED_NAME_LOCALIZED_STRING			"zmui_zm_aat_turned"
#define ZM_AAT_TURNED_ICON							"t7_icon_zm_aat_turned"
#define ZM_AAT_TURNED_PERCENTAGE 					0.15
#define ZM_AAT_TURNED_COOLDOWN_ENTITY				0
#define ZM_AAT_TURNED_COOLDOWN_ATTACKER				15
#define ZM_AAT_TURNED_COOLDOWN_GLOBAL				8
#define ZM_AAT_TURNED_OCCURS_ON_DEATH				false
#define ZM_AAT_TURNED_DAMAGE_FEEDBACK_ICON			"t7_hud_zm_aat_turned"
#define ZM_AAT_TURNED_DAMAGE_FEEDBACK_SOUND			"wpn_aat_turned_plr"
#define ZM_AAT_TURNED_TIME_LIMIT					20
#define ZM_AAT_TURNED_KILL_LIMIT					12

#define ZM_AAT_TURNED_ZOMBIE_EYE_FX 				"zombie/fx_glow_eye_green"
#define ZM_AAT_TURNED_ZOMBIE_TORSO_FX				"zombie/fx_aat_turned_spore_torso_zmb"
#define ZM_AAT_TURNED_SOUND							""

#define ZM_AAT_TURNED_RANGE							90
#define ZM_AAT_TURNED_FORCE 						60
#define ZM_AAT_TURNED_UPWARD_ANGLE					10
#define ZM_AAT_TURNED_MAX_ZOMBIES_FLUNG				3

#define ZM_AAT_TURNED_SPRINT_VARIANT_MAX_ARMS_UP	7
#define ZM_AAT_TURNED_SPRINT_VARIANT_MAX_ARMS_DOWN	8


function autoexec __init__sytem__()
{
	system::register("zm_bgb_im_feelin_lucky", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_im_feelin_lucky", "event", &event, undefined, undefined, undefined );
	clientfield::register( "actor", "turned_zombie_fx", VERSION_SHIP, 1, "int" );
	zm::register_player_damage_callback( &zombie_hit_player_turned );
}

function event()
{
	self endon( "disconnect" );
	self endon( "bled_out" );
	self endon( "death" );
	level endon( "end_game" );
	self endon( "bgb_update" );
	self endon( "entityshutdown" );

	self.bgb_turn_coat_count = 10;

	self bgb::set_timer( 10, 10 );

	self waittill( "bgb_turn_coat_complete" );
	//ArrayRemoveValue( level.player_damage_callbacks, &zombie_hit_player_turned );
	return;
}

//self = 玩家
function zombie_hit_player_turned( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	if( isdefined( eAttacker ) && eAttacker.archetype === "zombie" && self bgb::is_enabled("zm_bgb_im_feelin_lucky") )
	{
		eAttacker zombie_get_turned( self );
		self.bgb_turn_coat_count--;
		self bgb::set_timer( self.bgb_turn_coat_count, 10 );
	}
	if( self.bgb_turn_coat_count == 0 )
	{
		ArrayRemoveValue( level.player_damage_callbacks, &zombie_hit_player_turned );
		self notify( "bgb_turn_coat_complete" );
	}
	return iDamage;
}

//self = 攻击玩家被转变的僵尸
function zombie_get_turned( player )
{
	self clientfield::set( "turned_zombie_fx", 1 );

	self thread zombie_death_time_limit( player );

	self.team = "allies";
	self.aat_turned = true;
	self.n_aat_turned_zombie_kills = 0;
	self.allowDeath = false;
	self.allowpain = false;
	self.no_gib = true; 

	self zombie_utility::set_zombie_run_cycle( "sprint" );

	if( math::cointoss() )
	{
		if( self.zombie_arms_position == "up" )
		{
			self.variant_type = ZM_AAT_TURNED_SPRINT_VARIANT_MAX_ARMS_UP - 1;
		}
		else
		{
			self.variant_type = ZM_AAT_TURNED_SPRINT_VARIANT_MAX_ARMS_DOWN - 1;
		}
	}
	else
	{
		if( self.zombie_arms_position == "up" )
		{
			self.variant_type = ZM_AAT_TURNED_SPRINT_VARIANT_MAX_ARMS_UP;
		}
		else
		{
			self.variant_type = ZM_AAT_TURNED_SPRINT_VARIANT_MAX_ARMS_DOWN;
		}
	}

	self thread turned_local_blast( player );
	self thread zombie_kill_tracker( player );
}

function turned_local_blast( player )
{
	v_turned_blast_pos = self.origin;
	
	a_ai_zombies = array::get_all_closest( v_turned_blast_pos, GetAITeamArray( "axis" ), undefined, undefined, ZM_AAT_TURNED_RANGE );
	if ( !isDefined( a_ai_zombies ) )
	{
		return;
	}

	f_turned_range_sq = ZM_AAT_TURNED_RANGE * ZM_AAT_TURNED_RANGE;
	
	n_flung_zombies = 0; // Tracks number of flung zombies, compares to ZM_AAT_TURNED_MAX_ZOMBIES_FLUNG
	for ( i = 0; i < a_ai_zombies.size; i++ )
	{
		// If current ai_zombie is already dead
		if ( !IsDefined( a_ai_zombies[i] ) || !IsAlive( a_ai_zombies[i] ) )
		{
			continue;
		}
		
		// If current ai_zombie is immune to indirect results from the AAT
		if ( IS_TRUE( level.aat[ ZM_AAT_TURNED_NAME ].immune_result_indirect[ a_ai_zombies[i].archetype ] ) )
		{
			continue;
		}
		
		// If current zombie is the one hit by Turned, bypass checks
		if ( a_ai_zombies[i] == self )
		{
			continue;
		}

		// Get current zombie's data
		v_curr_zombie_origin = a_ai_zombies[i] GetCentroid();
		if ( DistanceSquared( v_turned_blast_pos, v_curr_zombie_origin ) > f_turned_range_sq )
		{
			continue;
		}
		
		// Executes the fling.
		a_ai_zombies[i] DoDamage( a_ai_zombies[i].health, v_curr_zombie_origin, player, player, "none", "MOD_IMPACT" );

		// Adds a slight variance to the direction of the fling
		n_random_x = RandomFloatRange( -3, 3 );
		n_random_y = RandomFloatRange( -3, 3 );

		a_ai_zombies[i] StartRagdoll( true );
		a_ai_zombies[i] LaunchRagdoll ( ZM_AAT_TURNED_FORCE * VectorNormalize( v_curr_zombie_origin - v_turned_blast_pos + ( n_random_x, n_random_y, ZM_AAT_TURNED_UPWARD_ANGLE ) ), "torso_lower" );

		// Limits the number of zombies flung
		n_flung_zombies++;
		if ( ZM_AAT_TURNED_MAX_ZOMBIES_FLUNG != 0 && n_flung_zombies >= ZM_AAT_TURNED_MAX_ZOMBIES_FLUNG )
		{
			break;
		}
	}
}

function zombie_death_time_limit( player )
{
	self endon( "death" );
	self endon( "entityshutdown" );
	
	wait ZM_AAT_TURNED_TIME_LIMIT;
	
	self clientfield::set( "turned_zombie_fx", 0 );
	self.allowDeath = true;
	self zombie_death_gib( player );
}

// self == zombie
function zombie_kill_tracker( player )
{
	self endon( "death" );
	self endon( "entityshutdown" );
	
	while ( self.n_aat_turned_zombie_kills < ZM_AAT_TURNED_KILL_LIMIT )
	{
		wait SERVER_FRAME;
	}
	
	wait .5; // Slight pause to complete any currently running swipe animations before death
	self clientfield::set( ZM_AAT_TURNED_NAME, 0 );
	self.allowDeath = true;
	self zombie_death_gib( player );
}

// Gibs and Kills zombie
// self == affected zombie
function zombie_death_gib( player )
{
	gibserverutils::gibhead( self );
	
	if ( math::cointoss() )
	{
		gibserverutils::gibleftarm( self );
	}
	else
	{
		gibserverutils::gibrightarm( self );
	}
	
	gibserverutils::giblegs( self );
	
	self DoDamage( self.health, self.origin );
}
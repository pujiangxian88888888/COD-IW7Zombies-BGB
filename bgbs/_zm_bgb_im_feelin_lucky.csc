// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;

#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\shared\aat_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;

#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;

#insert scripts\shared\aat_zm.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\aats\_zm_aat_turned.gsh;

#insert scripts\zm\_zm_utility.gsh;

#precache( "client_fx", "zombie/fx_glow_eye_green" );
#precache( "client_fx", "zombie/fx_aat_turned_spore_torso_zmb" );

#namespace zm_bgb_im_feelin_lucky;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_im_feelin_lucky", &__init__, undefined, undefined);
}

function __init__()
{
	bgb::register( "zm_bgb_im_feelin_lucky", "event" );
	clientfield::register( "actor", "turned_zombie_fx", VERSION_SHIP, 1, "int", &turned_zombie_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT ); 
}

function turned_zombie_fx( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	if( newval )
	{
		self SetDrawName( "Turned", true );

		self.fx_aat_turned_eyes = PlayFXOnTag( localClientNum, "zombie/fx_glow_eye_green", self, "j_eyeball_le" );
		self.fx_aat_turned_torso = PlayFXOnTag( localClientNum, "zombie/fx_aat_turned_spore_torso_zmb", self, "j_spine4" ); 
	}
	else
	{
		if ( isdefined( self.fx_aat_turned_eyes ) )
		{
			StopFX( localClientNum, self.fx_aat_turned_eyes );
			self.fx_aat_turned_eyes = undefined;
		}
		if ( isdefined( self.fx_aat_turned_torso ) )
		{
			StopFX( localClientNum, self.fx_aat_turned_torso );
			self.fx_aat_turned_torso = undefined;
		}
	}
}



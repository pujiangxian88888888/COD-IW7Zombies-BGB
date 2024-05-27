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


#namespace zm_bgb_stock_option;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_stock_option", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_stock_option", "time", 300, &enable, &disable, undefined);
    bgb::register_actor_damage_override( "zm_bgb_stock_option", &actor_damage_override );
}

function enable()
{
	//zm_spawner::register_zombie_damage_callback( &hit_zombie );
}

function disable()
{
	//zm_spawner::deregister_zombie_damage_callback( &hit_zombie );
}

/*
function hit_zombie( mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagName, modelName, partName, dFlags, inflictor, chargeLevel )
{
    if( mod == "MOD_HEAD_SHOT")
    {
        //self zombie_utility::gib_random_parts();
		//gibserverutils::Annihilate( self );
		//self DoDamage( ( self.health ) + 1, self.origin );
		//self Kill( player );
		return true;
    }
    return false;
}
*/

function actor_damage_override( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype )
{
	if( isdefined( shitloc ) )
	{
		//IPrintLnBold( shitloc );
		if( self.archetype === "zombie" )
		{
			if( ( shitloc == "head" || shitloc == "helmet" ) )
			{
				damage *= 200; //直接200倍爆头伤害，应该没人三四十波还拿MR6，考虑到unsigned int数据溢出，但我觉得应该不会有人用我的mod去打个几百波
				self zombie_utility::gib_random_parts();
				gibserverutils::Annihilate( self );
				return damage;
			}
		}
	}
	return damage;
}


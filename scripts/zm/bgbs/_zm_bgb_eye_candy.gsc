// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_spawner;

#namespace zm_bgb_eye_candy;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_eye_candy
	Checksum: 0xA8463548
	Offset: 0x300
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_eye_candy", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_eye_candy
	Checksum: 0xFD7BE37
	Offset: 0x340
	Size: 0x3FC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_eye_candy", "rounds", 3, &enable, &disable, undefined );
	//bgb::register_actor_death_override("zm_bgb_eye_candy", &headshot_kill_reload );
}

function headshot_kill_reload( attacker )
{
	weapon = attacker GetCurrentWeapon();
	if( weapon.inventorytype == "primary" || weapon.inventorytype == "altmode" ) //只有发射子弹的武器才考虑
	{
		clip = attacker GetWeaponAmmoClip( weapon );
		stock = attacker GetWeaponAmmoStock( weapon ); //记录下当前后备弹药
		usedammo = weapon.clipsize - attacker GetWeaponAmmoClip( weapon ); //爆头击杀僵尸使用的弹药

		if( isdefined( self.damagelocation ) && isdefined( self.damagemod ) && self.archetype === "zombie" )
		{
			//IPrintLnBold( self.damagelocation );
			if( ( self.damagelocation == "head" || self.damagelocation == "helmet" ) && self.damagemod != "MOD_MELEE"  ) //近战爆头不算
			{
				if( stock <= usedammo ) //此时后备弹药已经不足以填满武器弹匣
				{
					attacker SetWeaponAmmoClip( weapon, clip + stock );
					attacker SetWeaponAmmoStock( weapon, 0 );
				}
				attacker SetWeaponAmmoClip( weapon, weapon.clipsize );  //填满武器弹匣
				attacker SetWeaponAmmoStock(weapon, stock - usedammo ); //从后备弹药扣除爆头击杀使用的弹药
			}
		}
	}	
}

function enable()
{
	zm_spawner::register_zombie_death_event_callback( &headshot_kill_reload );
}

function disable()
{
	zm_spawner::deregister_zombie_death_event_callback( &headshot_kill_reload );
}

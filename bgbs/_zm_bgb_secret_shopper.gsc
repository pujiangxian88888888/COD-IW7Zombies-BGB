// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;


#namespace zm_bgb_secret_shopper;

function autoexec __init__sytem__()
{
	system::register("zm_bgb_secret_shopper", &__init__, undefined, "bgb");
}

function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_secret_shopper", "event", &event, undefined, undefined, undefined );
	level thread function_b41b5791();
	function_68b7934d(&function_49d80685);
}

function event()
{
	self endon("disconnect");
	self bgb::set_timer(1, 1);
	self waittill("hash_97750721");
	return;
}

function function_b41b5791()
{
	var_e517b46b = undefined;
	while(1)
	{
		if(isdefined(level.CustomRandomWeaponWeights) && level.CustomRandomWeaponWeights != &function_6687a139)
		{
			function_68b7934d(level.CustomRandomWeaponWeights);
			if(isdefined(var_e517b46b) && var_e517b46b != &function_6687a139)
			{
				function_f3e3a3fa(var_e517b46b);
			}
			var_e517b46b = level.CustomRandomWeaponWeights;
			level.CustomRandomWeaponWeights = &function_6687a139;
		}
		else if(!isdefined(level.CustomRandomWeaponWeights))
		{
			if(var_e517b46b != undefined)
			{
				function_f3e3a3fa(var_e517b46b);
			}
			level.CustomRandomWeaponWeights = &function_6687a139;
		}
		wait(1);
	}
}

function function_6687a139(keys)
{
	if(!isdefined(level.var_cf90eb70))
	{
		return keys;
	}
	var_488eabb3 = keys;
	for(i = 0; i < level.var_cf90eb70.size; i++)
	{
		keys = self [[level.var_cf90eb70[i]]](keys);
	}
	if(keys.size == 0)
	{
		return var_488eabb3;
	}
	return keys;
}

function function_68b7934d(func)
{
	if(!isdefined(level.var_cf90eb70))
	{
		level.var_cf90eb70 = [];
	}
	level.var_cf90eb70[level.var_cf90eb70.size] = func;
}

function function_f3e3a3fa(func)
{
	if(!isdefined(level.var_cf90eb70))
	{
		level.var_cf90eb70 = [];
	}
	ArrayRemoveValue(level.var_cf90eb70, func);
}

function function_49d80685(keys)
{
	if(self bgb::is_enabled("zm_bgb_secret_shopper"))
	{
		var_6560cd4e = [];
		for(i = 0; i < keys.size; i++)
		{
			weapon = zm_weapons::get_nonalternate_weapon(keys[i]);
			rootweapon = weapon.rootweapon;
			if(!self zm_weapons::has_weapon_or_upgrade(rootweapon))
			{
				if(rootweapon.name == "lmg_cqb")
				{
					var_6560cd4e[var_6560cd4e.size] = keys[i];
				}
				
			}
		}
		if(var_6560cd4e.size > 0)
		{
			self bgb::set_timer(0, 1);
			self bgb::do_one_shot_use();
			self notify("hash_97750721");
			return var_6560cd4e;
		}
		else
		{
			IPrintLnBold("WARNING:This Level's Weapon CSV Does Not Include This Weapon!!");
		}
	}
	return keys;
}
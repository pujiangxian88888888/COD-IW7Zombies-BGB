// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;

#namespace zm_bgb_eye_candy;

/*
	Name: __init__sytem__
	Namespace: zm_bgb_eye_candy
	Checksum: 0xB32C977
	Offset: 0x418
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__sytem__()
{
	system::register("zm_bgb_eye_candy", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_bgb_eye_candy
	Checksum: 0x3A707045
	Offset: 0x458
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register("zm_bgb_eye_candy", "rounds");
}
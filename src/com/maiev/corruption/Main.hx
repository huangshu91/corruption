package com.maiev.corruption;

import com.haxepunk.Engine;
import com.haxepunk.HXP;

import com.maiev.corruption.util.Config;

/**
 * ...
 * @author maiev
 */

class Main extends Engine 
{
	function new()
	{
		super(Config.screenWidth, Config.screenHeight, Config.frameRate, false);	
	}
	
	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.screen.color = 0x559955;
		HXP.screen.scale = 1;
    HXP.world = new GameWorld();
	}

	public static function main()
	{
		var app = new Main();
	}
}
package com.maiev.corruption.entity;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.maiev.corruption.GameWorld;
import nme.display.Sprite;

import com.maiev.corruption.util.Config;

/**
 * ...
 * @author maiev
 */

class Castle extends Entity
{
  private var locX:Float;
  private var locY:Float;
  private var radius:Float;
  
  private var pow:Int;
  private var curhp:Int;
  private var health:Int;
  
  public var parent:GameWorld;
  
  public function new(x:Float, y:Float, p:GameWorld) 
  {
    parent = p;
    locX = x;
    locY = y;
    radius = 30;
    pow = 10;
    curhp = Config.startHp;
    health = Config.startHp;
    super(locX - radius, locY - radius);
    var sprite:Image = new Image("gfx/castle.png");
    graphic = sprite;
    locX = x + 35;
    locY = y + 50;
  }
  
  public function Getx():Float {
    return locX;
  }
  
  public function Gety():Float {
    return locY;
  }
  
  public function Getrad():Float {
    return radius;
  }
  
  public function Getpow():Int {
    return pow;
  }
  
  public function Powup() {
    pow += Config.powplus;
  }
  
  public function Hpup() {
    curhp += Config.hpplus;
    health += Config.hpplus;
  }
  
  public function Gettot():Int {
    return health;
  }
  
  public function Gethp():Int {
    return curhp;
  }
  
  public function Breach(type:Hero) {
    //HXP.log(curhp);
    //test++;
    this.curhp -= 10;
    if (curhp <= 0) {
      parent.setlose();
      curhp = 0;
    }
  }
}
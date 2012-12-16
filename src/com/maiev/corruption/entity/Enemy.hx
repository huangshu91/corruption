package com.maiev.corruption.entity;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.maiev.corruption.GameWorld;
import com.maiev.corruption.util.Config;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

/**
 * ...
 * @author maiev
 */

class Enemy extends Entity 
{

  private var locX:Float;
  private var locY:Float;
  private var radius:Float;
  
  private var dir:Direction;
  private var goal:Castle;
  private var velo:Float;
  
  private var health:Int;
  private var curhp:Int;
  
  private var dead:Bool;
  
  private var ty:Hero;
  
  private var parent:GameWorld;
  
  public function new(g:Castle, p:GameWorld, t:Hero, d:Direction, hp:Int) 
  {
    locX = g.Getx()-5;
    locY = g.Gety()+20;
    radius = 20;
    dir = d;
    goal = g;
    ty = t;
    velo = 30;
    health = hp;
    curhp = hp;
    dead = false;
    parent = p;
    
    if (d == Direction.UP) locY = 650;
    if (d == Direction.DOWN) locY = 30;
    if (d == Direction.LEFT) locX += 340;
    if (d == Direction.RIGHT) locX = 30;
    
    super(locX - radius, locY - radius);
    //graphic = Image.createCircle(10, 0xFFFFFF);
    
    if (dir == Direction.UP) graphic = new Image("gfx/knight_up.png");
    if (dir == Direction.DOWN) graphic = new Image("gfx/knight_down.png");
    if (dir == Direction.LEFT) graphic = new Image("gfx/knight_left.png");
    if (dir == Direction.RIGHT) graphic = new Image("gfx/knight_right.png");
    
  }
  
  override public function update() {
    if (dead == true) return;
    
    if (dir == Direction.UP)
    this.moveBy(0, -velo * HXP.elapsed);
    
    if (dir == Direction.DOWN)
    this.moveBy(0, velo * HXP.elapsed);
    
    if (dir == Direction.LEFT)
    this.moveBy(-velo * HXP.elapsed, 0);
    
    if (dir == Direction.RIGHT)
    this.moveBy(velo * HXP.elapsed, 0);
    
    
    locX = this.x + radius;
    locY = this.y + radius;
  
    CheckCol();
    if (Input.mousePressed && Input.mouseX < 850) CheckClick(); 
    
  }
  
  private function CheckCol() {
    var dist:Float;
    var cold:Float;
    dist = (locX - goal.Getx()) * (locX - goal.Getx());
    dist += (locY - goal.Gety()) * (locY - goal.Gety());
    dist = Math.sqrt(dist);
    
    cold = radius + goal.Getrad();
    
    if (dist <= cold) {
      dead = true;
      goal.Breach(ty);
    }
    
  }
  
  public function Isdead() {
    return dead;
  }
  
  private function CheckClick() {
    var mx:Float = Input.mouseX;
    var my:Float = Input.mouseY;
    var dist:Float;
    dist = (locX - mx) * (locX - mx);
    dist += (locY - my) * (locY - my);
    dist = Math.sqrt(dist);
    
    if (dist <= (radius+Config.accuracy)) {
      curhp -= Math.round(goal.Getpow()/2);
      parent.sethp(curhp);
      parent.settot(health);
      if (curhp <= 0) {
        dead = true;
        parent.Givegold();
      }
    }
  }
}
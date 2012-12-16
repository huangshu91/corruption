package com.maiev.corruption.systems;
import com.haxepunk.Entity;
import com.maiev.corruption.GameWorld;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author maiev
 */

class Tutorial extends Entity
{

  private var parent:GameWorld;
  
  public function new(g:GameWorld) 
  {
    super(0, 0);
    parent = g; 
    //graphic = new Image()
  }
  
  public override function update() {
    if (Input.released(Key.SPACE)) {
      parent.settut();
    }
  }
}
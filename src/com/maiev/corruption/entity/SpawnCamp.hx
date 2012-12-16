package com.maiev.corruption.entity;

import com.haxepunk.HXP;
import com.maiev.corruption.GameWorld;
import com.maiev.corruption.util.Config;
/**
 * ...
 * @author maiev
 */

class SpawnCamp 
{
  private var spawntimer:Float;
  private var spawnrate:Int;
  
  private var totaltime:Float;
  
  private var parent:GameWorld;
  
  private var spawned:Int;
  
  public function new(g:GameWorld) 
  {
    parent = g;
    spawntimer = 0;
    totaltime = 0;
    spawned = 0;
    spawnrate = Config.initspawnRate;
    
  }
  
  public function update() {
    spawntimer += HXP.elapsed;
    totaltime += HXP.elapsed;
    if (spawntimer >= spawnrate) {
      spawned++;
      spawntimer = 0;
      parent.SpawnEnemy();
      
      if (spawned > 3 && spawnrate > 3) {
        spawnrate--;
      }
    }
    
  }
  
}
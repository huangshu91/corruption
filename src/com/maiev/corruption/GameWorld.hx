package com.maiev.corruption;

import com.haxepunk.graphics.Image;
import com.haxepunk.World;
import com.haxepunk.graphics.Text;
import com.maiev.corruption.entity.Castle;
import com.maiev.corruption.entity.Enemy;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.maiev.corruption.entity.SpawnCamp;
import com.maiev.corruption.systems.Town;
import com.maiev.corruption.systems.Tutorial;
import nme.display.Sprite;

import com.maiev.corruption.util.Config;
/**
 * ...
 * @author maiev
 */

class GameWorld extends World
{
  private static var color1:Int = 0x559955;
  private static var color2:Int = 0x698869;
  private static var color3:Int = 0x6C776C;
  private static var color4:Int = 0x6C6E6F;
  
  private var castle:Castle;
  
  private var town:Town;
  
  private var map:Image;
  
  private var mobs:Array<Enemy>;
  private var camps:Array<SpawnCamp>;
  
  private var time:Float;
  private var spawntime:Float;
  
  private var gold:Int;
  private var goldtext:Text;
  private var coins:Image;
  
  private var healthtext:Text;
  private var healthbarfill:Sprite;
  private var healthbar:Sprite;
  private var health:Image;
  
  private var level:Int;
  
  private var corrupt:Int;
  private var corrate:Int;
  private var coricon:Image;
  private var corbar:Sprite;
  private var corfill:Sprite;
  private var coreta:Text;
  
  private var sword:Image;
  private var powtext:Text;
  
  private var enemytext:Text;
  private var curhp:Int;
  private var tothp:Int;
  private var entype:String;
  
  private var loseflag:Bool;
  private var losetext:Text;
  
  private var winflag:Bool;
  private var wintext:Text;
  
  private var bonusflag:Bool;
  
  private var tutflag:Bool;
  private var tut:Tutorial;
  
  public function new() {
    super();
    time = 0;
    gold = 0;
    curhp = 0;
    tothp = 0;
    entype = "";
    mobs = new Array<Enemy>();
    camps = new Array<SpawnCamp>();
    castle = new Castle(400, 280, this);
    corrupt = 0;
    corrate = 2; // 2 corruption per second
    town = new Town(this, castle);
    loseflag = false;
    winflag = false;
    bonusflag = false;
    
    tut = new Tutorial(this);
    tutflag = true;
    
    HXP.screen.color = color1;
    
    healthbarfill = new Sprite();
    healthbar = new Sprite();
    healthtext = new Text("999999999/9999999999");
    healthtext.x = 320;
    healthtext.y = 30;
    
    goldtext = new Text("999999999999 gold");
    goldtext.x = 70;
    goldtext.y = 75;
    
    corbar = new Sprite();
    corfill = new Sprite();
    coreta = new Text("999999999999999 seconds");
    coreta.x = 20;
    coreta.y = 630;
    
    powtext = new Text("99999 pow");
    powtext.x = 750;
    powtext.y = 30;
    
    enemytext = new Text("99999/999999 hp");
    enemytext.x = 750;
    enemytext.y = 75;
    
    losetext = new Text("    You lost :( \nrefresh to retry", 0, 0, 300, 300);
    losetext.size = 30;
    losetext.x = 500;
    losetext.y = 300;
    
    wintext = new Text("    You win :) \nspacebar to continue", 0, 0, 300, 300);
    wintext.size = 30;
    wintext.x = 500;
    wintext.y = 300;
    
    level = 0;
    
  }
  
  public override function begin() {
    add (castle);
    add (tut);
    
    addGraphic(enemytext);
    coricon = new Image("gfx/skull.png");
    coricon.x = 20;
    coricon.y = 650;
    addGraphic(coricon);
    HXP.engine.addChild(corbar);
    HXP.engine.addChild(corfill);
    coreta.text = ((Config.wincor - corrupt) / corrate) + " seconds";
    addGraphic(coreta);
    
    sword = new Image("gfx/sword.png");
    sword.x = 710;
    sword.y = 20;
    addGraphic(sword);
    addGraphic(powtext);
    
    coins = new Image("gfx/coins.png");
    coins.x = 16;
    coins.y = 65;
    addGraphic(coins);
    goldtext.text = gold + " gold";
    addGraphic(goldtext);
    
    health = new Image("gfx/health.png");
    health.x = 20;
    health.y = 20;
    addGraphic(health);
    HXP.engine.addChild(healthbar);
    HXP.engine.addChild(healthbarfill);
    healthtext.text = Config.startHp + "/" + Config.startHp;
    addGraphic(healthtext);
    
    var test:Enemy = new Enemy(castle, this, Hero.Knight, Direction.RIGHT, 100);
    mobs.push(test);
    add (test);
    
    camps.push(new SpawnCamp(this));
    
  }
  
  public function setlose() {
    addGraphic(losetext);
    loseflag = true;
  }
  
  public function corrup() {
    corrate++;
  }
  
  public function sethp(h:Int) {
    if (h < 0) h = 0;
    curhp = h;
  }
  
  public function settot(h:Int) {
    tothp = h;
  }
  
  public function settut() {
    tutflag = false;
  }
  
  public override function update() {
    if (tutflag == true) {
      tut.update();
      remove(tut);
      return;
    }
    
    if (winflag == true) {
      if (Input.released(Key.SPACE)) {
        winflag = false;
        bonusflag = true;
        camps.push(new SpawnCamp(this));
        level++;
        wintext.text = "";
      }
    }
    
    if (loseflag == true) return;
    
    super.update();
    
    town.update();
    time += HXP.elapsed;
    spawntime += HXP.elapsed;
    
    corrupt += Math.round(time * corrate);
    var percent:Int = Math.round(corrupt / Config.wincor * 100);
    
    if (corrupt >= Config.wincor && bonusflag == false) {
      winflag = true;
      addGraphic(wintext);
    }
    
    //HXP.log(percent);
    if (percent > 10 && level == 0 ) {
      camps.push(new SpawnCamp(this));
      level++;
      HXP.screen.color = color2;
    }
    
    if (percent > 40 && level == 1) {
      camps.push(new SpawnCamp(this));
      level++;
      HXP.screen.color = color3;
    }
    
    if (percent > 80 && level == 2) {
      camps.push(new SpawnCamp(this));
      level++;
      HXP.screen.color = color4;
    }
    if (corrupt > Config.wincor) corrupt = Config.wincor;
    
    for (i in 0...camps.length) {
      camps[i].update();
    }
    
    for (i in 0...mobs.length) {
      if (mobs[i].Isdead() == false) mobs[i].update();
      if (mobs[i].Isdead() == true) remove(mobs[i]);
    }
    
    for (i in 0...mobs.length) {
      var j:Int = 0;
      if (mobs[j].Isdead() == true) {
        //remove(mobs[j]);
        mobs.remove(mobs[j]);
      }
      else j++;
    }
  }
  
  public function SpawnEnemy() {
    var temp:Enemy;
    
    var dir:Int = Std.random(4);
    
    var hp:Int = Math.round(Config.knighthp + level * (Config.knighthp / 5));
    
    if (dir == 0) temp = new Enemy(castle, this,Hero.Knight, Direction.UP, hp);
    else if (dir == 1) temp = new Enemy(castle, this, Hero.Knight, Direction.DOWN, hp);
    else if (dir == 2) temp = new Enemy(castle, this, Hero.Knight, Direction.LEFT, hp);
    else temp = new Enemy(castle, this, Hero.Knight, Direction.RIGHT, hp);
    
    mobs.push(temp);
    add(temp);
  }
  
  private function RenderHUD() {
    enemytext.text = curhp + "/" + tothp + " " + entype;
    powtext.text = castle.Getpow() + " pow";
    
    healthbar.graphics.clear();
    healthbar.graphics.lineStyle(18, 0x6D0054);
    healthbar.graphics.moveTo(80, 40);
    healthbar.graphics.lineTo(300, 40);
    
    var hp:Float = castle.Gethp();
    var tot:Float = castle.Gettot();
    var percent:Int = Math.round(hp/tot * 220);
    healthtext.text = (hp + "/" + tot);
    healthbarfill.graphics.clear();
    healthbarfill.graphics.lineStyle(12, 0x00FF00);
    healthbarfill.graphics.moveTo(80, 40);
    healthbarfill.graphics.lineTo(80 + percent, 40);
    
    goldtext.text = gold + " gold";
    
    corbar.graphics.clear();
    corbar.graphics.lineStyle(18, 0x37002A);
    corbar.graphics.moveTo(80, 670);
    corbar.graphics.lineTo(700, 670);
    
    var corper:Int = Math.round(corrupt / Config.wincor * 620);
    corfill.graphics.clear();
    corfill.graphics.lineStyle(12, 0x8a5f90);
    corfill.graphics.moveTo(80, 670);
    corfill.graphics.lineTo(80 + corper, 670);
    coreta.text = Math.round((Config.wincor - corrupt) / corrate) + " seconds";
    
  }
  
  public function Usegold(g:Int):Bool {
    if (gold >= g) {
      gold -= g; 
      return true;
    }
    
    return false;
  }
  
  public function Givegold() {
    gold += 100;
  }
  
  
  public override function render() {
    super.render();
    RenderHUD();
    town.render();
  }
  
}
package com.maiev.corruption.systems;
import com.haxepunk.graphics.Text;
import com.maiev.corruption.entity.Castle;
import com.maiev.corruption.GameWorld;
import com.maiev.corruption.util.Config;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import com.haxepunk.HXP;

import com.haxepunk.graphics.Image;

/**
 * ...
 * @author maiev
 */

class Town 
{
  private var castle:Castle;
  
  private var parent:GameWorld;
  
  // coordinates (950,220) size 80x70
  private var smithlevel:Int;
  private var smithcost:Int;
  private var smithleveltext:Text;
  private var smithcosttext:Text;
  private var smithbase:Int;
  
  // coordinates (960,70) size 80x70
  private var castlevel:Int;
  private var castcost:Int;
  private var castleveltext:Text;
  private var castcosttext:Text;
  private var castbase:Int;
  
  // coordinates (950,360) size 90x60
  private var dunlevel:Int;
  private var duncost:Int;
  private var dunleveltext:Text;
  private var duncosttext:Text;
  private var dunbase:Int;
  
  private var background:Image;
  
  private var textcolor:Int;
  
  
  public function new(p:GameWorld, c:Castle) 
  {
    smithlevel = 1;
    castlevel = 1;
    dunlevel = 1;
    textcolor = 0xFFFFFF;
    
    parent = p;
    castle = c;
    
    smithbase = 200;
    castbase = 300;
    dunbase = 400;
    
    smithcost = smithbase * smithlevel;
    castcost = castbase * castlevel;
    duncost = dunbase * dunlevel;
    
    smithleveltext = new Text("level 999999");
    castleveltext = new Text("level 999999");
    dunleveltext = new Text("level 999999");
    smithcosttext = new Text("99999999 gold");
    castcosttext = new Text("99999999 gold");
    duncosttext = new Text("99999999 gold");
    
    background = new Image("gfx/town.png");
    background.x = Config.screenWidth - 430;
    background.y = 0;
    parent.addGraphic(background);
    
    dunleveltext.x = 1060;
    dunleveltext.y = 390;
    dunleveltext.color = textcolor;
    parent.addGraphic(dunleveltext);
    
    duncosttext.x = 1060;
    duncosttext.y = 370;
    duncosttext.color = textcolor;
    parent.addGraphic(duncosttext);
    
    castleveltext.x = 1060;
    castleveltext.y = 110;
    castleveltext.color = textcolor;
    parent.addGraphic(castleveltext);
    
    castcosttext.x = 1060;
    castcosttext.y = 90;
    castcosttext.color = textcolor;
    parent.addGraphic(castcosttext);
    
    smithleveltext.x = 1060;
    smithleveltext.y = 250;
    smithleveltext.color = textcolor;
    parent.addGraphic(smithleveltext);
    
    smithcosttext.x = 1060;
    smithcosttext.y = 230;
    smithcosttext.color = textcolor;
    parent.addGraphic(smithcosttext);
    
  }
  
  public function update() {
    if (Input.mousePressed && Input.mouseX > 850) {
      var mx:Int = Input.mouseX;
      var my:Int = Input.mouseY;
      
      //smith
      if (mx > 950 && mx < 950 + 80 && my > 220 && my < 220 + 70) {
        if (parent.Usegold(smithlevel * smithbase)) {
          castle.Powup();
          smithlevel++;
        }
      }
      
      //castle
      else if (mx > 960 && mx < 960 + 80 && my > 70 && my < 70 + 70) {
        if (parent.Usegold(castlevel * castbase)) {
          castle.Hpup();
          castlevel++;
        }
      }
      
      //dungeon
      else if (mx > 960 && mx < 950 + 90 && my > 360 && my < 360 + 60) {
        if (parent.Usegold(dunlevel * dunbase)) {
          parent.corrup();
          dunlevel++;
        }
      }
      
    }
  }
  
  public function render() {
    smithleveltext.text = "level " + smithlevel;
    smithcosttext.text = "gold " + smithlevel * smithbase;
    
    castleveltext.text = "level " + castlevel;
    castcosttext.text = "gold " + castlevel * castbase;
    
    dunleveltext.text = "level " + dunlevel;
    duncosttext.text = "gold " + dunlevel * dunbase;
    
  }
}
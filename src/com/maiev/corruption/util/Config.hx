package com.maiev.corruption.util;

/**
 * ...
 * @author maiev
 */

 enum Direction {
   LEFT;
   RIGHT;
   UP;
   DOWN;
 }
 
 enum Hero {
   Knight;
   Lord;
 }

class Config 
{
  public static inline var screenWidth:Int = 1280;
  public static inline var screenHeight:Int = 720;
  
  public static inline var frameRate:Int = 60;
  public static inline var clearColor:Int = 0x999999;
  public static inline var projectName:String = "Corruption!";
  
  public static inline var startHp:Int = 200;
  
  public static inline var initspawnRate:Int = 10;
  
  public static inline var accuracy:Int = 10;
  
  public static inline var wincor:Int = 1000;
  
  public static inline var knighthp:Int = 100;
  public static inline var lordhp:Int = 300;
  
  public static inline var powplus:Int = 5;
  public static inline var hpplus:Int = 100;
}
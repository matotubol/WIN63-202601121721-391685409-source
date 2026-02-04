package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public interface AnimationObject extends class_13
   {
      
      function getPosition(param1:int) : Point;
      
      function getBitmap(param1:int) : BitmapData;
      
      function isFinished(param1:int) : Boolean;
      
      function onAnimationStart() : void;
   }
}


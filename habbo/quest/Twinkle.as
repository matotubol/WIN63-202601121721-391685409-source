package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class Twinkle implements AnimationObject, class_13
   {
      
      private static const FRAME_DURATION_IN_MSECS:int = 100;
      
      private static const FRAME_NOT_STARTED:int = -1;
      
      private static const FRAME_FINISHED:int = -2;
      
      private static const FRAME_SEQUENCE:Array = [1,2,3,4,5,6,5,4,3,2,1];
      
      private static const const_28:Point = new Point(44,44);
      
      private var var_1520:TwinkleImages;
      
      private var var_4197:int;
      
      private var var_2134:Point;
      
      public function Twinkle(param1:TwinkleImages, param2:int)
      {
         super();
         var_1520 = param1;
         var_4197 = param2;
      }
      
      public function dispose() : void
      {
         var_1520 = null;
         var_2134 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1520 == null;
      }
      
      public function onAnimationStart() : void
      {
         var_2134 = new Point(Math.round(Math.random() * const_28.x),Math.round(Math.random() * const_28.y));
      }
      
      public function getPosition(param1:int) : Point
      {
         return var_2134;
      }
      
      public function isFinished(param1:int) : Boolean
      {
         return getFrame(param1) == -2;
      }
      
      public function getBitmap(param1:int) : BitmapData
      {
         var _loc3_:int = getFrame(param1);
         return var_1520.getImage(FRAME_SEQUENCE[_loc3_]);
      }
      
      private function getFrame(param1:int) : int
      {
         var _loc2_:int = param1 - var_4197;
         if(_loc2_ < 0)
         {
            return -1;
         }
         var _loc3_:int = Math.floor(_loc2_ / 100);
         if(_loc3_ >= FRAME_SEQUENCE.length)
         {
            return -2;
         }
         return _loc3_;
      }
   }
}


package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class Interval extends Motion
   {
      
      private var var_4266:int;
      
      private var var_2740:int;
      
      public function Interval(param1:class_1741, param2:int)
      {
         super(param1);
         var_270 = false;
         var_2740 = param2;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_270 = false;
         var_4266 = getTimer();
      }
      
      final override friend function tick(param1:int) : void
      {
         var _loc2_:Number = (param1 - var_4266) / var_2740;
         if(_loc2_ < 1)
         {
            friend::update(_loc2_);
         }
         else
         {
            friend::update(1);
            var_270 = true;
         }
      }
   }
}


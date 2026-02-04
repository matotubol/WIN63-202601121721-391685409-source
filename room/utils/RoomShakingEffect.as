package com.sulake.room.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomShakingEffect
   {
      
      public static const STATE_NOT_INITIALIZED:int = 0;
      
      public static const STATE_START_DELAY:int = 1;
      
      public static const STATE_RUNNING:int = 2;
      
      public static const STATE_OVER:int = 3;
      
      private static var var_61:int = 0;
      
      private static var var_3143:Boolean = false;
      
      private static var var_3068:Number;
      
      private static var var_3928:int = 0;
      
      private static var var_2280:int = 20000;
      
      private static var var_2799:int = 5000;
      
      private static var var_1077:Timer;
      
      public function RoomShakingEffect()
      {
         super();
      }
      
      public static function init(param1:int, param2:int) : void
      {
         var_3068 = 0;
         var_2280 = param1;
         var_2799 = param2;
         var_3928 = getTimer();
         var_61 = 1;
      }
      
      public static function turnVisualizationOn() : void
      {
         if(var_61 == 0 || var_61 == 3)
         {
            return;
         }
         if(var_1077 == null || !var_1077.running)
         {
            var_1077 = new Timer(var_2799,1);
            var_1077.addEventListener("timerComplete",turnVisualizationOff);
            var_1077.start();
         }
         var _loc1_:int = getTimer() - var_3928;
         if(_loc1_ > var_2280 + var_2799)
         {
            var_61 = 3;
            return;
         }
         var_3143 = true;
         if(_loc1_ < var_2280)
         {
            var_61 = 1;
            return;
         }
         var_61 = 2;
         var_3068 = (_loc1_ - var_2280) / var_2799;
      }
      
      public static function turnVisualizationOff(param1:TimerEvent) : void
      {
         var_3143 = false;
         var_1077.stop();
         var_1077.removeEventListener("timerComplete",turnVisualizationOff);
         var_1077 = null;
      }
      
      public static function isVisualizationOn() : Boolean
      {
         return var_3143 && isRunning();
      }
      
      private static function isRunning() : Boolean
      {
         if(var_61 == 1 || var_61 == 2)
         {
            return true;
         }
         return false;
      }
   }
}


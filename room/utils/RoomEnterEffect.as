package com.sulake.room.utils
{
   import flash.utils.getTimer;
   
   public class RoomEnterEffect
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
      
      private static var var_2799:int = 2000;
      
      public function RoomEnterEffect()
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
      
      public static function turnVisualizationOff() : void
      {
         var_3143 = false;
      }
      
      public static function isVisualizationOn() : Boolean
      {
         return var_3143 && isRunning();
      }
      
      public static function isRunning() : Boolean
      {
         if(var_61 == 1 || var_61 == 2)
         {
            return true;
         }
         return false;
      }
      
      public static function getDelta(param1:Number = 0, param2:Number = 1) : Number
      {
         return Math.min(Math.max(var_3068,param1),param2);
      }
      
      public static function get totalRunningTime() : int
      {
         return var_2280 + var_2799;
      }
   }
}


package com.sulake.core.utils
{
   import com.sulake.core.class_23;
   import flash.system.System;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class class_504
   {
      
      private static var var_2671:uint = 300;
      
      private static var var_2432:uint = 400;
      
      private static var var_1691:uint = 60000;
      
      private static var var_983:Boolean = false;
      
      public function class_504()
      {
         super();
      }
      
      public static function get softPurgeTriggerMegaBytes() : uint
      {
         return var_2671;
      }
      
      public static function set softPurgeTriggerMegaBytes(param1:uint) : void
      {
         var_2671 = param1;
      }
      
      public static function get hardPurgeTriggerMegaBytes() : uint
      {
         return var_2432;
      }
      
      public static function set hardPurgeTriggerMegaBytes(param1:uint) : void
      {
         var_2432 = Math.max(param1,var_2671);
      }
      
      public static function get frequencyMilliSeconds() : uint
      {
         return var_1691;
      }
      
      public static function set frequencyMilliSeconds(param1:uint) : void
      {
         var_1691 = param1;
      }
      
      public static function get isRunning() : Boolean
      {
         return var_983;
      }
      
      protected static function get isMemoryDataAvailable() : Boolean
      {
         return class_2034.majorVersion > 10 || class_2034.majorVersion == 10 && class_2034.majorRevision >= 1;
      }
      
      public static function start() : void
      {
         if(!var_983)
         {
            if(!isMemoryDataAvailable)
            {
               var_1691 *= 2;
               var_2671 = 0;
               var_2432 = 2147483647;
            }
            setTimeout(onInterval,var_1691);
            var_983 = true;
         }
      }
      
      public static function stop() : void
      {
         if(var_983)
         {
            var_983 = false;
         }
      }
      
      public static function trigger() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc1_:Object = System;
         var _loc4_:Number = isMemoryDataAvailable ? (_loc1_.totalMemory - _loc1_.freeMemory) / 1024 / 1024 : softPurgeTriggerMegaBytes + 1;
         if(_loc4_ > softPurgeTriggerMegaBytes)
         {
            _loc2_ = getTimer();
            class_23.purge();
            _loc3_ = isMemoryDataAvailable ? (_loc1_.totalMemory - _loc1_.freeMemory) / 1024 / 1024 : 0;
            if(_loc3_ > var_2432)
            {
               triggerGC();
            }
         }
      }
      
      public static function triggerGC() : void
      {
         System.pauseForGCIfCollectionImminent(0.25);
      }
      
      private static function onInterval() : void
      {
         if(var_983)
         {
            trigger();
            setTimeout(onInterval,var_1691);
         }
      }
   }
}


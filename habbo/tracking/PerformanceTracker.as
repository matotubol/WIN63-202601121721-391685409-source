package com.sulake.habbo.tracking
{
   import com.sulake.core.utils.debug.GarbageMonitor;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;
   
   public class PerformanceTracker
   {
      
      private var var_493:int = 0;
      
      private var var_826:Number = 0;
      
      private var var_2408:String = "";
      
      private var var_3416:String = "";
      
      private var var_3932:String = "";
      
      private var var_5354:String = "";
      
      private var var_4117:Boolean = false;
      
      private var var_3781:GarbageMonitor = null;
      
      private var var_2480:int = 0;
      
      private var var_2555:int = 0;
      
      private var _lastReport:int = 0;
      
      private var var_3343:int = 0;
      
      private var var_3869:Number = 0;
      
      private var _habboTracking:HabboTracking;
      
      public function PerformanceTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
         var_3416 = Capabilities.version;
         var_3932 = Capabilities.os;
         var_4117 = Capabilities.isDebugger;
         try
         {
            var_2408 = ExternalInterface.available ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown";
         }
         catch(e:Error)
         {
         }
         if(var_2408 == null)
         {
            var_2408 = "unknown";
         }
         var_3781 = new GarbageMonitor();
         updateGarbageMonitor();
         _lastReport = getTimer();
      }
      
      private static function differenceInPercents(param1:Number, param2:Number) : Number
      {
         if(param1 == param2)
         {
            return 0;
         }
         var _loc4_:Number = param1;
         var _loc3_:Number = param2;
         if(param2 > param1)
         {
            _loc4_ = param2;
            _loc3_ = param1;
         }
         return 100 * (1 - _loc3_ / _loc4_);
      }
      
      public function get flashVersion() : String
      {
         return var_3416;
      }
      
      public function get averageUpdateInterval() : int
      {
         return var_826;
      }
      
      private function updateGarbageMonitor() : Object
      {
         var _loc2_:Object = null;
         var _loc1_:Array = var_3781.list;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _loc2_ = new GarbageTester("tester");
            var_3781.insert(_loc2_,"tester");
            return _loc2_;
         }
         return null;
      }
      
      public function update(param1:uint, param2:int) : void
      {
         var _loc7_:Object = null;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         if(isGarbageMonitored)
         {
            _loc7_ = updateGarbageMonitor();
            if(_loc7_ != null)
            {
               var_2480 = var_2480 + 1;
               class_21.log("Garbage collection");
            }
         }
         if(param1 > slowUpdateLimit)
         {
            var_2555 = var_2555 + 1;
            var _loc8_:Boolean = true;
         }
         else
         {
            var_493 = var_493 + 1;
            if(var_493 <= 1)
            {
               var_826 = param1;
            }
            else
            {
               _loc3_ = var_493;
               var_826 = var_826 * (_loc3_ - 1) / _loc3_ + param1 / _loc3_;
            }
         }
         if(param2 - _lastReport > reportInterval * 1000 && var_3343 < reportLimit)
         {
            var _loc4_:uint = System.totalMemory;
            class_21.log("*** Performance tracker: average frame rate " + 1000 / var_826 + "/s, system memory usage : " + 0 + " bytes");
            var _loc6_:Boolean = true;
            if(useDistribution && var_3343 > 0)
            {
               _loc5_ = differenceInPercents(var_3869,var_826);
               if(_loc5_ < meanDevianceLimit)
               {
                  _loc6_ = false;
               }
            }
            _lastReport = param2;
         }
      }
      
      private function sendReport(param1:int) : void
      {
         var _loc4_:int = param1 / 1000;
         var _loc2_:int = System.totalMemory / 1024;
         _habboTracking.send(new PerformanceLogMessageComposer(_loc4_,var_2408,var_3416,var_3932,var_5354,var_4117,_loc2_,-1,var_2480,var_826,var_2555));
         var_2480 = 0;
         var_826 = 0;
         var_493 = 0;
         var_2555 = 0;
      }
      
      private function get isGarbageMonitored() : Boolean
      {
         return _habboTracking.getBoolean("monitor.garbage.collection");
      }
      
      private function get slowUpdateLimit() : int
      {
         return _habboTracking.getInteger("performancetest.slowupdatelimit",1000);
      }
      
      private function get reportInterval() : int
      {
         return _habboTracking.getInteger("performancetest.interval",60);
      }
      
      private function get reportLimit() : int
      {
         return _habboTracking.getInteger("performancetest.reportlimit",10);
      }
      
      private function get meanDevianceLimit() : Number
      {
         return _habboTracking.propertyExists("performancetest.distribution.deviancelimit.percent") ? Number(_habboTracking.getProperty("performancetest.distribution.deviancelimit.percent")) : 10;
      }
      
      private function get useDistribution() : Boolean
      {
         return _habboTracking.getBoolean("performancetest.distribution.enabled");
      }
   }
}


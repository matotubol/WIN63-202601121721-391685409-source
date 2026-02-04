package com.sulake.habbo.tracking
{
   public class FramerateTracker
   {
      
      private var _lastReport:int;
      
      private var var_1371:int;
      
      private var var_826:Number;
      
      private var var_3418:int;
      
      private var _habboTracking:HabboTracking;
      
      public function FramerateTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function get frameRate() : int
      {
         return Math.round(1000 / var_826);
      }
      
      public function trackUpdate(param1:uint, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var_1371 = var_1371 + 1;
         if(var_1371 == 1)
         {
            var_826 = param1;
            _lastReport = param2;
         }
         else
         {
            _loc3_ = var_1371;
            var_826 = var_826 * (_loc3_ - 1) / _loc3_ + param1 / _loc3_;
         }
         if(param2 - _lastReport >= _habboTracking.getInteger("tracking.framerate.reportInterval.seconds",300) * 1000)
         {
            var_1371 = 0;
            if(var_3418 < _habboTracking.getInteger("tracking.framerate.maximumEvents",5))
            {
               _habboTracking.trackGoogle("performance","averageFramerate",frameRate);
               var_3418 = var_3418 + 1;
               _lastReport = param2;
            }
         }
      }
   }
}


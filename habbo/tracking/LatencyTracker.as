package com.sulake.habbo.tracking
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import flash.utils.getTimer;
   import package_164.class_2797;
   import package_68.class_2163;
   import package_71.class_2763;
   import package_71.class_2834;
   
   public class LatencyTracker implements class_13
   {
      
      private var var_61:Boolean = false;
      
      private var var_3126:int = 0;
      
      private var var_3643:int = 0;
      
      private var var_3620:int = 0;
      
      private var var_3990:int = 0;
      
      private var _lastTestTime:int = 0;
      
      private var var_3692:int = 0;
      
      private var var_329:Array;
      
      private var var_1084:class_55;
      
      private var _habboTracking:HabboTracking;
      
      public function LatencyTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_61 = false;
         if(var_1084 != null)
         {
            var_1084.dispose();
            var_1084 = null;
         }
         var_329 = null;
         _habboTracking = null;
      }
      
      public function init() : void
      {
         var_3643 = _habboTracking.getInteger("latencytest.interval",20000);
         var_3620 = _habboTracking.getInteger("latencytest.report.index",100);
         var_3990 = _habboTracking.getInteger("latencytest.report.delta",3);
         if(var_3643 < 1)
         {
            return;
         }
         var_1084 = new class_55();
         var_329 = [];
         var_61 = true;
      }
      
      public function update(param1:uint, param2:int) : void
      {
         if(!var_61)
         {
            return;
         }
         if(param2 - _lastTestTime > var_3643)
         {
            testLatency();
         }
      }
      
      private function testLatency() : void
      {
         _lastTestTime = getTimer();
         var_1084.add(var_3126,_lastTestTime);
         _habboTracking.send(new class_2763(var_3126));
         var_3126 = var_3126 + 1;
      }
      
      public function onPingResponse(param1:class_2163) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(var_1084 == null || var_329 == null)
         {
            return;
         }
         var _loc4_:class_2797 = param1.getParser();
         var _loc9_:int = var_1084.getValue(_loc4_.requestId);
         var_1084.remove(_loc4_.requestId);
         var _loc6_:int = getTimer() - _loc9_;
         var_329.push(_loc6_);
         if(var_329.length == var_3620 && var_3620 > 0)
         {
            _loc7_ = 0;
            _loc2_ = 0;
            _loc10_ = 0;
            _loc8_ = 0;
            while(_loc8_ < var_329.length)
            {
               _loc7_ += var_329[_loc8_];
               _loc8_++;
            }
            _loc5_ = _loc7_ / var_329.length;
            _loc8_ = 0;
            while(_loc8_ < var_329.length)
            {
               if(var_329[_loc8_] < _loc5_ * 2)
               {
                  _loc2_ += var_329[_loc8_];
                  _loc10_++;
               }
               _loc8_++;
            }
            if(_loc10_ == 0)
            {
               var_329 = [];
               return;
            }
            _loc3_ = _loc2_ / _loc10_;
            if(Math.abs(_loc5_ - var_3692) > var_3990 || var_3692 == 0)
            {
               var_3692 = _loc5_;
               var _loc11_:class_2834 = new class_2834(_loc5_,_loc3_,var_329.length);
               _habboTracking.send(null);
            }
            var_329 = [];
         }
      }
      
      public function get disposed() : Boolean
      {
         return _habboTracking == null;
      }
   }
}


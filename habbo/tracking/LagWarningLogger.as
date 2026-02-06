package com.sulake.habbo.tracking
{
   import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;
   
   public class LagWarningLogger
   {
      
      private var var_3444:int;
      
      private var var_1971:int;
      
      private var _habboTracking:HabboTracking;
      
      public function LagWarningLogger(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function chatLagDetected(param1:int) : void
      {
         if(!enabled || warningInterval <= 0)
         {
            return;
         }
         var_1971 = var_1971 + 1;
         reportWarningsAsNeeded(param1);
      }
      
      public function update(param1:int) : void
      {
         reportWarningsAsNeeded(param1);
      }
      
      private function reportWarningsAsNeeded(param1:int) : void
      {
         var _loc2_:LagWarningReportMessageComposer = null;
         if(var_1971 == 0)
         {
            return;
         }
         if(var_3444 == 0 || param1 - var_3444 > warningInterval)
         {
            _loc2_ = new LagWarningReportMessageComposer(var_1971);
            _habboTracking.send(_loc2_);
            var_3444 = param1;
            var_1971 = 0;
         }
      }
      
      private function get enabled() : Boolean
      {
         return _habboTracking.getBoolean("lagWarningLog.enabled");
      }
      
      private function get warningInterval() : int
      {
         return _habboTracking.getInteger("lagWarningLog.interval.seconds",10) * 1000;
      }
   }
}


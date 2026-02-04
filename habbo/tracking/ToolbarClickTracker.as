package com.sulake.habbo.tracking
{
   public class ToolbarClickTracker
   {
      
      private var _tracking:HabboTracking;
      
      private var var_3553:int = 0;
      
      public function ToolbarClickTracker(param1:HabboTracking)
      {
         super();
         _tracking = param1;
      }
      
      public function track(param1:String) : void
      {
         if(!_tracking.getBoolean("toolbar.tracking.enabled"))
         {
            return;
         }
         var_3553 = var_3553 + 1;
         if(var_3553 <= _tracking.getInteger("toolbar.tracking.max.events",100))
         {
            _tracking.trackGoogle("toolbar",param1);
         }
      }
   }
}


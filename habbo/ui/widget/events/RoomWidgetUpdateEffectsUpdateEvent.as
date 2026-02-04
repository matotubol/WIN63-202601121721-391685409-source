package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetUpdateEffectsUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_1016:String = "RWUEUE_UPDATE_EFFECTS";
      
      private var var_555:Array;
      
      public function RoomWidgetUpdateEffectsUpdateEvent(param1:Array = null, param2:Boolean = false, param3:Boolean = false)
      {
         super("RWUEUE_UPDATE_EFFECTS",param2,param3);
         var_555 = param1;
      }
      
      public function get effects() : Array
      {
         return var_555;
      }
   }
}


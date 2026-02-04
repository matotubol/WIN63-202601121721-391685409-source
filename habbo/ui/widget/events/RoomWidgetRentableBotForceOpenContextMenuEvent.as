package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotForceOpenContextMenuEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_1142:String = "RWRBFOCME_OPEN";
      
      private var var_1504:int;
      
      public function RoomWidgetRentableBotForceOpenContextMenuEvent(param1:int)
      {
         var_1504 = param1;
         super("RWRBFOCME_OPEN");
      }
      
      public function get botId() : int
      {
         return var_1504;
      }
   }
}


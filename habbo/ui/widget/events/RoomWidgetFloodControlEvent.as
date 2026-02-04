package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_321:String = "RWFCE_FLOOD_CONTROL";
      
      private var var_3073:int = 0;
      
      public function RoomWidgetFloodControlEvent(param1:int)
      {
         super("RWFCE_FLOOD_CONTROL",false,false);
         var_3073 = param1;
      }
      
      public function get seconds() : int
      {
         return var_3073;
      }
   }
}


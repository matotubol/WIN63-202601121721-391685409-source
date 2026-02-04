package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDanceUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_1027:String = "RWUE_DANCE";
      
      private var _style:int;
      
      public function RoomWidgetDanceUpdateEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super("RWUE_DANCE",param2,param3);
         _style = param1;
      }
      
      public function get style() : int
      {
         return _style;
      }
   }
}


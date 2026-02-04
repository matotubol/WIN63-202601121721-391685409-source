package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetMiniMailUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_74:String = "RWMMUE_new_mini_mail";
      
      public static const const_620:String = "RWMMUE_unread_mini_mail";
      
      public function RoomWidgetMiniMailUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}


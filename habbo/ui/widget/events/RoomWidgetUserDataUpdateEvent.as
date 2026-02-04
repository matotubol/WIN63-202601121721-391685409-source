package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetUserDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const USER_DATA_UPDATED:String = "rwudue_user_data_updated";
      
      public function RoomWidgetUserDataUpdateEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("rwudue_user_data_updated",param1,param2);
      }
   }
}


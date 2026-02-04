package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetNavigateToRoomMessage extends RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_NAVIGATE_TO_ROOM:String = "RWGOI_MESSAGE_NAVIGATE_TO_ROOM";
      
      public static const WIDGET_MESSAGE_NAVIGATE_HOME:String = "RWGOI_MESSAGE_NAVIGATE_HOME";
      
      private var var_1951:int;
      
      public function RoomWidgetNavigateToRoomMessage(param1:String, param2:int = -1)
      {
         super(param1);
         var_1951 = param2;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
   }
}


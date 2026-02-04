package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetFriendRequestMessage extends RoomWidgetMessage
   {
      
      public static const ACCEPT:String = "RWFRM_ACCEPT";
      
      public static const DECLINE:String = "RWFRM_DECLINE";
      
      private var var_2563:int = 0;
      
      public function RoomWidgetFriendRequestMessage(param1:String, param2:int = 0)
      {
         super(param1);
         var_2563 = param2;
      }
      
      public function get requestId() : int
      {
         return var_2563;
      }
   }
}


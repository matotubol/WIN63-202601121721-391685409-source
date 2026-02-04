package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetChatSelectAvatarMessage extends RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_SELECT_AVATAR:String = "RWCSAM_MESSAGE_SELECT_AVATAR";
      
      private var var_315:int;
      
      private var _userName:String;
      
      private var var_1951:int;
      
      public function RoomWidgetChatSelectAvatarMessage(param1:String, param2:int, param3:String, param4:int)
      {
         super(param1);
         var_315 = param2;
         var_1951 = param4;
         _userName = param3;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
   }
}


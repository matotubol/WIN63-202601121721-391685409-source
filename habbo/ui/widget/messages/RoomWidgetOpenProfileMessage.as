package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetOpenProfileMessage extends RoomWidgetMessage
   {
      
      public static const const_815:String = "RWOPEM_OPEN_USER_PROFILE";
      
      private var var_1270:int;
      
      private var var_4816:String;
      
      public function RoomWidgetOpenProfileMessage(param1:String, param2:int, param3:String)
      {
         super(param1);
         var_1270 = param2;
         var_4816 = param3;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get trackingLocation() : String
      {
         return var_4816;
      }
   }
}


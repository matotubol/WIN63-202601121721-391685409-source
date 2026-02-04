package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetGetObjectLocationMessage extends RoomWidgetMessage
   {
      
      public static const const_400:String = "RWGOI_MESSAGE_GET_OBJECT_LOCATION";
      
      public static const const_486:String = "RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION";
      
      private var var_315:int;
      
      private var var_2300:int;
      
      public function RoomWidgetGetObjectLocationMessage(param1:String, param2:int, param3:int)
      {
         super(param1);
         var_315 = param2;
         var_2300 = param3;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectType() : int
      {
         return var_2300;
      }
   }
}


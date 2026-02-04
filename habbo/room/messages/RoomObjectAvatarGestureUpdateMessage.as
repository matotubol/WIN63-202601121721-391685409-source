package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_2937:int = 0;
      
      public function RoomObjectAvatarGestureUpdateMessage(param1:int)
      {
         super();
         var_2937 = param1;
      }
      
      public function get gesture() : int
      {
         return var_2937;
      }
   }
}


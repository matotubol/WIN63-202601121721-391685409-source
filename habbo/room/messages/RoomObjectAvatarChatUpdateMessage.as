package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_4526:int;
      
      public function RoomObjectAvatarChatUpdateMessage(param1:int)
      {
         super();
         var_4526 = param1;
      }
      
      public function get numberOfWords() : int
      {
         return var_4526;
      }
   }
}


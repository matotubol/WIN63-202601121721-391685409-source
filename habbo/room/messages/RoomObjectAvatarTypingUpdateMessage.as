package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_874:Boolean;
      
      public function RoomObjectAvatarTypingUpdateMessage(param1:Boolean = false)
      {
         super();
         var_874 = param1;
      }
      
      public function get isTyping() : Boolean
      {
         return var_874;
      }
   }
}


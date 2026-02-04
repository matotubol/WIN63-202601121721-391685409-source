package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarBlockedUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_996:Boolean = false;
      
      public function RoomObjectAvatarBlockedUpdateMessage(param1:Boolean)
      {
         super();
         var_996 = param1;
      }
      
      public function get isBlocked() : Boolean
      {
         return var_996;
      }
   }
}


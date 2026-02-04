package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarMutedUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_4600:Boolean;
      
      public function RoomObjectAvatarMutedUpdateMessage(param1:Boolean = false)
      {
         super();
         var_4600 = param1;
      }
      
      public function get isMuted() : Boolean
      {
         return var_4600;
      }
   }
}


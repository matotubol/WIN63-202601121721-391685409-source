package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_757:int;
      
      public function RoomObjectAvatarUseObjectUpdateMessage(param1:int)
      {
         super();
         var_757 = param1;
      }
      
      public function get itemType() : int
      {
         return var_757;
      }
   }
}


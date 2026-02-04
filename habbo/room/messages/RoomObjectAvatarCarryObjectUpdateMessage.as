package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_757:int;
      
      private var _itemName:String;
      
      public function RoomObjectAvatarCarryObjectUpdateMessage(param1:int, param2:String)
      {
         super();
         var_757 = param1;
         _itemName = param2;
      }
      
      public function get itemType() : int
      {
         return var_757;
      }
      
      public function get itemName() : String
      {
         return _itemName;
      }
   }
}


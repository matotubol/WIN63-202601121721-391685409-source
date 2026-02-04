package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var _isAdmin:Boolean = false;
      
      private var var_4487:String;
      
      public function RoomObjectAvatarFlatControlUpdateMessage(param1:String)
      {
         super();
         var_4487 = param1;
      }
      
      public function get isAdmin() : Boolean
      {
         return _isAdmin;
      }
      
      public function get rawData() : String
      {
         return var_4487;
      }
   }
}


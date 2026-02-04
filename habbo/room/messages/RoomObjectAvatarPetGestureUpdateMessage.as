package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_2937:String;
      
      public function RoomObjectAvatarPetGestureUpdateMessage(param1:String)
      {
         super();
         var_2937 = param1;
      }
      
      public function get gesture() : String
      {
         return var_2937;
      }
   }
}


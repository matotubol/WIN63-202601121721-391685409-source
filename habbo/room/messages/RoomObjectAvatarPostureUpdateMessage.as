package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_4802:String;
      
      private var var_1900:String;
      
      public function RoomObjectAvatarPostureUpdateMessage(param1:String, param2:String = "")
      {
         super();
         var_4802 = param1;
         var_1900 = param2;
      }
      
      public function get postureType() : String
      {
         return var_4802;
      }
      
      public function get parameter() : String
      {
         return var_1900;
      }
   }
}


package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var var_975:String;
      
      private var var_4507:String;
      
      private var var_111:String;
      
      private var var_4070:Boolean;
      
      public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String = null, param3:String = null, param4:Boolean = false)
      {
         super();
         var_975 = param1;
         var_111 = param2;
         var_4507 = param3;
         var_4070 = param4;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get race() : String
      {
         return var_4507;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get isRiding() : Boolean
      {
         return var_4070;
      }
   }
}


package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectModelDataUpdateMessage extends RoomObjectUpdateMessage
   {
      
      private var _numberKey:String;
      
      private var var_4156:int;
      
      public function RoomObjectModelDataUpdateMessage(param1:String, param2:int)
      {
         super(null,null);
         _numberKey = param1;
         var_4156 = param2;
      }
      
      public function get numberKey() : String
      {
         return _numberKey;
      }
      
      public function get numberValue() : int
      {
         return var_4156;
      }
   }
}


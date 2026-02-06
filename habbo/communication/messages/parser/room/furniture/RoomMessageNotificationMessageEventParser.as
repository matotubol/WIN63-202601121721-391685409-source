package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomMessageNotificationMessageEventParser implements IMessageParser
   {
      
      private var var_1951:int;
      
      private var _roomName:String;
      
      private var var_1987:int;
      
      public function RoomMessageNotificationMessageEventParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get messageCount() : int
      {
         return var_1987;
      }
      
      public function flush() : Boolean
      {
         var_1951 = -1;
         _roomName = "";
         var_1987 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         _roomName = param1.readString();
         var_1987 = param1.readInteger();
         return true;
      }
   }
}


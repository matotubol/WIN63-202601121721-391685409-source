package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserUnbannedFromRoomEventParser implements IMessageParser
   {
      
      private var var_1951:int;
      
      private var var_1270:int;
      
      public function UserUnbannedFromRoomEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1951 = 0;
         var_1270 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         var_1270 = param1.readInteger();
         return true;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomForwardMessageEventParser implements IMessageParser
   {
      
      private var var_1951:int;
      
      public function RoomForwardMessageEventParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         return true;
      }
   }
}


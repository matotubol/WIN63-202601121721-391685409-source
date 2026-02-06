package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceRentFailedMessageEventParser implements IMessageParser
   {
      
      private var var_2352:int;
      
      public function RentableSpaceRentFailedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2352 = param1.readInteger();
         return true;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
   }
}


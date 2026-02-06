package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InfoHotelClosingMessageEventParser implements IMessageParser
   {
      
      private var var_2964:int;
      
      public function InfoHotelClosingMessageEventParser()
      {
         super();
      }
      
      public function get minutesUntilClosing() : int
      {
         return var_2964;
      }
      
      public function flush() : Boolean
      {
         var_2964 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2964 = param1.readInteger();
         return true;
      }
   }
}


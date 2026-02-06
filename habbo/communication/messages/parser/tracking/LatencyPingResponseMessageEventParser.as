package com.sulake.habbo.communication.messages.parser.tracking
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LatencyPingResponseMessageEventParser implements IMessageParser
   {
      
      private var var_2563:int;
      
      public function LatencyPingResponseMessageEventParser()
      {
         super();
      }
      
      public function get requestId() : int
      {
         return var_2563;
      }
      
      public function flush() : Boolean
      {
         var_2563 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2563 = param1.readInteger();
         return true;
      }
   }
}


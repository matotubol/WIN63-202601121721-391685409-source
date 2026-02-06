package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class EmeraldBalanceMessageEventParser implements IMessageParser
   {
      
      private var var_3240:int = 0;
      
      public function EmeraldBalanceMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3240 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3240 = param1.readInteger();
         return true;
      }
      
      public function get emeraldBalance() : int
      {
         return var_3240;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverFeeMessageEventParser implements IMessageParser
   {
      
      private var var_3270:int;
      
      public function TradeSilverFeeMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3270 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3270 = param1.readInteger();
         return true;
      }
      
      public function get silverFee() : int
      {
         return var_3270;
      }
   }
}


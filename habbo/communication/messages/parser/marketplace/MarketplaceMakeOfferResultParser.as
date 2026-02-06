package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceMakeOfferResultParser implements IMessageParser
   {
      
      private var var_1122:int;
      
      public function MarketplaceMakeOfferResultParser()
      {
         super();
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         return true;
      }
   }
}


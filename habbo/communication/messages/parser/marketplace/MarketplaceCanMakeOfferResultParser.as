package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCanMakeOfferResultParser implements IMessageParser
   {
      
      private var var_4937:int;
      
      private var var_1122:int;
      
      public function MarketplaceCanMakeOfferResultParser()
      {
         super();
      }
      
      public function get tokenCount() : int
      {
         return var_4937;
      }
      
      public function get resultCode() : int
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
         var_4937 = param1.readInteger();
         return true;
      }
   }
}


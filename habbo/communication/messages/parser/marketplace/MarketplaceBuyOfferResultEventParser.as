package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceBuyOfferResultEventParser implements IMessageParser
   {
      
      private var var_1122:int;
      
      private var var_4300:int = -1;
      
      private var var_4645:int = -1;
      
      private var var_3275:int = -1;
      
      public function MarketplaceBuyOfferResultEventParser()
      {
         super();
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get offerId() : int
      {
         return var_4300;
      }
      
      public function get newPrice() : int
      {
         return var_4645;
      }
      
      public function get requestedOfferId() : int
      {
         return var_3275;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         var_4300 = param1.readInteger();
         var_4645 = param1.readInteger();
         var_3275 = param1.readInteger();
         return true;
      }
   }
}


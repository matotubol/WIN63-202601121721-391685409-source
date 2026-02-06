package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceConfigurationEventParser implements IMessageParser
   {
      
      private var var_3091:Boolean;
      
      private var var_4999:int;
      
      private var var_3452:int;
      
      private var var_3440:int;
      
      private var _offerMaxPrice:int;
      
      private var _offerMinPrice:int;
      
      private var _expirationHours:int;
      
      private var var_3883:int;
      
      private var var_3976:int;
      
      private var var_4026:int;
      
      private var var_3991:int;
      
      public function MarketplaceConfigurationEventParser()
      {
         super();
      }
      
      public function get isEnabled() : Boolean
      {
         return var_3091;
      }
      
      public function get commission() : int
      {
         return var_4999;
      }
      
      public function get tokenBatchPrice() : int
      {
         return var_3452;
      }
      
      public function get tokenBatchSize() : int
      {
         return var_3440;
      }
      
      public function get offerMinPrice() : int
      {
         return _offerMinPrice;
      }
      
      public function get offerMaxPrice() : int
      {
         return _offerMaxPrice;
      }
      
      public function get expirationHours() : int
      {
         return _expirationHours;
      }
      
      public function get averagePricePeriod() : int
      {
         return var_3883;
      }
      
      public function get tokensBatchSize() : int
      {
         return var_3440;
      }
      
      public function get sellingFeePercentage() : int
      {
         return var_3976;
      }
      
      public function get revenueLimit() : int
      {
         return var_4026;
      }
      
      public function get halfTaxLimit() : int
      {
         return var_3991;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3091 = param1.readBoolean();
         var_4999 = param1.readInteger();
         var_3452 = param1.readInteger();
         var_3440 = param1.readInteger();
         _offerMinPrice = param1.readInteger();
         _offerMaxPrice = param1.readInteger();
         _expirationHours = param1.readInteger();
         var_3883 = param1.readInteger();
         var_3976 = param1.readInteger();
         var_4026 = param1.readInteger();
         var_3991 = param1.readInteger();
         return true;
      }
   }
}


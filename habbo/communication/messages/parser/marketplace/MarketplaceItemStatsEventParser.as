package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceItemStatsEventParser implements IMessageParser
   {
      
      private var var_3961:int;
      
      private var var_4069:int;
      
      private var _historyLength:int;
      
      private var var_3412:Array;
      
      private var var_3464:Array;
      
      private var var_3467:Array;
      
      private var var_4685:int;
      
      private var var_3882:int;
      
      public function MarketplaceItemStatsEventParser()
      {
         super();
      }
      
      public function get averagePrice() : int
      {
         return var_3961;
      }
      
      public function get offerCount() : int
      {
         return var_4069;
      }
      
      public function get historyLength() : int
      {
         return _historyLength;
      }
      
      public function get dayOffsets() : Array
      {
         return var_3412;
      }
      
      public function get averagePrices() : Array
      {
         return var_3464;
      }
      
      public function get soldAmounts() : Array
      {
         return var_3467;
      }
      
      public function get furniTypeId() : int
      {
         return var_4685;
      }
      
      public function get furniCategoryId() : int
      {
         return var_3882;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3961 = param1.readInteger();
         var_4069 = param1.readInteger();
         _historyLength = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var_3412 = [];
         var_3464 = [];
         var_3467 = [];
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3412.push(param1.readInteger());
            var_3464.push(param1.readInteger());
            var_3467.push(param1.readInteger());
            _loc3_++;
         }
         var_3882 = param1.readInteger();
         var_4685 = param1.readInteger();
         return true;
      }
   }
}


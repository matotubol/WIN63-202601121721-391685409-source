package com.sulake.habbo.catalog.marketplace
{
   public class class_2042
   {
      
      private var var_3961:int;
      
      private var var_4069:int;
      
      private var _historyLength:int;
      
      private var var_3412:Array;
      
      private var var_3464:Array;
      
      private var var_3467:Array;
      
      private var var_4685:int;
      
      private var var_3882:int;
      
      public function class_2042()
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
      
      public function set averagePrice(param1:int) : void
      {
         var_3961 = param1;
      }
      
      public function set offerCount(param1:int) : void
      {
         var_4069 = param1;
      }
      
      public function set historyLength(param1:int) : void
      {
         _historyLength = param1;
      }
      
      public function set dayOffsets(param1:Array) : void
      {
         var_3412 = param1.slice();
      }
      
      public function set averagePrices(param1:Array) : void
      {
         var_3464 = param1.slice();
      }
      
      public function set soldAmounts(param1:Array) : void
      {
         var_3467 = param1.slice();
      }
      
      public function set furniTypeId(param1:int) : void
      {
         var_4685 = param1;
      }
      
      public function set furniCategoryId(param1:int) : void
      {
         var_3882 = param1;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1766
   {
      
      private var var_4594:int;
      
      private var var_4542:int;
      
      private var var_5152:int;
      
      private var var_5026:int;
      
      private var var_3491:Array;
      
      public function class_1766(param1:IMessageDataWrapper)
      {
         super();
         var_4594 = param1.readInteger();
         var_4542 = param1.readInteger();
         var_5152 = param1.readInteger();
         var_5026 = param1.readInteger();
         var_3491 = [];
         var _loc2_:int = param1.readInteger();
         while(0 < _loc2_)
         {
            var_3491.push(param1.readInteger());
            _loc3_++;
         }
      }
      
      public function get maxPurchaseSize() : int
      {
         return var_4594;
      }
      
      public function get bundleSize() : int
      {
         return var_4542;
      }
      
      public function get bundleDiscountSize() : int
      {
         return var_5152;
      }
      
      public function get bonusThreshold() : int
      {
         return var_5026;
      }
      
      public function get additionalBonusDiscountThresholdQuantities() : Array
      {
         return var_3491;
      }
   }
}


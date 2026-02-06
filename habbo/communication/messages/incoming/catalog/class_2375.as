package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2375 extends class_2374
   {
      
      private var var_3812:int;
      
      private var var_4204:int;
      
      private var var_4992:int;
      
      private var var_3978:int;
      
      public function class_2375(param1:IMessageDataWrapper)
      {
         super(param1);
         var_3812 = param1.readInteger();
         var_4204 = param1.readInteger();
         var_4992 = param1.readInteger();
         var_3978 = param1.readInteger();
      }
      
      public function get originalPrice() : int
      {
         return var_3812 * months;
      }
      
      public function get originalActivityPointPrice() : int
      {
         return var_4204 * months;
      }
      
      public function get originalActivityPointType() : int
      {
         return var_4992;
      }
      
      public function get discountCreditAmount() : int
      {
         return var_3812 * months - this.priceCredits;
      }
      
      public function get discountActivityPointAmount() : int
      {
         return originalActivityPointPrice * months - this.priceActivityPoints;
      }
      
      public function get subscriptionDaysLeft() : int
      {
         return var_3978;
      }
   }
}


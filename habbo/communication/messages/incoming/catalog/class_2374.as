package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2374
   {
      
      private var _offerId:int;
      
      private var var_2711:String;
      
      private var var_3791:int;
      
      private var var_4163:int;
      
      private var var_4683:int;
      
      private var var_4001:Boolean;
      
      private var var_3889:int;
      
      private var var_4205:int;
      
      private var var_4822:int;
      
      private var var_2828:int;
      
      private var _month:int;
      
      private var var_4593:int;
      
      private var var_3748:Boolean;
      
      public function class_2374(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         var_2711 = param1.readString();
         param1.readBoolean();
         var_3791 = param1.readInteger();
         var_4163 = param1.readInteger();
         var_4683 = param1.readInteger();
         var_4001 = param1.readBoolean();
         var_3889 = param1.readInteger();
         var_4205 = param1.readInteger();
         var_3748 = param1.readBoolean();
         var_4822 = param1.readInteger();
         var_2828 = param1.readInteger();
         _month = param1.readInteger();
         var_4593 = param1.readInteger();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get priceCredits() : int
      {
         return var_3791;
      }
      
      public function get vip() : Boolean
      {
         return var_4001;
      }
      
      public function get months() : int
      {
         return var_3889;
      }
      
      public function get extraDays() : int
      {
         return var_4205;
      }
      
      public function get daysLeftAfterPurchase() : int
      {
         return var_4822;
      }
      
      public function get year() : int
      {
         return var_2828;
      }
      
      public function get month() : int
      {
         return _month;
      }
      
      public function get day() : int
      {
         return var_4593;
      }
      
      public function get priceActivityPoints() : int
      {
         return var_4163;
      }
      
      public function get priceActivityPointType() : int
      {
         return var_4683;
      }
      
      public function get isGiftable() : Boolean
      {
         return var_3748;
      }
   }
}


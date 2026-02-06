package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2368
   {
      
      private var _offerId:int;
      
      private var var_3598:Boolean;
      
      private var var_4896:Boolean;
      
      private var var_4095:int;
      
      public function class_2368(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         var_3598 = param1.readBoolean();
         var_4095 = param1.readInteger();
         var_4896 = param1.readBoolean();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get isVip() : Boolean
      {
         return var_3598;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_4896;
      }
      
      public function get daysRequired() : int
      {
         return var_4095;
      }
   }
}


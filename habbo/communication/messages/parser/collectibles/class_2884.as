package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2884
   {
      
      private var _offerId:int;
      
      private var var_2711:String;
      
      private var var_4483:int;
      
      private var var_3943:int;
      
      public function class_2884(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         var_2711 = param1.readString();
         var_4483 = param1.readInteger();
         var_3943 = param1.readInteger();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get silverPrice() : int
      {
         return var_4483;
      }
      
      public function get amountTokens() : int
      {
         return var_3943;
      }
   }
}


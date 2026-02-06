package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCancelOfferResultEventParser implements IMessageParser
   {
      
      private var _offerId:int;
      
      private var var_2614:Boolean;
      
      public function MarketplaceCancelOfferResultEventParser()
      {
         super();
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offerId = param1.readInteger();
         var_2614 = param1.readBoolean();
         return true;
      }
   }
}


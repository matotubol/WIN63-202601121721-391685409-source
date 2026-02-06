package com.sulake.habbo.communication.messages.parser.perk
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CitizenshipVipOfferPromoEnabledEventParser implements IMessageParser
   {
      
      public function CitizenshipVipOfferPromoEnabledEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return true;
      }
   }
}


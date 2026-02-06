package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultEventParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceBuyOfferResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MarketplaceBuyOfferResultEvent(param1:Function)
      {
         super(param1,MarketplaceBuyOfferResultEventParser);
      }
      
      public function getParser() : MarketplaceBuyOfferResultEventParser
      {
         return var_15 as MarketplaceBuyOfferResultEventParser;
      }
   }
}


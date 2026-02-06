package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultEventParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCancelOfferResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MarketplaceCancelOfferResultEvent(param1:Function)
      {
         super(param1,MarketplaceCancelOfferResultEventParser);
      }
      
      public function getParser() : MarketplaceCancelOfferResultEventParser
      {
         return var_15 as MarketplaceCancelOfferResultEventParser;
      }
   }
}


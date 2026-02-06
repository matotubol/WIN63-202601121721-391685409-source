package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersEventParser;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOwnOffersEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MarketPlaceOwnOffersEvent(param1:Function)
      {
         super(param1,MarketPlaceOwnOffersEventParser);
      }
      
      public function getParser() : MarketPlaceOwnOffersEventParser
      {
         return var_15 as MarketPlaceOwnOffersEventParser;
      }
   }
}


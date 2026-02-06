package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersEventParser;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOffersEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MarketPlaceOffersEvent(param1:Function)
      {
         super(param1,MarketPlaceOffersEventParser);
      }
      
      public function getParser() : MarketPlaceOffersEventParser
      {
         return var_15 as MarketPlaceOffersEventParser;
      }
   }
}


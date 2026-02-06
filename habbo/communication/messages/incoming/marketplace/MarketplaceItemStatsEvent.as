package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsEventParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceItemStatsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MarketplaceItemStatsEvent(param1:Function)
      {
         super(param1,MarketplaceItemStatsEventParser);
      }
      
      public function getParser() : MarketplaceItemStatsEventParser
      {
         return var_15 as MarketplaceItemStatsEventParser;
      }
   }
}


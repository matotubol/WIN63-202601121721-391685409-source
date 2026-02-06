package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationEventParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceConfigurationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MarketplaceConfigurationEvent(param1:Function)
      {
         super(param1,MarketplaceConfigurationEventParser);
      }
      
      public function getParser() : MarketplaceConfigurationEventParser
      {
         return var_15 as MarketplaceConfigurationEventParser;
      }
   }
}


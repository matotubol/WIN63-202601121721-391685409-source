package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageWithEarliestExpiryMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageWithEarliestExpiryMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CatalogPageWithEarliestExpiryMessageEvent(param1:Function)
      {
         super(param1,CatalogPageWithEarliestExpiryMessageEventParser);
      }
      
      public function getParser() : CatalogPageWithEarliestExpiryMessageEventParser
      {
         return this.var_15 as CatalogPageWithEarliestExpiryMessageEventParser;
      }
   }
}


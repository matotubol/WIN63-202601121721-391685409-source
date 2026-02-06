package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPublishedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPublishedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CatalogPublishedMessageEvent(param1:Function)
      {
         super(param1,CatalogPublishedMessageEventParser);
      }
      
      public function getParser() : CatalogPublishedMessageEventParser
      {
         return this.var_15 as CatalogPublishedMessageEventParser;
      }
      
      public function get instantlyRefreshCatalogue() : Boolean
      {
         return getParser().instantlyRefreshCatalogue;
      }
      
      public function get newFurniDataHash() : String
      {
         return getParser().newFurniDataHash;
      }
   }
}


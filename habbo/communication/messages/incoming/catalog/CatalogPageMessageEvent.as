package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CatalogPageMessageEvent(param1:Function)
      {
         super(param1,CatalogPageMessageEventParser);
      }
      
      public function getParser() : CatalogPageMessageEventParser
      {
         return this.var_15 as CatalogPageMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogIndexMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CatalogIndexMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CatalogIndexMessageEvent(param1:Function)
      {
         super(param1,CatalogIndexMessageEventParser);
      }
      
      public function getParser() : CatalogIndexMessageEventParser
      {
         return this.var_15 as CatalogIndexMessageEventParser;
      }
      
      public function get root() : class_2971
      {
         return getParser().root;
      }
      
      public function get newAdditionsAvailable() : Boolean
      {
         return getParser().newAdditionsAvailable;
      }
      
      public function get catalogType() : String
      {
         return getParser().catalogType;
      }
   }
}


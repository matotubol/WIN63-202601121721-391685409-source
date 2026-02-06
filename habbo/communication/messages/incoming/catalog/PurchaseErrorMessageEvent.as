package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseErrorMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PurchaseErrorMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PurchaseErrorMessageEvent(param1:Function)
      {
         super(param1,PurchaseErrorMessageEventParser);
      }
      
      public function getParser() : PurchaseErrorMessageEventParser
      {
         return this.var_15 as PurchaseErrorMessageEventParser;
      }
   }
}


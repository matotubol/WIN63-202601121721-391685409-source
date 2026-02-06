package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseNotAllowedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PurchaseNotAllowedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PurchaseNotAllowedMessageEvent(param1:Function)
      {
         super(param1,PurchaseNotAllowedMessageEventParser);
      }
      
      public function getParser() : PurchaseNotAllowedMessageEventParser
      {
         return this.var_15 as PurchaseNotAllowedMessageEventParser;
      }
   }
}


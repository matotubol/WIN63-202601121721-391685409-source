package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PurchaseOKMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PurchaseOKMessageEvent(param1:Function)
      {
         super(param1,PurchaseOKMessageEventParser);
      }
      
      public function getParser() : PurchaseOKMessageEventParser
      {
         return this.var_15 as PurchaseOKMessageEventParser;
      }
   }
}


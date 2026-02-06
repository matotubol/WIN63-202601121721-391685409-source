package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.GiftReceiverNotFoundEventParser;
   
   [SecureSWF(rename="true")]
   public class GiftReceiverNotFoundEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GiftReceiverNotFoundEvent(param1:Function)
      {
         super(param1,GiftReceiverNotFoundEventParser);
      }
      
      public function getParser() : GiftReceiverNotFoundEventParser
      {
         return this.var_15 as GiftReceiverNotFoundEventParser;
      }
   }
}


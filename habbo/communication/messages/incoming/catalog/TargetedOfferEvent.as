package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.TargetedOfferEventParser;
   
   [SecureSWF(rename="true")]
   public class TargetedOfferEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TargetedOfferEvent(param1:Function)
      {
         super(param1,TargetedOfferEventParser);
      }
      
      public function getParser() : TargetedOfferEventParser
      {
         return this.var_15 as TargetedOfferEventParser;
      }
   }
}


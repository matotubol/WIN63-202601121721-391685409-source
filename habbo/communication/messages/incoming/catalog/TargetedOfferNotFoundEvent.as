package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.TargetedOfferNotFoundEventParser;
   
   [SecureSWF(rename="true")]
   public class TargetedOfferNotFoundEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TargetedOfferNotFoundEvent(param1:Function)
      {
         super(param1,TargetedOfferNotFoundEventParser);
      }
      
      public function getParser() : TargetedOfferNotFoundEventParser
      {
         return this.var_15 as TargetedOfferNotFoundEventParser;
      }
   }
}


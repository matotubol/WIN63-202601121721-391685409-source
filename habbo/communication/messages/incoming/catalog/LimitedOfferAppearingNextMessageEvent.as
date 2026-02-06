package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.LimitedOfferAppearingNextMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class LimitedOfferAppearingNextMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function LimitedOfferAppearingNextMessageEvent(param1:Function)
      {
         super(param1,LimitedOfferAppearingNextMessageEventParser);
      }
      
      public function getParser() : LimitedOfferAppearingNextMessageEventParser
      {
         return this.var_15 as LimitedOfferAppearingNextMessageEventParser;
      }
   }
}


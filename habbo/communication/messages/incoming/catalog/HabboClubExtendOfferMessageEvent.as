package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboClubExtendOfferMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboClubExtendOfferMessageEvent(param1:Function)
      {
         super(param1,HabboClubExtendOfferMessageEventParser);
      }
      
      public function getParser() : HabboClubExtendOfferMessageEventParser
      {
         return this.var_15 as HabboClubExtendOfferMessageEventParser;
      }
   }
}


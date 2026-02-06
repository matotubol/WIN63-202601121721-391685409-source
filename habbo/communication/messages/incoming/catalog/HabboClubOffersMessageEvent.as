package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboClubOffersMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboClubOffersMessageEvent(param1:Function)
      {
         super(param1,HabboClubOffersMessageEventParser);
      }
      
      public function getParser() : HabboClubOffersMessageEventParser
      {
         return this.var_15 as HabboClubOffersMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.perk
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PerkAllowancesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PerkAllowancesMessageEvent(param1:Function)
      {
         super(param1,PerkAllowancesMessageEventParser);
      }
      
      public function getParser() : PerkAllowancesMessageEventParser
      {
         return var_15 as PerkAllowancesMessageEventParser;
      }
   }
}


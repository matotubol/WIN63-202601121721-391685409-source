package com.sulake.habbo.communication.messages.incoming.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.EmeraldBalanceMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class EmeraldBalanceMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function EmeraldBalanceMessageEvent(param1:Function)
      {
         super(param1,EmeraldBalanceMessageEventParser);
      }
      
      public function getParser() : EmeraldBalanceMessageEventParser
      {
         return var_15 as EmeraldBalanceMessageEventParser;
      }
   }
}


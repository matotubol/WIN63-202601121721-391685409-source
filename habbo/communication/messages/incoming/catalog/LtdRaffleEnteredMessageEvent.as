package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.LtdRaffleEnteredMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class LtdRaffleEnteredMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function LtdRaffleEnteredMessageEvent(param1:Function)
      {
         super(param1,LtdRaffleEnteredMessageEventParser);
      }
      
      public function getParser() : LtdRaffleEnteredMessageEventParser
      {
         return var_15 as LtdRaffleEnteredMessageEventParser;
      }
   }
}


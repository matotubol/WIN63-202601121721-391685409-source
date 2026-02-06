package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.LtdRaffleResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class LtdRaffleResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function LtdRaffleResultMessageEvent(param1:Function)
      {
         super(param1,LtdRaffleResultMessageEventParser);
      }
      
      public function getParser() : LtdRaffleResultMessageEventParser
      {
         return var_15 as LtdRaffleResultMessageEventParser;
      }
   }
}


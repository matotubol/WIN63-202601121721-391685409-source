package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeSilverSetMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverSetMessageEvent extends MessageEvent
   {
      
      public function TradeSilverSetMessageEvent(param1:Function)
      {
         super(param1,TradeSilverSetMessageEventParser);
      }
      
      public function getParser() : TradeSilverSetMessageEventParser
      {
         return var_15 as TradeSilverSetMessageEventParser;
      }
   }
}


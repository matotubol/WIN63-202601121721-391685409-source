package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeSilverFeeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverFeeMessageEvent extends MessageEvent
   {
      
      public function TradeSilverFeeMessageEvent(param1:Function)
      {
         super(param1,TradeSilverFeeMessageEventParser);
      }
      
      public function getParser() : TradeSilverFeeMessageEventParser
      {
         return var_15 as TradeSilverFeeMessageEventParser;
      }
   }
}


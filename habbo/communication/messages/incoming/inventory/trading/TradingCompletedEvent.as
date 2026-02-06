package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedEventParser;
   
   [SecureSWF(rename="true")]
   public class TradingCompletedEvent extends MessageEvent
   {
      
      public function TradingCompletedEvent(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function getParser() : TradingCompletedEventParser
      {
         return var_15 as TradingCompletedEventParser;
      }
   }
}


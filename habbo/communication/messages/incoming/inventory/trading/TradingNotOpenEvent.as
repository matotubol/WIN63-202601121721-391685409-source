package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenEventParser;
   
   [SecureSWF(rename="true")]
   public class TradingNotOpenEvent extends MessageEvent
   {
      
      public function TradingNotOpenEvent(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function getParser() : TradingNotOpenEventParser
      {
         return var_15 as TradingNotOpenEventParser;
      }
   }
}


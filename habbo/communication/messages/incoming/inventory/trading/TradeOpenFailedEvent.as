package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeOpenFailedEventParser;
   
   [SecureSWF(rename="true")]
   public class TradeOpenFailedEvent extends MessageEvent
   {
      
      public function TradeOpenFailedEvent(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function getParser() : TradeOpenFailedEventParser
      {
         return var_15 as TradeOpenFailedEventParser;
      }
   }
}


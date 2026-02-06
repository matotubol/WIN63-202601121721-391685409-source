package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenEventParser;
   
   [SecureSWF(rename="true")]
   public class TradingOpenEvent extends MessageEvent
   {
      
      public function TradingOpenEvent(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function get userID() : int
      {
         return getParser().userID;
      }
      
      public function get userCanTrade() : Boolean
      {
         return getParser().userCanTrade;
      }
      
      public function get otherUserID() : int
      {
         return getParser().otherUserID;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return getParser().otherUserCanTrade;
      }
      
      public function getParser() : TradingOpenEventParser
      {
         return var_15 as TradingOpenEventParser;
      }
   }
}


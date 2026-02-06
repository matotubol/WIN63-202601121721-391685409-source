package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListEventParser;
   
   [SecureSWF(rename="true")]
   public class TradingItemListEvent extends MessageEvent
   {
      
      public function TradingItemListEvent(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function get firstUserID() : int
      {
         return getParser().firstUserID;
      }
      
      public function get secondUserID() : int
      {
         return getParser().secondUserID;
      }
      
      public function get firstUserNumItems() : int
      {
         return getParser().firstUserNumItems;
      }
      
      public function get secondUserNumItems() : int
      {
         return getParser().secondUserNumItems;
      }
      
      public function get firstUserNumCredits() : int
      {
         return getParser().firstUserNumCredits;
      }
      
      public function get secondUserNumCredits() : int
      {
         return getParser().secondUserNumCredits;
      }
      
      public function get firstUserItemArray() : Array
      {
         return getParser().firstUserItemArray;
      }
      
      public function get secondUserItemArray() : Array
      {
         return getParser().secondUserItemArray;
      }
      
      public function getParser() : TradingItemListEventParser
      {
         return var_15 as TradingItemListEventParser;
      }
   }
}


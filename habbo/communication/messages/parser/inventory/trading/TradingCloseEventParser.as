package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradingCloseEventParser implements IMessageParser
   {
      
      public static const const_812:int = 1;
      
      private var var_1270:int;
      
      private var var_2352:int;
      
      public function TradingCloseEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_2352 = param1.readInteger();
         return true;
      }
      
      public function get userID() : int
      {
         return var_1270;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
   }
}


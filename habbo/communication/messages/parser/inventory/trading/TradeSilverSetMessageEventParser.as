package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverSetMessageEventParser implements IMessageParser
   {
      
      private var var_2660:int;
      
      private var var_2337:int;
      
      public function TradeSilverSetMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2660 = -1;
         var_2337 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2660 = param1.readInteger();
         var_2337 = param1.readInteger();
         return true;
      }
      
      public function get playerSilver() : int
      {
         return var_2660;
      }
      
      public function get otherPlayerSilver() : int
      {
         return var_2337;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradingAcceptEventParser implements IMessageParser
   {
      
      private var var_3069:int;
      
      private var var_3262:Boolean;
      
      public function TradingAcceptEventParser()
      {
         super();
      }
      
      public function get userID() : int
      {
         return var_3069;
      }
      
      public function get userAccepts() : Boolean
      {
         return var_3262;
      }
      
      public function flush() : Boolean
      {
         var_3069 = -1;
         var_3262 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3069 = param1.readInteger();
         var_3262 = param1.readInteger() > 0;
         return true;
      }
   }
}


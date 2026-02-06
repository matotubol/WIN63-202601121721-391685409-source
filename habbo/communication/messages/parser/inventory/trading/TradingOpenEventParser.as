package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradingOpenEventParser implements IMessageParser
   {
      
      private var var_3069:int;
      
      private var var_3340:Boolean;
      
      private var var_3030:int;
      
      private var var_3185:Boolean;
      
      public function TradingOpenEventParser()
      {
         super();
      }
      
      public function get userID() : int
      {
         return var_3069;
      }
      
      public function get userCanTrade() : Boolean
      {
         return var_3340;
      }
      
      public function get otherUserID() : int
      {
         return var_3030;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return var_3185;
      }
      
      public function flush() : Boolean
      {
         var_3069 = -1;
         var_3340 = false;
         var_3030 = -1;
         var_3185 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3069 = param1.readInteger();
         var_3340 = param1.readInteger() == 1;
         var_3030 = param1.readInteger();
         var_3185 = param1.readInteger() == 1;
         return true;
      }
   }
}


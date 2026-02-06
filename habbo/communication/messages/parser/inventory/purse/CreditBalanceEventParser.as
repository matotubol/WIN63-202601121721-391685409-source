package com.sulake.habbo.communication.messages.parser.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CreditBalanceEventParser implements IMessageParser
   {
      
      private var var_3634:int;
      
      public function CreditBalanceEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3634 = int(param1.readString());
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get balance() : int
      {
         return var_3634;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_4044 implements IMessageParser
   {
      
      private var var_2529:int;
      
      public function class_4044()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2529 = param1.readInteger();
         return true;
      }
      
      public function get itemId() : int
      {
         return var_2529;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3802 implements IMessageParser
   {
      
      private var var_4601:int = 0;
      
      public function class_3802()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4601 = param1.readInteger();
         return true;
      }
      
      public function get endReason() : int
      {
         return var_4601;
      }
   }
}


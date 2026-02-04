package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_2174 implements IMessageParser
   {
      
      private var var_3311:int = 0;
      
      public function class_2174()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3311 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3311 = param1.readInteger();
         return true;
      }
      
      public function get silverBalance() : int
      {
         return var_3311;
      }
   }
}


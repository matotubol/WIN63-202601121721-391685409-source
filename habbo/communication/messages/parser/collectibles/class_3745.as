package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3745 implements IMessageParser
   {
      
      private var var_3116:int = 0;
      
      public function class_3745()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3116 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3116 = param1.readInteger();
         return true;
      }
      
      public function get transferFee() : int
      {
         return var_3116;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3891 implements IMessageParser
   {
      
      private var var_1191:Boolean;
      
      public function class_3891()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1191 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1191 = param1.readBoolean();
         return true;
      }
      
      public function get enabled() : Boolean
      {
         return var_1191;
      }
   }
}


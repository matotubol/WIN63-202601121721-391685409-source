package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_62.class_4082;
   
   [SecureSWF(rename="true")]
   public class class_3876 implements IMessageParser
   {
      
      private var var_24:class_4082;
      
      public function class_3876()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_4082(param1);
         return true;
      }
      
      public function get data() : class_4082
      {
         return var_24;
      }
   }
}


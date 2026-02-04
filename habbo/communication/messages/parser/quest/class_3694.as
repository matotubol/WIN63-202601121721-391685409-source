package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_62.class_4083;
   
   [SecureSWF(rename="true")]
   public class class_3694 implements IMessageParser
   {
      
      private var var_24:class_4083;
      
      public function class_3694()
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
         var_24 = new class_4083(param1);
         return true;
      }
      
      public function get data() : class_4083
      {
         return var_24;
      }
   }
}


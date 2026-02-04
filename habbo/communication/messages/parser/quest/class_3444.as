package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_62.class_2098;
   
   [SecureSWF(rename="true")]
   public class class_3444 implements IMessageParser
   {
      
      private var var_4393:Boolean;
      
      private var var_147:class_2098;
      
      public function class_3444()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4393 = param1.readBoolean();
         var_147 = new class_2098(param1);
         return true;
      }
      
      public function get expired() : Boolean
      {
         return var_4393;
      }
      
      public function get quest() : class_2098
      {
         return var_147;
      }
   }
}


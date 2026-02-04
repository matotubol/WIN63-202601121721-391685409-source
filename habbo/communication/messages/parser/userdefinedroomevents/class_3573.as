package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3034;
   
   [SecureSWF(rename="true")]
   public class class_3573 implements IMessageParser
   {
      
      private var var_2680:class_3034;
      
      public function class_3573()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2680 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2680 = new class_3034(param1);
         return true;
      }
      
      public function get def() : class_3034
      {
         return var_2680;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3525;
   
   [SecureSWF(rename="true")]
   public class class_2488 implements IMessageParser
   {
      
      private var var_2680:class_3525;
      
      public function class_2488()
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
         var_2680 = new class_3525(param1);
         return true;
      }
      
      public function get def() : class_3525
      {
         return var_2680;
      }
   }
}


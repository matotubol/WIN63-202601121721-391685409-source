package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_3429;
   
   [SecureSWF(rename="true")]
   public class ScrSendKickbackInfoMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_3429;
      
      public function ScrSendKickbackInfoMessageEventParser()
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
         var_24 = new class_3429(param1);
         return true;
      }
      
      public function get data() : class_3429
      {
         return var_24;
      }
   }
}


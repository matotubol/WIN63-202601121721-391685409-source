package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HanditemConfigurationMessageEventParser implements IMessageParser
   {
      
      private var var_3235:Boolean = false;
      
      public function HanditemConfigurationMessageEventParser()
      {
         super();
      }
      
      public function get isHanditemControlBlocked() : Boolean
      {
         return var_3235;
      }
      
      public function flush() : Boolean
      {
         var_3235 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3235 = param1.readBoolean();
         return true;
      }
   }
}


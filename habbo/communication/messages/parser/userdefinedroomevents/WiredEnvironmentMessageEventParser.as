package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredEnvironmentMessageEventParser implements IMessageParser
   {
      
      private var var_2167:Boolean;
      
      public function WiredEnvironmentMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2167 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2167 = param1.readBoolean();
         return true;
      }
      
      public function get hasClickUserWired() : Boolean
      {
         return var_2167;
      }
   }
}


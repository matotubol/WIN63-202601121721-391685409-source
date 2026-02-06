package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpDisabledNotifyMessageEventParser implements IMessageParser
   {
      
      private var var_4527:String;
      
      public function CallForHelpDisabledNotifyMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4527 = param1.readString();
         return true;
      }
      
      public function get infoUrl() : String
      {
         return var_4527;
      }
   }
}


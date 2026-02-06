package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionPartnerIsTypingMessageEventParser implements IMessageParser
   {
      
      private var var_874:Boolean;
      
      public function GuideSessionPartnerIsTypingMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_874 = param1.readBoolean();
         return true;
      }
      
      public function get isTyping() : Boolean
      {
         return var_874;
      }
   }
}


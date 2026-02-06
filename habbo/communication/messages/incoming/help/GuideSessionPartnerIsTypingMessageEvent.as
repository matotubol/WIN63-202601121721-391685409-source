package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionPartnerIsTypingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionPartnerIsTypingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideSessionPartnerIsTypingMessageEvent(param1:Function)
      {
         super(param1,GuideSessionPartnerIsTypingMessageEventParser);
      }
      
      public function getParser() : GuideSessionPartnerIsTypingMessageEventParser
      {
         return var_15 as GuideSessionPartnerIsTypingMessageEventParser;
      }
   }
}


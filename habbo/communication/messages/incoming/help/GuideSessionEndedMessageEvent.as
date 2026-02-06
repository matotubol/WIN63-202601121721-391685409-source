package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionEndedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionEndedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideSessionEndedMessageEvent(param1:Function)
      {
         super(param1,GuideSessionEndedMessageEventParser);
      }
      
      public function getParser() : GuideSessionEndedMessageEventParser
      {
         return var_15 as GuideSessionEndedMessageEventParser;
      }
   }
}


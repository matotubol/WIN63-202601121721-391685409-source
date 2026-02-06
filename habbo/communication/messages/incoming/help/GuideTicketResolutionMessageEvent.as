package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideTicketResolutionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketResolutionMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideTicketResolutionMessageEvent(param1:Function)
      {
         super(param1,GuideTicketResolutionMessageEventParser);
      }
      
      public function getParser() : GuideTicketResolutionMessageEventParser
      {
         return var_15 as GuideTicketResolutionMessageEventParser;
      }
   }
}


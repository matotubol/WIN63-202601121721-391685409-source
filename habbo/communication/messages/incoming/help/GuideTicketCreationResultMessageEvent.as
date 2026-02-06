package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideTicketCreationResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketCreationResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuideTicketCreationResultMessageEvent(param1:Function)
      {
         super(param1,GuideTicketCreationResultMessageEventParser);
      }
      
      public function getParser() : GuideTicketCreationResultMessageEventParser
      {
         return var_15 as GuideTicketCreationResultMessageEventParser;
      }
   }
}


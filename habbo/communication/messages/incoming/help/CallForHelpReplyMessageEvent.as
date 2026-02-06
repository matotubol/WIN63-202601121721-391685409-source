package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpReplyMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CallForHelpReplyMessageEvent(param1:Function)
      {
         super(param1,CallForHelpReplyMessageEventParser);
      }
      
      public function getParser() : CallForHelpReplyMessageEventParser
      {
         return var_15 as CallForHelpReplyMessageEventParser;
      }
   }
}


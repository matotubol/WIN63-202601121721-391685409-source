package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpPendingCallsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CallForHelpPendingCallsMessageEvent(param1:Function)
      {
         super(param1,CallForHelpPendingCallsMessageEventParser);
      }
      
      public function getParser() : CallForHelpPendingCallsMessageEventParser
      {
         return var_15 as CallForHelpPendingCallsMessageEventParser;
      }
   }
}


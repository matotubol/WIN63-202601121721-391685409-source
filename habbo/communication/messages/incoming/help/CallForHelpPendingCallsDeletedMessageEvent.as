package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsDeletedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpPendingCallsDeletedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CallForHelpPendingCallsDeletedMessageEvent(param1:Function)
      {
         super(param1,CallForHelpPendingCallsDeletedMessageEventParser);
      }
      
      public function getParser() : CallForHelpPendingCallsDeletedMessageEventParser
      {
         return var_15 as CallForHelpPendingCallsDeletedMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpDisabledNotifyMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpDisabledNotifyMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CallForHelpDisabledNotifyMessageEvent(param1:Function)
      {
         super(param1,CallForHelpDisabledNotifyMessageEventParser);
      }
      
      public function getParser() : CallForHelpDisabledNotifyMessageEventParser
      {
         return var_15 as CallForHelpDisabledNotifyMessageEventParser;
      }
   }
}


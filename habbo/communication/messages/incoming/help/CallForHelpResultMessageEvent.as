package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CallForHelpResultMessageEvent(param1:Function)
      {
         super(param1,CallForHelpResultMessageEventParser);
      }
      
      public function getParser() : CallForHelpResultMessageEventParser
      {
         return var_15 as CallForHelpResultMessageEventParser;
      }
   }
}


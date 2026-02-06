package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IssueCloseNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IssueCloseNotificationMessageEvent(param1:Function)
      {
         super(param1,IssueCloseNotificationMessageEventParser);
      }
      
      public function getParser() : IssueCloseNotificationMessageEventParser
      {
         return var_15 as IssueCloseNotificationMessageEventParser;
      }
   }
}


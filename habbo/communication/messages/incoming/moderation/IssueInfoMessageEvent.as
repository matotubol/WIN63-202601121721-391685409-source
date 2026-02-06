package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IssueInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IssueInfoMessageEvent(param1:Function)
      {
         super(param1,IssueInfoMessageEventParser);
      }
      
      public function getParser() : IssueInfoMessageEventParser
      {
         return var_15 as IssueInfoMessageEventParser;
      }
   }
}


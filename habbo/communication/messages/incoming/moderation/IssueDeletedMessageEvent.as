package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueDeletedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IssueDeletedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IssueDeletedMessageEvent(param1:Function)
      {
         super(param1,IssueDeletedMessageEventParser);
      }
      
      public function getParser() : IssueDeletedMessageEventParser
      {
         return var_15 as IssueDeletedMessageEventParser;
      }
   }
}


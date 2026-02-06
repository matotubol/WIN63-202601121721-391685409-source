package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumThreadsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ForumThreadsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ForumThreadsMessageEvent(param1:Function)
      {
         super(param1,ForumThreadsMessageEventParser);
      }
      
      public function getParser() : ForumThreadsMessageEventParser
      {
         return this.var_15 as ForumThreadsMessageEventParser;
      }
   }
}


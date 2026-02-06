package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumDataMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ForumDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ForumDataMessageEvent(param1:Function)
      {
         super(param1,ForumDataMessageEventParser);
      }
      
      public function getParser() : ForumDataMessageEventParser
      {
         return this.var_15 as ForumDataMessageEventParser;
      }
   }
}


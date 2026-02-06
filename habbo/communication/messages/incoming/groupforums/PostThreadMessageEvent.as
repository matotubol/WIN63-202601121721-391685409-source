package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.PostThreadMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PostThreadMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PostThreadMessageEvent(param1:Function)
      {
         super(param1,PostThreadMessageEventParser);
      }
      
      public function getParser() : PostThreadMessageEventParser
      {
         return this.var_15 as PostThreadMessageEventParser;
      }
   }
}


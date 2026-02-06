package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.PostMessageMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PostMessageMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PostMessageMessageEvent(param1:Function)
      {
         super(param1,PostMessageMessageEventParser);
      }
      
      public function getParser() : PostMessageMessageEventParser
      {
         return this.var_15 as PostMessageMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadMessagesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ThreadMessagesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ThreadMessagesMessageEvent(param1:Function)
      {
         super(param1,ThreadMessagesMessageEventParser);
      }
      
      public function getParser() : ThreadMessagesMessageEventParser
      {
         return this.var_15 as ThreadMessagesMessageEventParser;
      }
   }
}


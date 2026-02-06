package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ChatMessageEvent extends MessageEvent
   {
      
      public function ChatMessageEvent(param1:Function)
      {
         super(param1,ChatMessageEventParser);
      }
      
      public function getParser() : ChatMessageEventParser
      {
         return var_15 as ChatMessageEventParser;
      }
   }
}


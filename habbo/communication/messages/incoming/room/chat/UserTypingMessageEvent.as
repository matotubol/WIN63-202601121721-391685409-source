package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserTypingMessageEvent extends MessageEvent
   {
      
      public function UserTypingMessageEvent(param1:Function)
      {
         super(param1,UserTypingMessageEventParser);
      }
      
      public function getParser() : UserTypingMessageEventParser
      {
         return var_15 as UserTypingMessageEventParser;
      }
   }
}


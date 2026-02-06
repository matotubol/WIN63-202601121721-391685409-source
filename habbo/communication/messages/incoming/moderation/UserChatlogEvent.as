package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogEventParser;
   
   [SecureSWF(rename="true")]
   public class UserChatlogEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserChatlogEvent(param1:Function)
      {
         super(param1,UserChatlogEventParser);
      }
      
      public function getParser() : UserChatlogEventParser
      {
         return var_15 as UserChatlogEventParser;
      }
   }
}


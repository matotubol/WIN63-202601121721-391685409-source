package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserBannedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserBannedMessageEvent(param1:Function)
      {
         super(param1,UserBannedMessageEventParser);
      }
      
      public function getParser() : UserBannedMessageEventParser
      {
         return var_15 as UserBannedMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserNameChangedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserNameChangedMessageEvent(param1:Function)
      {
         super(param1,UserNameChangedMessageEventParser);
      }
      
      public function getParser() : UserNameChangedMessageEventParser
      {
         return var_15 as UserNameChangedMessageEventParser;
      }
   }
}


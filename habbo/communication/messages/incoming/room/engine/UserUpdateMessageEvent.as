package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserUpdateMessageEvent extends MessageEvent
   {
      
      public function UserUpdateMessageEvent(param1:Function)
      {
         super(param1,UserUpdateMessageEventParser);
      }
      
      public function getParser() : UserUpdateMessageEventParser
      {
         return var_15 as UserUpdateMessageEventParser;
      }
   }
}


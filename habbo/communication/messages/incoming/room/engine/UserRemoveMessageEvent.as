package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserRemoveMessageEvent extends MessageEvent
   {
      
      public function UserRemoveMessageEvent(param1:Function)
      {
         super(param1,UserRemoveMessageEventParser);
      }
      
      public function getParser() : UserRemoveMessageEventParser
      {
         return var_15 as UserRemoveMessageEventParser;
      }
   }
}


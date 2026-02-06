package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UsersMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UsersMessageEvent(param1:Function)
      {
         super(param1,UsersMessageEventParser);
      }
      
      public function getParser() : UsersMessageEventParser
      {
         return var_15 as UsersMessageEventParser;
      }
   }
}


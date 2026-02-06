package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectEventParser;
   
   [SecureSWF(rename="true")]
   public class UserObjectEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserObjectEvent(param1:Function)
      {
         super(param1,UserObjectEventParser);
      }
      
      public function getParser() : UserObjectEventParser
      {
         return this.var_15 as UserObjectEventParser;
      }
   }
}


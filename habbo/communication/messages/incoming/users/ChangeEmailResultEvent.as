package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ChangeEmailResultEventParser;
   
   [SecureSWF(rename="true")]
   public class ChangeEmailResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ChangeEmailResultEvent(param1:Function)
      {
         super(param1,ChangeEmailResultEventParser);
      }
      
      public function getParser() : ChangeEmailResultEventParser
      {
         return var_15 as ChangeEmailResultEventParser;
      }
   }
}


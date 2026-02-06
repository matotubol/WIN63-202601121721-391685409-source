package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ScrSendKickbackInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ScrSendKickbackInfoMessageEvent(param1:Function)
      {
         super(param1,ScrSendKickbackInfoMessageEventParser);
      }
      
      public function getParser() : ScrSendKickbackInfoMessageEventParser
      {
         return var_15 as ScrSendKickbackInfoMessageEventParser;
      }
   }
}


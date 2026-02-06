package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoEventParser;
   
   [SecureSWF(rename="true")]
   public class ScrSendUserInfoEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ScrSendUserInfoEvent(param1:Function)
      {
         super(param1,ScrSendUserInfoEventParser);
      }
      
      public function getParser() : ScrSendUserInfoEventParser
      {
         return this.var_15 as ScrSendUserInfoEventParser;
      }
   }
}


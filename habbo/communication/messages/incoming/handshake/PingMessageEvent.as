package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.PingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PingMessageEvent(param1:Function)
      {
         super(param1,PingMessageEventParser);
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CantConnectMessageEvent extends MessageEvent
   {
      
      public function CantConnectMessageEvent(param1:Function)
      {
         super(param1,CantConnectMessageEventParser);
      }
      
      public function getParser() : CantConnectMessageEventParser
      {
         return var_15 as CantConnectMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CloseConnectionMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CloseConnectionMessageEvent(param1:Function)
      {
         super(param1,CloseConnectionMessageEventParser);
      }
      
      public function getParser() : CloseConnectionMessageEventParser
      {
         return var_15 as CloseConnectionMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class OpenConnectionMessageEvent extends MessageEvent
   {
      
      public function OpenConnectionMessageEvent(param1:Function)
      {
         super(param1,OpenConnectionMessageEventParser);
      }
      
      public function getParser() : OpenConnectionMessageEventParser
      {
         return var_15 as OpenConnectionMessageEventParser;
      }
   }
}


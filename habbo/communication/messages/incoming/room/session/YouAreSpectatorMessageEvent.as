package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.YouAreSpectatorMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YouAreSpectatorMessageEvent extends MessageEvent
   {
      
      public function YouAreSpectatorMessageEvent(param1:Function)
      {
         super(param1,YouAreSpectatorMessageEventParser);
      }
      
      public function getParser() : YouAreSpectatorMessageEventParser
      {
         return var_15 as YouAreSpectatorMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YouArePlayingGameMessageEvent extends MessageEvent
   {
      
      public function YouArePlayingGameMessageEvent(param1:Function)
      {
         super(param1,YouArePlayingGameMessageEventParser);
      }
      
      public function getParser() : YouArePlayingGameMessageEventParser
      {
         return var_15 as YouArePlayingGameMessageEventParser;
      }
   }
}


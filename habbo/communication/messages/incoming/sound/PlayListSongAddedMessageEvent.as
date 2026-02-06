package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PlayListSongAddedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PlayListSongAddedMessageEvent(param1:Function)
      {
         super(param1,PlayListSongAddedMessageEventParser);
      }
      
      public function getParser() : PlayListSongAddedMessageEventParser
      {
         return this.var_15 as PlayListSongAddedMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class JukeboxSongDisksMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function JukeboxSongDisksMessageEvent(param1:Function)
      {
         super(param1,JukeboxSongDisksMessageEventParser);
      }
      
      public function getParser() : JukeboxSongDisksMessageEventParser
      {
         return this.var_15 as JukeboxSongDisksMessageEventParser;
      }
   }
}


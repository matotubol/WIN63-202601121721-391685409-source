package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylistsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeDisplayPlaylistsMessageEvent extends MessageEvent
   {
      
      public function YoutubeDisplayPlaylistsMessageEvent(param1:Function)
      {
         super(param1,YoutubeDisplayPlaylistsMessageEventParser);
      }
      
      public function getParser() : YoutubeDisplayPlaylistsMessageEventParser
      {
         return parser as YoutubeDisplayPlaylistsMessageEventParser;
      }
   }
}


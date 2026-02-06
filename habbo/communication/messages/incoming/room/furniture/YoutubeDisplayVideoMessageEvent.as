package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayVideoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeDisplayVideoMessageEvent extends MessageEvent
   {
      
      public function YoutubeDisplayVideoMessageEvent(param1:Function)
      {
         super(param1,YoutubeDisplayVideoMessageEventParser);
      }
      
      public function getParser() : YoutubeDisplayVideoMessageEventParser
      {
         return parser as YoutubeDisplayVideoMessageEventParser;
      }
   }
}


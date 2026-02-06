package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeControlVideoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeControlVideoMessageEvent extends MessageEvent
   {
      
      public function YoutubeControlVideoMessageEvent(param1:Function)
      {
         super(param1,YoutubeControlVideoMessageEventParser);
      }
      
      public function getParser() : YoutubeControlVideoMessageEventParser
      {
         return parser as YoutubeControlVideoMessageEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomFilterSettingsMessageEvent extends MessageEvent
   {
      
      public function RoomFilterSettingsMessageEvent(param1:Function)
      {
         super(param1,RoomFilterSettingsMessageEventParser);
      }
      
      public function getParser() : RoomFilterSettingsMessageEventParser
      {
         return var_15 as RoomFilterSettingsMessageEventParser;
      }
   }
}


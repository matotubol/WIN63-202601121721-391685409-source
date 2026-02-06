package com.sulake.habbo.communication.messages.incoming.room.layout
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.layout.RoomEntryTileMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomEntryTileMessageEvent extends MessageEvent
   {
      
      public function RoomEntryTileMessageEvent(param1:Function)
      {
         super(param1,RoomEntryTileMessageEventParser);
      }
      
      public function getParser() : RoomEntryTileMessageEventParser
      {
         return var_15 as RoomEntryTileMessageEventParser;
      }
   }
}


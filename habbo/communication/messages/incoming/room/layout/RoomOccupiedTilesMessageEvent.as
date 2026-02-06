package com.sulake.habbo.communication.messages.incoming.room.layout
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.layout.RoomOccupiedTilesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomOccupiedTilesMessageEvent extends MessageEvent
   {
      
      public function RoomOccupiedTilesMessageEvent(param1:Function)
      {
         super(param1,RoomOccupiedTilesMessageEventParser);
      }
      
      public function getParser() : RoomOccupiedTilesMessageEventParser
      {
         return var_15 as RoomOccupiedTilesMessageEventParser;
      }
   }
}


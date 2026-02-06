package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerPresetsMessageEvent extends MessageEvent
   {
      
      public function RoomDimmerPresetsMessageEvent(param1:Function)
      {
         super(param1,RoomDimmerPresetsMessageEventParser);
      }
      
      public function getParser() : RoomDimmerPresetsMessageEventParser
      {
         return var_15 as RoomDimmerPresetsMessageEventParser;
      }
   }
}


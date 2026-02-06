package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomQueueStatusMessageEvent extends MessageEvent
   {
      
      public function RoomQueueStatusMessageEvent(param1:Function)
      {
         super(param1,RoomQueueStatusMessageEventParser);
      }
      
      public function getParser() : RoomQueueStatusMessageEventParser
      {
         return var_15 as RoomQueueStatusMessageEventParser;
      }
   }
}


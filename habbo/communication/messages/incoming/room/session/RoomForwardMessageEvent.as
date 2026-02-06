package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomForwardMessageEvent extends MessageEvent
   {
      
      public function RoomForwardMessageEvent(param1:Function)
      {
         super(param1,RoomForwardMessageEventParser);
      }
      
      public function getParser() : RoomForwardMessageEventParser
      {
         return var_15 as RoomForwardMessageEventParser;
      }
   }
}


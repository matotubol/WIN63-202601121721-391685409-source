package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomEntryInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomEntryInfoMessageEvent(param1:Function)
      {
         super(param1,RoomEntryInfoMessageEventParser);
      }
      
      public function getParser() : RoomEntryInfoMessageEventParser
      {
         return var_15 as RoomEntryInfoMessageEventParser;
      }
   }
}


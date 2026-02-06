package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomInfoUpdatedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomInfoUpdatedEvent(param1:Function)
      {
         super(param1,RoomInfoUpdatedEventParser);
      }
      
      public function getParser() : RoomInfoUpdatedEventParser
      {
         return this.var_15 as RoomInfoUpdatedEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomEventEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomEventEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomEventEvent(param1:Function)
      {
         super(param1,RoomEventEventParser);
      }
      
      public function getParser() : RoomEventEventParser
      {
         return this.var_15 as RoomEventEventParser;
      }
   }
}


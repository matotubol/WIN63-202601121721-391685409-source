package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomReadyMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomReadyMessageEvent(param1:Function)
      {
         super(param1,RoomReadyMessageEventParser);
      }
      
      public function getParser() : RoomReadyMessageEventParser
      {
         return var_15 as RoomReadyMessageEventParser;
      }
   }
}


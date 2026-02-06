package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomEventCancelEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomEventCancelEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomEventCancelEvent(param1:Function)
      {
         super(param1,RoomEventCancelEventParser);
      }
   }
}


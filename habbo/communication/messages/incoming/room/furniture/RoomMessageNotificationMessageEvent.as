package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomMessageNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomMessageNotificationMessageEvent(param1:Function)
      {
         super(param1,RoomMessageNotificationMessageEventParser);
      }
      
      public function getParser() : RoomMessageNotificationMessageEventParser
      {
         return var_15 as RoomMessageNotificationMessageEventParser;
      }
   }
}


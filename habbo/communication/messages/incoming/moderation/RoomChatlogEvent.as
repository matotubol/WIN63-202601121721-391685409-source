package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.RoomChatlogEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomChatlogEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomChatlogEvent(param1:Function)
      {
         super(param1,RoomChatlogEventParser);
      }
      
      public function getParser() : RoomChatlogEventParser
      {
         return var_15 as RoomChatlogEventParser;
      }
   }
}


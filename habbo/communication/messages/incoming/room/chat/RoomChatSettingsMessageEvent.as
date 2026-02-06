package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.RoomChatSettingsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomChatSettingsMessageEvent extends MessageEvent
   {
      
      public function RoomChatSettingsMessageEvent(param1:Function)
      {
         super(param1,RoomChatSettingsMessageEventParser);
      }
      
      public function getParser() : RoomChatSettingsMessageEventParser
      {
         return var_15 as RoomChatSettingsMessageEventParser;
      }
   }
}


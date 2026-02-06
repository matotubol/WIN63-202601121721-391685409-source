package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorRoomInfoEventParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorRoomInfoEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ModeratorRoomInfoEvent(param1:Function)
      {
         super(param1,ModeratorRoomInfoEventParser);
      }
      
      public function getParser() : ModeratorRoomInfoEventParser
      {
         return var_15 as ModeratorRoomInfoEventParser;
      }
   }
}


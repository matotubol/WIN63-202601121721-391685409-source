package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.RoomVisitsEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomVisitsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomVisitsEvent(param1:Function)
      {
         super(param1,RoomVisitsEventParser);
      }
      
      public function getParser() : RoomVisitsEventParser
      {
         return var_15 as RoomVisitsEventParser;
      }
   }
}


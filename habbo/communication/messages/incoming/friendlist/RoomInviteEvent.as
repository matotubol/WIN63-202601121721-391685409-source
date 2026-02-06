package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomInviteEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomInviteEvent(param1:Function)
      {
         super(param1,RoomInviteEventParser);
      }
      
      public function getParser() : RoomInviteEventParser
      {
         return this.var_15 as RoomInviteEventParser;
      }
   }
}


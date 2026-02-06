package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomInviteErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomInviteErrorEvent(param1:Function)
      {
         super(param1,RoomInviteErrorEventParser);
      }
      
      public function getParser() : RoomInviteErrorEventParser
      {
         return this.var_15 as RoomInviteErrorEventParser;
      }
   }
}


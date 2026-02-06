package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.BannedUsersFromRoomEventParser;
   
   [SecureSWF(rename="true")]
   public class BannedUsersFromRoomEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BannedUsersFromRoomEvent(param1:Function)
      {
         super(param1,BannedUsersFromRoomEventParser);
      }
      
      public function getParser() : BannedUsersFromRoomEventParser
      {
         return this.var_15 as BannedUsersFromRoomEventParser;
      }
   }
}


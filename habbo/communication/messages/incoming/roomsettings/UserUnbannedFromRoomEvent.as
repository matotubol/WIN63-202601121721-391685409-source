package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomEventParser;
   
   [SecureSWF(rename="true")]
   public class UserUnbannedFromRoomEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserUnbannedFromRoomEvent(param1:Function)
      {
         super(param1,UserUnbannedFromRoomEventParser);
      }
      
      public function getParser() : UserUnbannedFromRoomEventParser
      {
         return this.var_15 as UserUnbannedFromRoomEventParser;
      }
   }
}


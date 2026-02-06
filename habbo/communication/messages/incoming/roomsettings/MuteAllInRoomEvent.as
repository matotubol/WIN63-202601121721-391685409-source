package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomEventParser;
   
   [SecureSWF(rename="true")]
   public class MuteAllInRoomEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MuteAllInRoomEvent(param1:Function)
      {
         super(param1,MuteAllInRoomEventParser);
      }
      
      public function getParser() : MuteAllInRoomEventParser
      {
         return this.var_15 as MuteAllInRoomEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomSettingsErrorEvent(param1:Function)
      {
         super(param1,RoomSettingsErrorEventParser);
      }
      
      public function getParser() : RoomSettingsErrorEventParser
      {
         return this.var_15 as RoomSettingsErrorEventParser;
      }
   }
}


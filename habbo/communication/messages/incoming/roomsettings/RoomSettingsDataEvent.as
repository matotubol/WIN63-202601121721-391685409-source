package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsDataEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomSettingsDataEvent(param1:Function)
      {
         super(param1,RoomSettingsDataEventParser);
      }
      
      public function getParser() : RoomSettingsDataEventParser
      {
         return this.var_15 as RoomSettingsDataEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsSaveErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomSettingsSaveErrorEvent(param1:Function)
      {
         super(param1,RoomSettingsSaveErrorEventParser);
      }
      
      public function getParser() : RoomSettingsSaveErrorEventParser
      {
         return this.var_15 as RoomSettingsSaveErrorEventParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsSavedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomSettingsSavedEvent(param1:Function)
      {
         super(param1,RoomSettingsSavedEventParser);
      }
      
      public function getParser() : RoomSettingsSavedEventParser
      {
         return this.var_15 as RoomSettingsSavedEventParser;
      }
   }
}


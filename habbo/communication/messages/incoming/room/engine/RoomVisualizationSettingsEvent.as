package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomVisualizationSettingsEvent extends MessageEvent
   {
      
      public function RoomVisualizationSettingsEvent(param1:Function)
      {
         super(param1,RoomVisualizationSettingsEventParser);
      }
      
      public function getParser() : RoomVisualizationSettingsEventParser
      {
         return var_15 as RoomVisualizationSettingsEventParser;
      }
   }
}


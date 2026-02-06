package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.BuildersClubPlacementWarningMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubPlacementWarningMessageEvent extends MessageEvent
   {
      
      public function BuildersClubPlacementWarningMessageEvent(param1:Function)
      {
         super(param1,BuildersClubPlacementWarningMessageEventParser);
      }
      
      public function getParser() : BuildersClubPlacementWarningMessageEventParser
      {
         return var_15 as BuildersClubPlacementWarningMessageEventParser;
      }
   }
}


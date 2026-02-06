package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CompetitionStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionStatusMessageEvent extends MessageEvent
   {
      
      public function CompetitionStatusMessageEvent(param1:Function)
      {
         super(param1,CompetitionStatusMessageEventParser);
      }
      
      public function getParser() : CompetitionStatusMessageEventParser
      {
         return this.var_15 as CompetitionStatusMessageEventParser;
      }
   }
}


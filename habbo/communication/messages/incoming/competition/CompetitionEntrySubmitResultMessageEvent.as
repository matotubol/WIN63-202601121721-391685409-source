package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.CompetitionEntrySubmitResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionEntrySubmitResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CompetitionEntrySubmitResultMessageEvent(param1:Function)
      {
         super(param1,CompetitionEntrySubmitResultMessageEventParser);
      }
      
      public function getParser() : CompetitionEntrySubmitResultMessageEventParser
      {
         return var_15 as CompetitionEntrySubmitResultMessageEventParser;
      }
   }
}


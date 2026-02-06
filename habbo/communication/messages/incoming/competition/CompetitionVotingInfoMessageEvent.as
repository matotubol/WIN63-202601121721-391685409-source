package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.CompetitionVotingInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionVotingInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CompetitionVotingInfoMessageEvent(param1:Function)
      {
         super(param1,CompetitionVotingInfoMessageEventParser);
      }
      
      public function getParser() : CompetitionVotingInfoMessageEventParser
      {
         return var_15 as CompetitionVotingInfoMessageEventParser;
      }
   }
}


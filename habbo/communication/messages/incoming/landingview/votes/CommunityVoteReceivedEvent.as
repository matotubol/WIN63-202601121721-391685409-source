package com.sulake.habbo.communication.messages.incoming.landingview.votes
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.landingview.votes.CommunityVoteReceivedEventParser;
   
   [SecureSWF(rename="true")]
   public class CommunityVoteReceivedEvent extends MessageEvent
   {
      
      public function CommunityVoteReceivedEvent(param1:Function)
      {
         super(param1,CommunityVoteReceivedEventParser);
      }
      
      public function getParser() : CommunityVoteReceivedEventParser
      {
         return var_15 as CommunityVoteReceivedEventParser;
      }
   }
}


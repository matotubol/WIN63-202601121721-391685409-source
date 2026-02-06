package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.IsUserPartOfCompetitionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IsUserPartOfCompetitionMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IsUserPartOfCompetitionMessageEvent(param1:Function)
      {
         super(param1,IsUserPartOfCompetitionMessageEventParser);
      }
      
      public function getParser() : IsUserPartOfCompetitionMessageEventParser
      {
         return var_15 as IsUserPartOfCompetitionMessageEventParser;
      }
   }
}


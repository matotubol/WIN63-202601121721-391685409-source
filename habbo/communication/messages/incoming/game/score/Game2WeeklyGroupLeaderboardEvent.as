package com.sulake.habbo.communication.messages.incoming.game.score
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyGroupLeaderboardParser;
   
   public class Game2WeeklyGroupLeaderboardEvent extends MessageEvent
   {
      
      public function Game2WeeklyGroupLeaderboardEvent(param1:Function)
      {
         super(param1,Game2WeeklyGroupLeaderboardParser);
      }
      
      public function getParser() : Game2WeeklyGroupLeaderboardParser
      {
         return this.var_15 as Game2WeeklyGroupLeaderboardParser;
      }
   }
}


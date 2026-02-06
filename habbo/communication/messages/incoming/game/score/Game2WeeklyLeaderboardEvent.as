package com.sulake.habbo.communication.messages.incoming.game.score
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyLeaderboardParser;
   
   public class Game2WeeklyLeaderboardEvent extends MessageEvent
   {
      
      public function Game2WeeklyLeaderboardEvent(param1:Function)
      {
         super(param1,Game2WeeklyLeaderboardParser);
      }
      
      public function getParser() : Game2WeeklyLeaderboardParser
      {
         return this.var_15 as Game2WeeklyLeaderboardParser;
      }
   }
}


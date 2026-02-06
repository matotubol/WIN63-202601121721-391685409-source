package com.sulake.habbo.communication.messages.incoming.game.score
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2GroupLeaderboardParser;
   
   public class Game2TotalGroupLeaderboardEvent extends MessageEvent
   {
      
      public function Game2TotalGroupLeaderboardEvent(param1:Function)
      {
         super(param1,Game2GroupLeaderboardParser);
      }
      
      public function getParser() : Game2GroupLeaderboardParser
      {
         return this.var_15 as Game2GroupLeaderboardParser;
      }
   }
}


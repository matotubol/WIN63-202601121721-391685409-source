package com.sulake.habbo.communication.messages.incoming.game.score
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2LeaderboardParser;
   
   public class Game2FriendsLeaderboardEvent extends MessageEvent
   {
      
      public function Game2FriendsLeaderboardEvent(param1:Function)
      {
         super(param1,Game2LeaderboardParser);
      }
      
      public function getParser() : Game2LeaderboardParser
      {
         return this.var_15 as Game2LeaderboardParser;
      }
   }
}


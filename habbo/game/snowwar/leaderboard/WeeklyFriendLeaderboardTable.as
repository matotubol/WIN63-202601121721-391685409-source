package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import package_108.Game2GetWeeklyFriendsLeaderboardComposer;
   
   public class WeeklyFriendLeaderboardTable extends LeaderboardTable
   {
      
      private var _offset:int = 0;
      
      private var _maxOffset:int = 0;
      
      public function WeeklyFriendLeaderboardTable(param1:SnowWarEngine)
      {
         super(param1);
      }
      
      public function get offset() : int
      {
         return _offset;
      }
      
      public function set offset(param1:int) : void
      {
         if(param1 >= 0 && param1 <= _maxOffset)
         {
            _offset = param1;
         }
      }
      
      public function get maxOffset() : int
      {
         return _maxOffset;
      }
      
      public function set maxOffset(param1:int) : void
      {
         _maxOffset = param1;
      }
      
      override protected function getMessageComposer(param1:int, param2:int, param3:int) : IMessageComposer
      {
         return new Game2GetWeeklyFriendsLeaderboardComposer(param1,_offset,param2,param3,var_222,var_956);
      }
   }
}


package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalGroupLeaderboardComposer;
   import com.sulake.habbo.communication.messages.parser.game.score.class_3963;
   
   public class TotalGroupLeaderboardTable extends LeaderboardTable
   {
      
      private var _ownEntry:class_3963;
      
      public function TotalGroupLeaderboardTable(param1:SnowWarEngine)
      {
         super(param1);
         var_222 -= 1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _ownEntry = null;
      }
      
      override public function addGroupEntries(param1:Array, param2:int, param3:int) : void
      {
         if(param3 > 0)
         {
            _ownEntry = param1.pop();
         }
         super.addGroupEntries(param1,param2,param3);
      }
      
      override public function getVisibleEntries() : Array
      {
         var _loc1_:Array = super.getVisibleEntries();
         if(_ownEntry)
         {
            _loc1_.push(_ownEntry);
         }
         return _loc1_;
      }
      
      override protected function getMessageComposer(param1:int, param2:int, param3:int) : IMessageComposer
      {
         return new Game2GetTotalGroupLeaderboardComposer(param1,param2,param3,var_222,var_956);
      }
   }
}


package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import package_108.Game2GetTotalLeaderboardComposer;
   import package_202.class_3963;
   
   public class TotalLeaderboardTable extends LeaderboardTable
   {
      
      private var _ownEntry:class_3963;
      
      public function TotalLeaderboardTable(param1:SnowWarEngine)
      {
         super(param1);
         var_222 -= 1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _ownEntry = null;
      }
      
      override public function addEntries(param1:Array, param2:int) : void
      {
         _ownEntry = param1.pop();
         super.addEntries(param1,param2);
      }
      
      override protected function getMessageComposer(param1:int, param2:int, param3:int) : IMessageComposer
      {
         return new Game2GetTotalLeaderboardComposer(param1,param2,param3,var_222,var_956);
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
      
      override protected function initializeList() : void
      {
         var_135 = 0;
      }
   }
}


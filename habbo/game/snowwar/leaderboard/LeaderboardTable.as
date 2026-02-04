package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import package_108.Game2GetFriendsLeaderboardComposer;
   import package_202.class_3963;
   
   public class LeaderboardTable
   {
      
      public static const SCROLL_DOWN:int = 0;
      
      public static const SCROLL_UP:int = 1;
      
      protected var var_49:SnowWarEngine;
      
      protected var var_5406:Boolean;
      
      protected var var_3487:int;
      
      protected var var_2793:int = -1;
      
      protected var _disposed:Boolean;
      
      protected var var_80:Array;
      
      protected var var_135:int = -1;
      
      protected var var_1770:int;
      
      protected var var_222:int = 8;
      
      protected var var_956:int = 50;
      
      protected var var_460:Boolean = true;
      
      protected var var_3511:int;
      
      public function LeaderboardTable(param1:SnowWarEngine)
      {
         super();
         var_49 = param1;
         var_3487 = var_49.sessionDataManager.userId;
         var_222 = var_49.config.getInteger("games.highscores.viewSize",8);
         var_956 = var_49.config.getInteger("games.highscores.windowSize",50);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         disposeTable();
         var_49 = null;
         var_80 = null;
         _disposed = true;
      }
      
      public function disposeTable() : void
      {
         var_135 = -1;
         var_80 = null;
         var_1770 = -1;
         var_460 = true;
      }
      
      public function addEntries(param1:Array, param2:int) : void
      {
         var_1770 = param2;
         if(!var_80)
         {
            var_80 = param1;
            initializeList();
         }
         else
         {
            var_80 = param1;
            updateCurrentIndex();
         }
         var_460 = false;
      }
      
      public function addGroupEntries(param1:Array, param2:int, param3:int) : void
      {
         var_2793 = param3;
         var_1770 = param2;
         if(!var_80)
         {
            var_80 = param1;
            initializeList();
         }
         else
         {
            var_80 = param1;
            updateCurrentIndex();
         }
         var_460 = false;
      }
      
      protected function initializeList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = false;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < var_80.length)
         {
            _loc1_ = (var_80[_loc3_] as class_3963).gender == "g";
            if(!_loc1_ && (var_80[_loc3_] as class_3963).userId == var_3487)
            {
               _loc2_ = _loc3_;
               break;
            }
            if(_loc1_ && (var_80[_loc3_] as class_3963).userId == var_2793)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ >= var_222)
         {
            var_135 = _loc2_ - var_222 / 2;
         }
         else
         {
            var_135 = 0;
         }
      }
      
      private function updateCurrentIndex() : void
      {
         if(var_135 < 0)
         {
            var_135 += var_956;
         }
         else
         {
            var_135 -= var_956;
         }
      }
      
      public function isInitialized() : Boolean
      {
         return var_80 != null;
      }
      
      public function scrollUp() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IMessageComposer = null;
         if(var_460)
         {
            return false;
         }
         var_135 -= var_222;
         if(var_135 < 0)
         {
            if(var_80[0].rank > 1)
            {
               _loc2_ = Math.max(1,var_80[0].rank - var_956);
               _loc1_ = getMessageComposer(var_3511,_loc2_,1);
               var_49.communication.connection.send(_loc1_);
               var_460 = true;
               return false;
            }
            var_135 = 0;
         }
         return true;
      }
      
      protected function getMessageComposer(param1:int, param2:int, param3:int) : IMessageComposer
      {
         return new Game2GetFriendsLeaderboardComposer(param1,param2,param3,var_222,var_956);
      }
      
      public function scrollDown() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IMessageComposer = null;
         if(var_460)
         {
            return false;
         }
         var_135 += var_222;
         if(var_135 + var_222 >= var_80.length)
         {
            if(var_80[var_80.length - 1].rank < var_1770)
            {
               _loc2_ = var_80[var_80.length - 1].rank + 1;
               _loc1_ = getMessageComposer(var_3511,_loc2_,0);
               var_49.communication.connection.send(_loc1_);
               var_460 = true;
               return false;
            }
         }
         return true;
      }
      
      public function revertToDefaultView(param1:int) : void
      {
         disposeTable();
         var _loc2_:IMessageComposer = getMessageComposer(param1,-1,0);
         var_49.communication.connection.send(_loc2_);
         var_460 = true;
         var_3511 = param1;
      }
      
      public function getVisibleEntries() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(!var_80)
         {
            return _loc1_;
         }
         var _loc3_:int = Math.min(var_80.length,var_135 + var_222);
         _loc2_ = var_135;
         while(_loc2_ < _loc3_)
         {
            _loc1_.push(var_80[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function canScrollUp() : Boolean
      {
         if(var_460 || !var_80 || var_80.length == 0)
         {
            return false;
         }
         if(var_80[0].rank == 1 && var_135 <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function canScrollDown() : Boolean
      {
         if(var_460 || !var_80 || var_80.length == 0)
         {
            return false;
         }
         if(var_80[var_80.length - 1].rank >= var_1770 && var_135 + var_222 >= var_80.length)
         {
            return false;
         }
         return true;
      }
      
      public function get viewSize() : int
      {
         return var_222;
      }
      
      public function get favouriteGroupId() : int
      {
         return var_2793;
      }
   }
}


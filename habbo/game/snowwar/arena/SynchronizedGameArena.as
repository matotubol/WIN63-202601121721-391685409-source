package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.class_2694;
   
   public class SynchronizedGameArena implements class_13
   {
      
      private var var_49:SnowWarEngine;
      
      private var var_720:Array;
      
      protected var var_412:int;
      
      private var var_536:int;
      
      private var var_5355:int = 1;
      
      private var var_3204:class_2693;
      
      private var var_1714:class_3117;
      
      private var _checkSums:class_55;
      
      private var var_1134:Boolean = false;
      
      private var var_2888:Boolean = false;
      
      private var _numberOfTeams:int;
      
      private var var_810:Array;
      
      public function SynchronizedGameArena()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         var_49 = null;
         var_720 = null;
         var_3204 = null;
         if(var_1714 != null)
         {
            var_1714.dispose();
            var_1714 = null;
         }
         _checkSums = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function initialize(param1:SnowWarEngine, param2:int) : void
      {
         var_49 = param1;
         var_3204 = new class_2694();
         _checkSums = new class_55();
         var_720 = [];
         _numberOfTeams = param2;
         var_412 = 0;
         var_536 = 0;
         var_720[var_412] = initEmptyEventQueue();
         _checkSums = new class_55();
         resetTeamScores();
      }
      
      public function get gameEngine() : SnowWarEngine
      {
         return var_49;
      }
      
      public function pulse() : void
      {
         gamePulse();
      }
      
      public function gamePulse() : void
      {
         var _loc1_:Array = null;
         var _loc4_:ISynchronizedGameEvent = null;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Turn " + var_412 + " subturn " + (var_536 + 1) + "/" + getNumberOfSubTurns());
         }
         var _loc3_:class_2693 = class_2693(getCurrentStage());
         var _loc2_:Array = var_720[var_412];
         if(_loc2_)
         {
            _loc1_ = _loc2_[var_536];
            while(_loc1_.length > 0)
            {
               _loc4_ = _loc1_.shift() as ISynchronizedGameEvent;
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log("GameInstance::gameTurn: applying event " + _loc4_ + " turn " + var_412 + " subturn " + (var_536 + 1) + "/" + getNumberOfSubTurns());
               }
               _loc4_.apply(_loc3_);
            }
         }
         if(!var_2888)
         {
            _loc3_.subturn();
         }
         if(var_536 >= getNumberOfSubTurns() - 1)
         {
            if(var_412 % var_5355 == 0)
            {
               _checkSums[var_412] = getCurrentStage().calculateChecksum(var_412);
            }
            var_412 = var_412 + 1;
            var_2888 = false;
            if(HabboGamesCom.logEnabled)
            {
               HabboGamesCom.log("Turn:" + var_412);
            }
         }
         var_536 = var_536 + 1;
         if(var_536 >= getNumberOfSubTurns())
         {
            var_536 = 0;
         }
      }
      
      public function addGameEvent(param1:int, param2:int, param3:ISynchronizedGameEvent) : void
      {
         var _loc4_:Array = var_720[param1];
         if(_loc4_ == null)
         {
            _loc4_ = initEmptyEventQueue();
            var_720[param1] = _loc4_;
         }
         _loc4_[param2].push(param3);
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Add game event: " + param3 + " (subturn/turn): " + param2 + "/" + param1);
         }
      }
      
      public function debugEventQueue() : void
      {
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < var_720.length)
         {
            _loc1_ = var_720[_loc5_];
            if(_loc1_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < getNumberOfSubTurns())
               {
                  _loc4_ = _loc1_[_loc6_];
                  if(_loc4_.length != 0)
                  {
                     _loc2_ += _loc5_ + " (" + _loc6_ + ") : ";
                     for each(var _loc3_ in _loc4_)
                     {
                        _loc2_ += _loc3_;
                     }
                     _loc2_ += "\n";
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         HabboGamesCom.log(_loc2_);
      }
      
      public function getNumberOfSubTurns() : int
      {
         return this.getExtension().getNumberOfSubTurns();
      }
      
      public function getTurnNumber() : int
      {
         return var_412;
      }
      
      public function get subturn() : int
      {
         return var_536;
      }
      
      public function getCurrentStage() : class_2693
      {
         return var_3204;
      }
      
      public function getExtension() : class_3117
      {
         return var_1714;
      }
      
      public function setExtension(param1:class_3117) : void
      {
         var_1714 = param1;
         param1.gameArena = this;
      }
      
      public function getCheckSum(param1:int) : int
      {
         return _checkSums[param1];
      }
      
      public function seekToTurn(param1:int, param2:int) : void
      {
         var_412 = param1;
         var_536 = 0;
         _checkSums[param1] = param2;
         var_720 = [];
         var_720[var_412] = initEmptyEventQueue();
         var_2888 = true;
      }
      
      private function initEmptyEventQueue() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < getNumberOfSubTurns())
         {
            _loc2_[_loc1_] = [];
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      private function resetTeamScores() : void
      {
         var_810 = [];
         var _loc1_:int = 0;
         while(0 < _numberOfTeams)
         {
            var_810[0] = 0;
            _loc1_++;
         }
      }
      
      public function addTeamScore(param1:int, param2:int) : void
      {
         if(param1 > 0 && param1 <= _numberOfTeams)
         {
            var _loc3_:* = param1 - 1;
            var _loc4_:* = var_810[_loc3_] + param2;
            var_810[_loc3_] = _loc4_;
         }
      }
      
      public function getTeamScores() : Array
      {
         return var_810;
      }
   }
}


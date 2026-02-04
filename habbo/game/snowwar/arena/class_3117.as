package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.class_13;
   
   public interface class_3117 extends class_13
   {
      
      function createGameStage() : class_2692;
      
      function set gameArena(param1:SynchronizedGameArena) : void;
      
      function pulse() : void;
      
      function getPulseInterval() : int;
      
      function getNumberOfSubTurns() : int;
   }
}


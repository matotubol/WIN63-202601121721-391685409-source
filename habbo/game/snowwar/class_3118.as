package com.sulake.habbo.game.snowwar
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.class_2692;
   import com.sulake.habbo.game.snowwar.arena.class_3117;
   
   public class class_3118 implements class_3117
   {
      
      private var var_112:SynchronizedGameArena;
      
      private var var_1134:Boolean = false;
      
      public function class_3118()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         var_112 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function set gameArena(param1:SynchronizedGameArena) : void
      {
         var_112 = param1;
      }
      
      public function getPulseInterval() : int
      {
         return 50;
      }
      
      public function getNumberOfSubTurns() : int
      {
         return 3;
      }
      
      public function createGameStage() : class_2692
      {
         return new class_2694();
      }
      
      public function pulse() : void
      {
      }
      
      public function isDeathMatch() : Boolean
      {
         return var_112.numberOfTeams == 1;
      }
   }
}


package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   
   public class class_2840 implements ISynchronizedGameEvent
   {
      
      private var var_1134:Boolean = false;
      
      public function class_2840()
      {
         super();
      }
      
      public function apply(param1:class_2693) : void
      {
      }
      
      public function dispose() : void
      {
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
   }
}


package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanLeftGameEvent extends class_2840
   {
      
      private var var_1781:HumanGameObject;
      
      public function HumanLeftGameEvent(param1:HumanGameObject)
      {
         super();
         var_1781 = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1781 = null;
      }
      
      override public function apply(param1:class_2693) : void
      {
         param1.putGameObjectOnDeleteList(var_1781);
         var_1781.onRemove();
      }
   }
}


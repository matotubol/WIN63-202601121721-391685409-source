package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanStartsToMakeASnowballEvent extends class_2840
   {
      
      private var var_1781:HumanGameObject;
      
      public function HumanStartsToMakeASnowballEvent(param1:HumanGameObject)
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
         var_1781.startMakingSnowball();
      }
      
      public function get human() : HumanGameObject
      {
         return var_1781;
      }
   }
}


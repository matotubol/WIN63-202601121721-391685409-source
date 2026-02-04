package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanThrowsSnowballAtHumanEvent extends class_2840
   {
      
      private var var_1781:HumanGameObject;
      
      private var var_2050:HumanGameObject;
      
      private var var_277:int;
      
      public function HumanThrowsSnowballAtHumanEvent(param1:HumanGameObject, param2:HumanGameObject, param3:int)
      {
         super();
         var_1781 = param1;
         var_2050 = param2;
         var_277 = param3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1781 = null;
         var_2050 = null;
         var_277 = 0;
      }
      
      override public function apply(param1:class_2693) : void
      {
         human.throwSnowball(var_2050.currentLocation.x,var_2050.currentLocation.y);
         human.startThrowTimer();
         SnowWarEngine.playSound("HBSTG_snowwar_throw");
      }
      
      public function get human() : HumanGameObject
      {
         return var_1781;
      }
      
      public function get targetHuman() : HumanGameObject
      {
         return var_2050;
      }
      
      public function get trajectory() : int
      {
         return var_277;
      }
   }
}


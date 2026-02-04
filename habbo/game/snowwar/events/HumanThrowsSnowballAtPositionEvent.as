package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanThrowsSnowballAtPositionEvent extends class_2840
   {
      
      private var var_1781:HumanGameObject;
      
      private var var_1440:int;
      
      private var var_1401:int;
      
      private var var_277:int;
      
      public function HumanThrowsSnowballAtPositionEvent(param1:HumanGameObject, param2:int, param3:int, param4:int)
      {
         super();
         this.var_1781 = param1;
         this.var_1440 = param2;
         this.var_1401 = param3;
         this.var_277 = param4;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1781 = null;
      }
      
      override public function apply(param1:class_2693) : void
      {
         human.throwSnowball(targetX,targetY);
         human.startThrowTimer();
         SnowWarEngine.playSound("HBSTG_snowwar_throw");
      }
      
      public function get human() : HumanGameObject
      {
         return var_1781;
      }
      
      public function get targetX() : int
      {
         return var_1440;
      }
      
      public function get targetY() : int
      {
         return var_1401;
      }
      
      public function get trajectory() : int
      {
         return var_277;
      }
   }
}


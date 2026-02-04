package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballGivingGameObject;
   
   public class HumanGetsSnowballsFromMachineEvent extends class_2840
   {
      
      private var var_1781:HumanGameObject;
      
      private var var_2542:SnowballGivingGameObject;
      
      public function HumanGetsSnowballsFromMachineEvent(param1:HumanGameObject, param2:SnowballGivingGameObject)
      {
         super();
         var_1781 = param1;
         var_2542 = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1781 = null;
         var_2542 = null;
      }
      
      override public function apply(param1:class_2693) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HumanGameObject = null;
         var _loc4_:int = var_1781.getRemainingSnowballCapacity();
         if(_loc4_ > 0)
         {
            _loc3_ = var_2542.pickupSnowballs(1);
            if(_loc3_ > 0)
            {
               var_1781.addSnowballs(_loc3_);
               _loc2_ = param1.getGameObject(var_1781.ghostObjectId) as HumanGameObject;
               if(_loc2_)
               {
                  _loc2_.addSnowballs(_loc3_);
               }
               SnowWarEngine.playSound("HBSTG_snowwar_get_snowball");
            }
         }
      }
      
      public function get human() : HumanGameObject
      {
         return var_1781;
      }
   }
}


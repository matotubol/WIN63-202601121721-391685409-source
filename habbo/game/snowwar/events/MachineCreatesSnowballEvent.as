package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   
   public class MachineCreatesSnowballEvent extends class_2840
   {
      
      private var var_2542:SnowballMachineGameObject;
      
      public function MachineCreatesSnowballEvent(param1:SnowballMachineGameObject)
      {
         super();
         var_2542 = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2542 = null;
      }
      
      override public function apply(param1:class_2693) : void
      {
         if(var_2542)
         {
            var_2542.createSnowball();
         }
         else
         {
            HabboGamesCom.log("Too early for this stuff..");
         }
      }
   }
}


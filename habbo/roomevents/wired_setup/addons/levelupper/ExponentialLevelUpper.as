package com.sulake.habbo.roomevents.wired_setup.addons.levelupper
{
   public class ExponentialLevelUpper extends AbstractLevelUpConfig
   {
      
      private var var_4648:int;
      
      private var _strength:Number;
      
      private var var_4315:int;
      
      public function ExponentialLevelUpper(param1:int, param2:int, param3:int)
      {
         super();
         var_4648 = param1;
         _strength = param2 / 100;
         var_4315 = param3;
      }
      
      override public function get maxLevel() : int
      {
         return var_4315;
      }
      
      override public function xpForLevel(param1:int) : Number
      {
         if(param1 < 1)
         {
            return 0;
         }
         return var_4648 * ((Math.pow(1 + _strength,param1 - 1) - 1 + 1e-9) / _strength);
      }
   }
}


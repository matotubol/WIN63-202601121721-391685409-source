package com.sulake.habbo.roomevents.wired_setup.addons.levelupper
{
   public class LinearLevelUpper extends AbstractLevelUpConfig
   {
      
      private var var_5242:int;
      
      private var var_4315:int;
      
      public function LinearLevelUpper(param1:int, param2:int)
      {
         super();
         this.var_5242 = param1;
         this.var_4315 = param2;
      }
      
      override public function get maxLevel() : int
      {
         return var_4315;
      }
      
      override public function xpForLevel(param1:int) : Number
      {
         if(param1 <= 1)
         {
            return 0;
         }
         return var_5242 * (param1 - 1);
      }
   }
}


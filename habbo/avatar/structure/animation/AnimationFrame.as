package com.sulake.habbo.avatar.structure.animation
{
   public class AnimationFrame
   {
      
      private var var_2927:int;
      
      private var var_2054:String;
      
      public function AnimationFrame(param1:XML)
      {
         super();
         var_2927 = parseInt(param1.@number);
         var_2054 = param1.@assetpartdefinition;
      }
      
      public function get number() : int
      {
         return var_2927;
      }
      
      public function get assetPartDefinition() : String
      {
         return var_2054;
      }
   }
}


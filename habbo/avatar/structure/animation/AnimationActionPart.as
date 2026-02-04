package com.sulake.habbo.avatar.structure.animation
{
   public class AnimationActionPart
   {
      
      private var var_353:Array;
      
      public function AnimationActionPart(param1:XML)
      {
         super();
         var_353 = [];
         for each(var _loc3_ in param1.frame)
         {
            var_353.push(new AnimationFrame(_loc3_));
            var _loc2_:int = parseInt(_loc3_.@repeats);
         }
      }
      
      public function get frames() : Array
      {
         return var_353;
      }
   }
}


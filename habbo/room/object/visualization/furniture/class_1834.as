package com.sulake.habbo.room.object.visualization.furniture
{
   public class class_1834 extends AnimatedFurnitureVisualization
   {
      
      private var var_3525:int = 1;
      
      private var var_1948:Number = 0;
      
      public function class_1834()
      {
         super();
      }
      
      override protected function get frameIncrease() : int
      {
         return var_3525;
      }
      
      override protected function updateAnimations(param1:Number) : int
      {
         var_1948 += object.getModel().getNumber("furniture_soundblock_relative_animation_speed");
         var_3525 = var_1948;
         var_1948 -= var_3525;
         return super.updateAnimations(param1);
      }
   }
}


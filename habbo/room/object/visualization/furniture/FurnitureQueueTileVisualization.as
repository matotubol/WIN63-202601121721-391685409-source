package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_385:int = 3;
      
      private static const const_273:int = 2;
      
      private static const ANIMATION_ID_NORMAL:int = 1;
      
      private static const const_1103:int = 15;
      
      private var var_507:Array = [];
      
      private var var_738:int;
      
      public function FurnitureQueueTileVisualization()
      {
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 2)
         {
            var_507 = [];
            var_507.push(1);
            var_738 = 15;
         }
         super.setAnimation(param1);
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(var_738 > 0)
         {
            var_738 = var_738 - 1;
         }
         if(var_738 == 0)
         {
            if(var_507.length > 0)
            {
               super.setAnimation(var_507.shift());
            }
         }
         return super.updateAnimation(param1);
      }
      
      override protected function usesAnimationResetting() : Boolean
      {
         return true;
      }
   }
}


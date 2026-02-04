package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const ANIMATION_ID_OFFSET_SLOW1:int = 20;
      
      private static const ANIMATION_ID_OFFSET_SLOW2:int = 9;
      
      private static const const_385:int = -1;
      
      private var var_507:Array = [];
      
      private var var_983:Boolean = false;
      
      public function FurnitureBottleVisualization()
      {
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            if(!var_983)
            {
               var_983 = true;
               var_507 = [];
               var_507.push(-1);
               return;
            }
         }
         if(param1 >= 0 && param1 <= 7)
         {
            if(var_983)
            {
               var_983 = false;
               var_507 = [];
               var_507.push(20);
               var_507.push(9 + param1);
               var_507.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(0))
         {
            if(var_507.length > 0)
            {
               super.setAnimation(var_507.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}


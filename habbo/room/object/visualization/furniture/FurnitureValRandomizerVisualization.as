package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const ANIMATION_ID_OFFSET_SLOW1:int = 20;
      
      private static const ANIMATION_ID_OFFSET_SLOW2:int = 10;
      
      private static const const_457:int = 31;
      
      private static const const_385:int = 32;
      
      private static const const_1238:int = 30;
      
      private var var_507:Array = [];
      
      private var var_983:Boolean = false;
      
      public function FurnitureValRandomizerVisualization()
      {
         super();
         super.setAnimation(30);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 0)
         {
            if(!var_983)
            {
               var_983 = true;
               var_507 = [];
               var_507.push(31);
               var_507.push(32);
               return;
            }
         }
         if(param1 > 0 && param1 <= 10)
         {
            if(var_983)
            {
               var_983 = false;
               var_507 = [];
               if(direction == 2)
               {
                  var_507.push(20 + 5 - param1);
                  var_507.push(10 + 5 - param1);
               }
               else
               {
                  var_507.push(20 + param1);
                  var_507.push(10 + param1);
               }
               var_507.push(30);
               return;
            }
            super.setAnimation(30);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(11))
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


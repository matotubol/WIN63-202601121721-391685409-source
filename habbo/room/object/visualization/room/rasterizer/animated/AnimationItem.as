package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AnimationItem
   {
      
      private var var_25:Number = 0;
      
      private var var_26:Number = 0;
      
      private var var_2494:Number = 0;
      
      private var var_2541:Number = 0;
      
      private var _bitmapData:BitmapData = null;
      
      public function AnimationItem(param1:Number, param2:Number, param3:Number, param4:Number, param5:BitmapData)
      {
         super();
         var_25 = param1;
         var_26 = param2;
         var_2494 = param3;
         var_2541 = param4;
         if(isNaN(var_25))
         {
            var_25 = 0;
         }
         if(isNaN(var_26))
         {
            var_26 = 0;
         }
         if(isNaN(var_2494))
         {
            var_2494 = 0;
         }
         if(isNaN(var_2541))
         {
            var_2541 = 0;
         }
         _bitmapData = param5;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function dispose() : void
      {
         _bitmapData = null;
      }
      
      public function getPosition(param1:int, param2:int, param3:Number, param4:Number, param5:int) : Point
      {
         var _loc6_:Number = var_25;
         var _loc7_:Number = var_26;
         if(param3 > 0)
         {
            _loc6_ += var_2494 / param3 * param5 / 1000;
         }
         if(param4 > 0)
         {
            _loc7_ += var_2541 / param4 * param5 / 1000;
         }
         var _loc8_:int = _loc6_ % 1 * param1;
         var _loc9_:int = _loc7_ % 1 * param2;
         return new Point(_loc8_,_loc9_);
      }
   }
}


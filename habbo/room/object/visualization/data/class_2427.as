package com.sulake.habbo.room.object.visualization.data
{
   import flash.utils.Dictionary;
   
   public class class_2427
   {
      
      private var _offsetX:Dictionary = new Dictionary();
      
      private var _offsetY:Dictionary = new Dictionary();
      
      public function class_2427()
      {
         super();
      }
      
      public function getOffsetX(param1:int, param2:int) : int
      {
         if(_offsetX[param1] == null)
         {
            return param2;
         }
         return _offsetX[param1];
      }
      
      public function getOffsetY(param1:int, param2:int) : int
      {
         if(_offsetY[param1] == null)
         {
            return param2;
         }
         return _offsetY[param1];
      }
      
      public function setOffset(param1:int, param2:int, param3:int) : void
      {
         _offsetX[param1] = param2;
         _offsetY[param1] = param3;
      }
   }
}


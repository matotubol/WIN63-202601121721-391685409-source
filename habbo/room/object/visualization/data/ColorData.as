package com.sulake.habbo.room.object.visualization.data
{
   public class ColorData
   {
      
      public static const DEFAULT_COLOR:uint = 16777215;
      
      private var _colors:Array = [];
      
      public function ColorData(param1:int)
      {
         super();
         var _loc2_:int = 0;
         while(0 < param1)
         {
            _colors.push(16777215);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         _colors = null;
      }
      
      public function setColor(param1:uint, param2:int) : void
      {
         if(param2 < 0 || param2 >= _colors.length)
         {
            return;
         }
         _colors[param2] = param1;
      }
      
      public function getColor(param1:int) : uint
      {
         if(param1 < 0 || param1 >= _colors.length)
         {
            return 16777215;
         }
         return _colors[param1];
      }
   }
}


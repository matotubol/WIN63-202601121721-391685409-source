package com.sulake.habbo.window.utils
{
   public class class_4053
   {
      
      public function class_4053()
      {
         super();
      }
      
      public static function getUserCountColor(param1:int, param2:int) : uint
      {
         var _loc3_:int = 100 * (param1 / param2);
         if(_loc3_ >= 92)
         {
            return 4290917164;
         }
         if(_loc3_ >= 80)
         {
            return 4294947099;
         }
         if(_loc3_ >= 50)
         {
            return 4294947099;
         }
         if(param1 > 0)
         {
            return 4284723554;
         }
         return 4291545793;
      }
   }
}


package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   public class class_4113
   {
      
      public static var NO_DISPLAY:uint = 0;
      
      private static var var_5227:int = 1;
      
      private static var var_3584:int = 50;
      
      private static var endPercentage:int = 99;
      
      private static var startColor:uint = 12278528;
      
      private static var midColor:uint = 12952320;
      
      private static var endColor:uint = 8958976;
      
      private static var notStartedColor:uint = 8912917;
      
      private static var completionColor:uint = 37130;
      
      public function class_4113()
      {
         super();
      }
      
      public static function getColor(param1:int, param2:int) : uint
      {
         var _loc4_:Number = NaN;
         if(param1 == param2)
         {
            return completionColor;
         }
         if(param1 == 0)
         {
            return notStartedColor;
         }
         var _loc3_:Number = param1 * 100 / param2;
         if(_loc3_ <= var_3584)
         {
            _loc4_ = (_loc3_ - var_5227) / (var_3584 - var_5227);
            return interpolate(startColor,midColor,_loc4_);
         }
         _loc4_ = (_loc3_ - var_3584) / (endPercentage - var_3584);
         return interpolate(midColor,endColor,_loc4_);
      }
      
      private static function interpolate(param1:uint, param2:uint, param3:Number) : uint
      {
         var _loc5_:Object = hexToRGB(param1);
         var _loc4_:Object = hexToRGB(param2);
         var _loc6_:Object = {
            "r":_loc5_.r + param3 * (_loc4_.r - _loc5_.r),
            "g":_loc5_.g + param3 * (_loc4_.g - _loc5_.g),
            "b":_loc5_.b + param3 * (_loc4_.b - _loc5_.b)
         };
         return RGBToHex(_loc6_.r,_loc6_.g,_loc6_.b);
      }
      
      private static function hexToRGB(param1:uint) : Object
      {
         return {
            "r":param1 >> 16 & 0xFF,
            "g":param1 >> 8 & 0xFF,
            "b":param1 & 0xFF
         };
      }
      
      private static function RGBToHex(param1:Number, param2:Number, param3:Number) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
   }
}


package com.sulake.habbo.utils
{
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class class_2724
   {
      
      public function class_2724()
      {
         super();
      }
      
      public static function normalize(param1:Number, param2:Number, param3:Number) : Number
      {
         return (param1 - param2) / (param3 - param2);
      }
      
      public static function lerp(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 * (param3 - param2) + param2;
      }
      
      public static function clamp(param1:Number, param2:Number = 0, param3:Number = 1) : Number
      {
         return Math.max(param2,Math.min(param3,param1));
      }
      
      public static function map(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         return lerp(normalize(param1,param2,param3),param4,param5);
      }
      
      public static function rectangleTransformMatrix(param1:Rectangle, param2:Rectangle) : Matrix
      {
         var _loc3_:Matrix = new Matrix();
         _loc3_.a = param2.width / param1.width;
         _loc3_.d = param2.height / param1.height;
         _loc3_.tx = param2.x - param1.x * _loc3_.a;
         _loc3_.ty = param2.y - param1.y * _loc3_.d;
         return _loc3_;
      }
   }
}


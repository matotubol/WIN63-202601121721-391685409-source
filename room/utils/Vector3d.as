package com.sulake.room.utils
{
   public class Vector3d implements IVector3d
   {
      
      private var var_25:Number;
      
      private var var_26:Number;
      
      private var var_176:Number;
      
      private var _length:Number = NaN;
      
      public function Vector3d(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         var_25 = param1;
         var_26 = param2;
         var_176 = param3;
      }
      
      public static function sum(param1:IVector3d, param2:IVector3d) : Vector3d
      {
         if(param1 == null || param2 == null)
         {
            return null;
         }
         return new Vector3d(param1.x + param2.x,param1.y + param2.y,param1.z + param2.z);
      }
      
      public static function dif(param1:IVector3d, param2:IVector3d) : Vector3d
      {
         if(param1 == null || param2 == null)
         {
            return null;
         }
         return new Vector3d(param1.x - param2.x,param1.y - param2.y,param1.z - param2.z);
      }
      
      public static function product(param1:IVector3d, param2:Number) : Vector3d
      {
         if(param1 == null)
         {
            return null;
         }
         return new Vector3d(param1.x * param2,param1.y * param2,param1.z * param2);
      }
      
      public static function dotProduct(param1:IVector3d, param2:IVector3d) : Number
      {
         if(param1 == null || param2 == null)
         {
            return 0;
         }
         return param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
      }
      
      public static function crossProduct(param1:IVector3d, param2:IVector3d) : Vector3d
      {
         if(param1 == null || param2 == null)
         {
            return null;
         }
         return new Vector3d(param1.y * param2.z - param1.z * param2.y,param1.z * param2.x - param1.x * param2.z,param1.x * param2.y - param1.y * param2.x);
      }
      
      public static function scalarProjection(param1:IVector3d, param2:IVector3d) : Number
      {
         if(param1 == null || param2 == null)
         {
            return -1;
         }
         var _loc3_:Number = param2.length;
         if(_loc3_ > 0)
         {
            return (param1.x * param2.x + param1.y * param2.y + param1.z * param2.z) / _loc3_;
         }
         return -1;
      }
      
      public static function cosAngle(param1:IVector3d, param2:IVector3d) : Number
      {
         if(param1 == null || param2 == null)
         {
            return 0;
         }
         var _loc3_:Number = param1.length * param2.length;
         if(_loc3_ == 0)
         {
            return 0;
         }
         return Vector3d.dotProduct(param1,param2) / _loc3_;
      }
      
      public static function isEqual(param1:IVector3d, param2:IVector3d) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.x == param2.x && param1.y == param2.y && param1.z == param2.z)
         {
            return true;
         }
         return false;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function get length() : Number
      {
         if(isNaN(_length))
         {
            _length = Math.sqrt(var_25 * var_25 + var_26 * var_26 + var_176 * var_176);
         }
         return _length;
      }
      
      public function set x(param1:Number) : void
      {
         var_25 = param1;
         _length = NaN;
      }
      
      public function set y(param1:Number) : void
      {
         var_26 = param1;
         _length = NaN;
      }
      
      public function set z(param1:Number) : void
      {
         var_176 = param1;
         _length = NaN;
      }
      
      public function negate() : void
      {
         var_25 = -var_25;
         var_26 = -var_26;
         var_176 = -var_176;
      }
      
      public function add(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_25 += param1.x;
         var_26 += param1.y;
         var_176 += param1.z;
         _length = NaN;
      }
      
      public function sub(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_25 -= param1.x;
         var_26 -= param1.y;
         var_176 -= param1.z;
         _length = NaN;
      }
      
      public function mul(param1:Number) : void
      {
         var_25 *= param1;
         var_26 *= param1;
         var_176 *= param1;
         _length = NaN;
      }
      
      public function div(param1:Number) : void
      {
         if(param1 != 0)
         {
            var_25 /= param1;
            var_26 /= param1;
            var_176 /= param1;
            _length = NaN;
         }
      }
      
      public function assign(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_25 = param1.x;
         var_26 = param1.y;
         var_176 = param1.z;
         _length = NaN;
      }
      
      public function toString() : String
      {
         return "(" + [var_25,var_26,var_176].join(",") + ")";
      }
   }
}


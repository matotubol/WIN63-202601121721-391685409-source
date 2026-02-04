package com.sulake.habbo.avatar.geometry
{
   public class Vector3D
   {
      
      private var var_25:Number;
      
      private var var_26:Number;
      
      private var var_176:Number;
      
      public function Vector3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         var_25 = param1;
         var_26 = param2;
         var_176 = param3;
      }
      
      public static function dot(param1:Vector3D, param2:Vector3D) : Number
      {
         return param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
      }
      
      public static function cross(param1:Vector3D, param2:Vector3D) : Vector3D
      {
         var _loc3_:Vector3D = new Vector3D();
         _loc3_.x = param1.y * param2.z - param1.z * param2.y;
         _loc3_.y = param1.z * param2.x - param1.x * param2.z;
         _loc3_.z = param1.x * param2.y - param1.y * param2.x;
         return _loc3_;
      }
      
      public static function subtract(param1:Vector3D, param2:Vector3D) : Vector3D
      {
         return new Vector3D(param1.x - param2.x,param1.y - param2.y,param1.z - param2.z);
      }
      
      public function dot(param1:Vector3D) : Number
      {
         return var_25 * param1.x + var_26 * param1.y + var_176 * param1.z;
      }
      
      public function cross(param1:Vector3D) : Vector3D
      {
         var _loc2_:Vector3D = new Vector3D();
         _loc2_.x = var_26 * param1.z - var_176 * param1.y;
         _loc2_.y = var_176 * param1.x - var_25 * param1.z;
         _loc2_.z = var_25 * param1.y - var_26 * param1.x;
         return _loc2_;
      }
      
      public function subtract(param1:Vector3D) : void
      {
         var_25 -= param1.x;
         var_26 -= param1.y;
         var_176 -= param1.z;
      }
      
      public function add(param1:Vector3D) : void
      {
         var_25 += param1.x;
         var_26 += param1.y;
         var_176 += param1.z;
      }
      
      public function normalize() : void
      {
         var _loc1_:Number = 1 / this.length();
         var_25 *= _loc1_;
         var_26 *= _loc1_;
         var_176 *= _loc1_;
      }
      
      public function length() : Number
      {
         return Math.sqrt(var_25 * var_25 + var_26 * var_26 + var_176 * var_176);
      }
      
      public function toString() : String
      {
         return "Vector3D: (" + var_25 + "," + var_26 + "," + var_176 + ")";
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
      
      public function set x(param1:Number) : void
      {
         var_25 = param1;
      }
      
      public function set y(param1:Number) : void
      {
         var_26 = param1;
      }
      
      public function set z(param1:Number) : void
      {
         var_176 = param1;
      }
   }
}


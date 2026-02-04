package com.sulake.habbo.avatar.geometry
{
   public class Matrix4x4
   {
      
      private static const TOLERANS:Number = 1e-18;
      
      public static const const_53:Matrix4x4 = new Matrix4x4(1,0,0,0,1,0,0,0,1);
      
      private var var_24:Array;
      
      public function Matrix4x4(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0)
      {
         super();
         var_24 = [param1,param2,param3,param4,param5,param6,param7,param8,param9];
      }
      
      public static function getXRotationMatrix(param1:Number) : Matrix4x4
      {
         var _loc5_:Number = param1 * 3.141592653589793 / 180;
         var _loc3_:Number = Math.cos(_loc5_);
         var _loc4_:Number = Math.sin(_loc5_);
         return new Matrix4x4(1,0,0,0,_loc3_,-_loc4_,0,_loc4_,_loc3_);
      }
      
      public static function getYRotationMatrix(param1:Number) : Matrix4x4
      {
         var _loc5_:Number = param1 * 3.141592653589793 / 180;
         var _loc3_:Number = Math.cos(_loc5_);
         var _loc4_:Number = Math.sin(_loc5_);
         return new Matrix4x4(_loc3_,0,_loc4_,0,1,0,-_loc4_,0,_loc3_);
      }
      
      public static function getZRotationMatrix(param1:Number) : Matrix4x4
      {
         var _loc5_:Number = param1 * 3.141592653589793 / 180;
         var _loc3_:Number = Math.cos(_loc5_);
         var _loc4_:Number = Math.sin(_loc5_);
         return new Matrix4x4(_loc3_,-_loc4_,0,_loc4_,_loc3_,0,0,0,1);
      }
      
      public function identity() : Matrix4x4
      {
         var_24 = [1,0,0,0,1,0,0,0,1];
         return this;
      }
      
      public function vectorMultiplication(param1:Vector3D) : Vector3D
      {
         var _loc2_:Number = param1.x * var_24[0] + param1.y * var_24[3] + param1.z * var_24[6];
         var _loc3_:Number = param1.x * var_24[1] + param1.y * var_24[4] + param1.z * var_24[7];
         var _loc4_:Number = param1.x * var_24[2] + param1.y * var_24[5] + param1.z * var_24[8];
         return new Vector3D(_loc2_,_loc3_,_loc4_);
      }
      
      public function multiply(param1:Matrix4x4) : Matrix4x4
      {
         var _loc2_:Number = var_24[0] * param1.data[0] + var_24[1] * param1.data[3] + var_24[2] * param1.data[6];
         var _loc3_:Number = var_24[0] * param1.data[1] + var_24[1] * param1.data[4] + var_24[2] * param1.data[7];
         var _loc4_:Number = var_24[0] * param1.data[2] + var_24[1] * param1.data[5] + var_24[2] * param1.data[8];
         var _loc5_:Number = var_24[3] * param1.data[0] + var_24[4] * param1.data[3] + var_24[5] * param1.data[6];
         var _loc6_:Number = var_24[3] * param1.data[1] + var_24[4] * param1.data[4] + var_24[5] * param1.data[7];
         var _loc7_:Number = var_24[3] * param1.data[2] + var_24[4] * param1.data[5] + var_24[5] * param1.data[8];
         var _loc8_:Number = var_24[6] * param1.data[0] + var_24[7] * param1.data[3] + var_24[8] * param1.data[6];
         var _loc9_:Number = var_24[6] * param1.data[1] + var_24[7] * param1.data[4] + var_24[8] * param1.data[7];
         var _loc10_:Number = var_24[6] * param1.data[2] + var_24[7] * param1.data[5] + var_24[8] * param1.data[8];
         return new Matrix4x4(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
      }
      
      public function scalarMultiply(param1:Number) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_24.length)
         {
            var_24[_loc2_] *= param1;
            _loc2_++;
         }
      }
      
      public function rotateX(param1:Number) : Matrix4x4
      {
         var _loc5_:Number = param1 * 3.141592653589793 / 180;
         var _loc2_:Number = Math.cos(_loc5_);
         var _loc4_:Number = Math.sin(_loc5_);
         var _loc3_:Matrix4x4 = new Matrix4x4(1,0,0,0,_loc2_,-_loc4_,0,_loc4_,_loc2_);
         return _loc3_.multiply(this);
      }
      
      public function rotateY(param1:Number) : Matrix4x4
      {
         var _loc5_:Number = param1 * 3.141592653589793 / 180;
         var _loc2_:Number = Math.cos(_loc5_);
         var _loc4_:Number = Math.sin(_loc5_);
         var _loc3_:Matrix4x4 = new Matrix4x4(_loc2_,0,_loc4_,0,1,0,-_loc4_,0,_loc2_);
         return _loc3_.multiply(this);
      }
      
      public function rotateZ(param1:Number) : Matrix4x4
      {
         var _loc5_:Number = param1 * 3.141592653589793 / 180;
         var _loc2_:Number = Math.cos(_loc5_);
         var _loc4_:Number = Math.sin(_loc5_);
         var _loc3_:Matrix4x4 = new Matrix4x4(_loc2_,-_loc4_,0,_loc4_,_loc2_,0,0,0,1);
         return _loc3_.multiply(this);
      }
      
      public function skew() : void
      {
      }
      
      public function transpose() : Matrix4x4
      {
         return new Matrix4x4(var_24[0],var_24[3],var_24[6],var_24[1],var_24[4],var_24[7],var_24[2],var_24[5],var_24[8]);
      }
      
      public function equals(param1:Matrix4x4) : Boolean
      {
         return false;
      }
      
      public function get data() : Array
      {
         return var_24;
      }
   }
}


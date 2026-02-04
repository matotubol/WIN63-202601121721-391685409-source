package com.sulake.habbo.avatar.geometry
{
   public class Node3D
   {
      
      private var var_559:Vector3D;
      
      private var var_3097:Vector3D = new Vector3D();
      
      private var var_4138:Boolean = false;
      
      public function Node3D(param1:Number, param2:Number, param3:Number)
      {
         super();
         var_559 = new Vector3D(param1,param2,param3);
         if(param1 != 0 || param2 != 0 || param3 != 0)
         {
            var_4138 = true;
         }
      }
      
      public function get location() : Vector3D
      {
         return var_559;
      }
      
      public function get transformedLocation() : Vector3D
      {
         return var_3097;
      }
      
      public function applyTransform(param1:Matrix4x4) : void
      {
         if(var_4138)
         {
            var_3097 = param1.vectorMultiplication(var_559);
         }
      }
   }
}


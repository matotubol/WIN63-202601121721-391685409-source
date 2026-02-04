package com.sulake.habbo.avatar.geometry
{
   public class GeometryItem extends Node3D
   {
      
      private var var_197:String;
      
      private var _radius:Number;
      
      private var _normal:Vector3D;
      
      private var _isDoubleSided:Boolean = false;
      
      private var var_4926:Boolean = false;
      
      public function GeometryItem(param1:XML, param2:Boolean = false)
      {
         super(parseFloat(param1.@x),parseFloat(param1.@y),parseFloat(param1.@z));
         var_197 = String(param1.@id);
         _radius = parseFloat(param1.@radius);
         _normal = new Vector3D(parseFloat(param1.@nx),parseFloat(param1.@ny),parseFloat(param1.@nz));
         _isDoubleSided = parseInt(param1.@double) as Boolean;
         var_4926 = param2;
      }
      
      public function getDistance(param1:Vector3D) : Number
      {
         var _loc3_:Number = Math.abs(param1.z - this.transformedLocation.z - _radius);
         var _loc2_:Number = Math.abs(param1.z - this.transformedLocation.z + _radius);
         return Math.min(_loc3_,_loc2_);
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get normal() : Vector3D
      {
         return _normal;
      }
      
      public function get isDoubleSided() : Boolean
      {
         return _isDoubleSided;
      }
      
      public function toString() : String
      {
         return var_197 + ": " + this.location + " - " + this.transformedLocation;
      }
      
      public function get isDynamic() : Boolean
      {
         return var_4926;
      }
   }
}


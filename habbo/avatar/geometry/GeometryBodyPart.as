package com.sulake.habbo.avatar.geometry
{
   import com.sulake.habbo.avatar.class_1827;
   import flash.utils.Dictionary;
   
   public class GeometryBodyPart extends Node3D
   {
      
      private var var_197:String;
      
      private var var_406:Dictionary;
      
      private var _radius:Number;
      
      private var var_373:Dictionary;
      
      public function GeometryBodyPart(param1:XML)
      {
         super(parseFloat(param1.@x),parseFloat(param1.@y),parseFloat(param1.@z));
         _radius = parseFloat(param1.@radius);
         var_197 = String(param1.@id);
         var_406 = new Dictionary();
         var_373 = new Dictionary(true);
         for each(var _loc3_ in param1..item)
         {
            var _loc2_:GeometryItem = new GeometryItem(_loc3_);
            var_406[String(_loc3_.@id)] = null;
         }
      }
      
      public function getDynamicParts(param1:class_1827) : Array
      {
         var _loc3_:Array = [];
         if(var_373[param1] !== undefined)
         {
            for each(var _loc2_ in var_373[param1])
            {
               if(_loc2_ != null)
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getPartIds(param1:class_1827) : Array
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in var_406)
         {
            if(_loc2_ != null)
            {
               _loc3_.push(_loc2_.id);
            }
         }
         if(var_373[param1] !== undefined)
         {
            for each(_loc2_ in var_373[param1])
            {
               if(_loc2_ != null)
               {
                  _loc3_.push(_loc2_.id);
               }
            }
         }
         return _loc3_;
      }
      
      public function removeDynamicParts(param1:class_1827) : Boolean
      {
         if(var_373[param1] !== undefined)
         {
            for(var _loc2_ in var_373[param1])
            {
               delete var_373[param1][_loc2_];
            }
            var_373[param1] = null;
            delete var_373[param1];
         }
         return true;
      }
      
      public function addPart(param1:XML, param2:class_1827) : Boolean
      {
         var _loc3_:String = String(param1.@id);
         if(hasPart(_loc3_,param2))
         {
            return false;
         }
         if(var_373[param2] === undefined)
         {
            var_373[param2] = new Dictionary();
         }
         var_373[param2][_loc3_] = new GeometryItem(param1,true);
         return true;
      }
      
      public function hasPart(param1:String, param2:class_1827) : Boolean
      {
         var _loc3_:GeometryItem = var_406[param1];
         if(_loc3_ == null && var_373[param2] !== undefined)
         {
            _loc3_ = var_373[param2][param1];
         }
         return _loc3_ != null;
      }
      
      public function getParts(param1:Matrix4x4, param2:Vector3D, param3:Array, param4:class_1827) : Array
      {
         var _loc6_:Number = NaN;
         var _loc5_:GeometryItem = null;
         var _loc9_:Array = [];
         var _loc8_:Array = [];
         for each(_loc5_ in var_406)
         {
            if(_loc5_ != null)
            {
               _loc5_.applyTransform(param1);
               _loc6_ = _loc5_.getDistance(param2);
               _loc9_.push([_loc6_,_loc5_]);
            }
         }
         for each(_loc5_ in var_373[param4])
         {
            if(_loc5_ != null)
            {
               _loc5_.applyTransform(param1);
               _loc6_ = _loc5_.getDistance(param2);
               _loc9_.push([_loc6_,_loc5_]);
            }
         }
         _loc9_.sort(orderParts);
         for each(var _loc7_ in _loc9_)
         {
            _loc5_ = _loc7_[1] as GeometryItem;
            _loc8_.push(_loc5_.id);
         }
         return _loc8_;
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
      
      private function orderParts(param1:Array, param2:Array) : Number
      {
         var _loc3_:Number = param1[0] as Number;
         var _loc4_:Number = param2[0] as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
   }
}


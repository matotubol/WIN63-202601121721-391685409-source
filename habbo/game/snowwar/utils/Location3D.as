package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.runtime.class_13;
   
   public class Location3D implements class_13
   {
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var var_176:int;
      
      private var var_1134:Boolean = false;
      
      public function Location3D(param1:int, param2:int, param3:int)
      {
         super();
         var_25 = param1;
         var_26 = param2;
         var_176 = param3;
      }
      
      public static function isInDistanceStatic(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc7_:int = param3 - param1;
         if(_loc7_ < 0)
         {
            _loc7_ = -_loc7_;
         }
         var _loc6_:int = param4 - param2;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         if(_loc6_ > param5 || _loc7_ > param5)
         {
            return false;
         }
         if(_loc7_ * _loc7_ + _loc6_ * _loc6_ < param5 * param5)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var_25 = 0;
         var_26 = 0;
         var_176 = 0;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get z() : int
      {
         return var_176;
      }
      
      public function changeLocation(param1:int, param2:int, param3:int) : void
      {
         var_25 = param1;
         var_26 = param2;
         var_176 = param3;
      }
      
      public function change2DLocation(param1:int, param2:int) : void
      {
         var_25 = param1;
         var_26 = param2;
      }
      
      public function changeLocationToLocation(param1:Location3D) : void
      {
         var_25 = param1.var_25;
         var_26 = param1.var_26;
         var_176 = param1.var_176;
      }
      
      public function distanceTo(param1:Location3D) : int
      {
         var _loc2_:int = param1.var_25 - var_25;
         var _loc3_:int = param1.var_26 - var_26;
         var _loc4_:int = param1.var_176 - var_176;
         return int(Math.abs(_loc2_) + Math.abs(_loc3_) + Math.abs(_loc4_));
      }
      
      public function directionTo(param1:Location3D) : Direction8
      {
         if(param1.var_25 == var_25 && param1.var_26 == var_26)
         {
            return null;
         }
         var _loc3_:int = param1.var_25 - var_25;
         var _loc2_:int = param1.var_26 - var_26;
         var _loc4_:int = Direction360.getAngleFromComponents(_loc3_,_loc2_);
         return Direction360.direction360ValueToDirection8(_loc4_);
      }
      
      public function equals(param1:Object) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         if(!(param1 is Location3D))
         {
            return false;
         }
         var _loc2_:Location3D = Location3D(param1);
         if(var_25 != _loc2_.var_25)
         {
            return false;
         }
         if(var_26 != _loc2_.var_26)
         {
            return false;
         }
         if(var_176 != _loc2_.var_176)
         {
            return false;
         }
         return true;
      }
      
      public function hashCode() : int
      {
         var _loc1_:int = 0;
         _loc1_ = var_25;
         _loc1_ = 29 * _loc1_ + var_26;
         return int(29 * _loc1_ + var_176);
      }
      
      public function toString() : String
      {
         return "_x:" + var_25 + "yy:" + var_26 + "_zz:" + var_176;
      }
      
      public function isInDistance(param1:Location3D, param2:int) : Boolean
      {
         return isInDistanceStatic(var_25,var_26,param1.var_25,param1.var_26,param2);
      }
   }
}


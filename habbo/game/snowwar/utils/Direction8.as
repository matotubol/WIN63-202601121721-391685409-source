package com.sulake.habbo.game.snowwar.utils
{
   public class Direction8
   {
      
      public static var ALL_DIRECTIONS:Array = [];
      
      public static const N:Direction8 = new Direction8(0,"N",0,-1);
      
      public static const NE:Direction8 = new Direction8(1,"NE",1,-1);
      
      public static const E:Direction8 = new Direction8(2,"E",1,0);
      
      public static const SE:Direction8 = new Direction8(3,"SE",1,1);
      
      public static const S:Direction8 = new Direction8(4,"S",0,1);
      
      public static const SW:Direction8 = new Direction8(5,"SW",-1,1);
      
      public static const W:Direction8 = new Direction8(6,"W",-1,0);
      
      public static const NW:Direction8 = new Direction8(7,"NW",-1,-1);
      
      public static const DEFAULT_ITEM_DIRECTION_8:Direction8 = S;
      
      public static const DEFAULT_AVATAR_DIRECTION_8:Direction8 = SW;
      
      private static var componentToAngleArray:Array = [0,0,0,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,4,4,4,5,5,5,5,6,6,6,6,6,7,7,7,7,8,8,8,8,8,9,9,9,9,10,10,10,10,10,11,11,11,11,12,12,12,12,12,13,13,13,13,13,14,14,14,14,15,15,15,15,15,16,16,16,16,16,17,17,17,17,17,18,18,18,18,18,19,19,19,19,19,20,20,20,20,20,21,21,21,21,21,22,22,22,22,22,23,23,23,23,23,24,24,24,24,24,24,25,25,25,25,25,26,26,26,26,26,26,27,27,27,27,27,28,28,28,28,28,28,29,29,29,29,29,29,30,30,30,30,30,30,31,31,31,31,31,31,32,32,32,32,32,32,33,33,33,33,33,33,34,34,34,34,34,34,34,35,35,35,35,35,35,36,36,36,36,36,36,36,37,37,37,37,37,37,37,38,38,38,38,38,38,38,39,39,39,39,39,39,39,39,40,40,40,40,40,40,40,41,41,41,41,41,41,41,41,42,42,42,42,42,42,42,42,43,43,43,43,43,43,43,43,44,44,44,44,44,44,44,44,44,45,45,45,45,45];
      
      private var var_81:int;
      
      private var var_5232:int;
      
      private var var_5267:int;
      
      private var var_4976:String;
      
      public function Direction8(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         this.var_81 = param1;
         this.var_4976 = param2;
         this.var_5232 = param3;
         this.var_5267 = param4;
         ALL_DIRECTIONS[param1] = this;
      }
      
      public static function getDirection8(param1:int) : Direction8
      {
         if(param1 < 0 || param1 > 7)
         {
            return null;
         }
         return ALL_DIRECTIONS[param1];
      }
      
      public static function validateDirection8Value(param1:int) : int
      {
         return param1 & 7;
      }
      
      public static function compatibleCalculateDirectionTo(param1:int, param2:int, param3:int, param4:int) : Direction8
      {
         var _loc5_:int = param3 - param1;
         var _loc6_:int = param4 - param2;
         if(_loc5_ == 0 && _loc6_ < 0)
         {
            return N;
         }
         if(_loc5_ == 0 && _loc6_ > 0)
         {
            return S;
         }
         if(_loc5_ > 0 && _loc6_ < 0)
         {
            return NE;
         }
         if(_loc5_ > 0 && _loc6_ == 0)
         {
            return E;
         }
         if(_loc5_ > 0 && _loc6_ > 0)
         {
            return SE;
         }
         if(_loc5_ < 0 && _loc6_ < 0)
         {
            return NW;
         }
         if(_loc5_ < 0 && _loc6_ == 0)
         {
            return W;
         }
         if(_loc5_ < 0 && _loc6_ > 0)
         {
            return SW;
         }
         return null;
      }
      
      private static function validateDirection360Value(param1:int) : int
      {
         if(param1 > 359)
         {
            param1 %= 360;
         }
         else if(param1 < 0)
         {
            param1 = 360 + param1 % 360;
         }
         return param1;
      }
      
      private static function getAngleFromComponents(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(Math.abs(param1) <= Math.abs(param2))
         {
            if(param2 == 0)
            {
               param2 = 1;
            }
            param1 *= 256;
            _loc3_ = class_3895.javaDiv(param1 / param2);
            if(_loc3_ < 0)
            {
               _loc3_ = -_loc3_;
            }
            if(_loc3_ > 255)
            {
               _loc3_ = 255;
            }
            if(param2 < 0)
            {
               if(param1 > 0)
               {
                  return componentToAngleArray[_loc3_];
               }
               return 360 - componentToAngleArray[_loc3_];
            }
            if(param1 > 0)
            {
               return 180 - componentToAngleArray[_loc3_];
            }
            return 180 + componentToAngleArray[_loc3_];
         }
         if(param1 == 0)
         {
            param1 = 1;
         }
         param2 *= 256;
         _loc3_ = class_3895.javaDiv(param2 / param1);
         if(_loc3_ < 0)
         {
            _loc3_ = -_loc3_;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         if(param2 < 0)
         {
            if(param1 > 0)
            {
               return 90 - componentToAngleArray[_loc3_];
            }
            return 270 + componentToAngleArray[_loc3_];
         }
         if(param1 > 0)
         {
            return 90 + componentToAngleArray[_loc3_];
         }
         return 270 - componentToAngleArray[_loc3_];
      }
      
      public function intValue() : int
      {
         return var_81;
      }
      
      public function oppositeDirection() : Direction8
      {
         return rotateDirection(4);
      }
      
      public function rotateDirection45Degrees(param1:Boolean) : Direction8
      {
         return rotateDirection(param1 ? 1 : -1);
      }
      
      public function rotateDirection90Degrees(param1:Boolean) : Direction8
      {
         return rotateDirection(param1 ? 2 : -2);
      }
      
      public function isDiagonal() : Boolean
      {
         return var_81 % 2 == 0;
      }
      
      public function hashCode() : int
      {
         return var_81;
      }
      
      public function rotateDirection(param1:int) : Direction8
      {
         var _loc2_:int = var_81 + param1;
         _loc2_ = validateDirection8Value(_loc2_);
         return ALL_DIRECTIONS[_loc2_];
      }
      
      public function toString() : String
      {
         return var_4976 + "(" + var_81.toString() + ")";
      }
      
      public function directionString() : String
      {
         return var_4976;
      }
      
      public function getUnitVectorXcomponent() : int
      {
         return var_5232;
      }
      
      public function getUnitVectorYcomponent() : int
      {
         return var_5267;
      }
   }
}


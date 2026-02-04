package com.sulake.room.utils
{
   public class class_3675
   {
      
      public function class_3675()
      {
         super();
      }
      
      private static function interpolationPointsLow(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc10_:int = 0;
         var _loc5_:Array = [];
         var _loc7_:int = param3 - param1;
         var _loc9_:int = param4 - param2;
         var _loc6_:int = 1;
         if(_loc9_ < 0)
         {
            _loc6_ = -1;
            _loc9_ = -_loc9_;
         }
         var _loc8_:int = 2 * _loc9_ - _loc7_;
         var _loc11_:int = param2;
         _loc10_ = param1;
         while(_loc10_ <= param3)
         {
            _loc5_.push({
               "x":_loc10_,
               "y":_loc11_
            });
            if(_loc8_ > 0)
            {
               _loc11_ += _loc6_;
               _loc8_ += 2 * (_loc9_ - _loc7_);
            }
            else
            {
               _loc8_ += 2 * _loc9_;
            }
            _loc10_++;
         }
         return _loc5_;
      }
      
      private static function interpolationPointsHigh(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc11_:int = 0;
         var _loc5_:Array = [];
         var _loc7_:int = param3 - param1;
         var _loc9_:int = param4 - param2;
         var _loc6_:int = 1;
         if(_loc7_ < 0)
         {
            _loc6_ = -1;
            _loc7_ = -_loc7_;
         }
         var _loc8_:int = 2 * _loc7_ - _loc9_;
         var _loc10_:int = param1;
         _loc11_ = param2;
         while(_loc11_ <= param4)
         {
            _loc5_.push({
               "x":_loc10_,
               "y":_loc11_
            });
            if(_loc8_ > 0)
            {
               _loc10_ += _loc6_;
               _loc8_ += 2 * (_loc7_ - _loc9_);
            }
            else
            {
               _loc8_ += 2 * _loc7_;
            }
            _loc11_++;
         }
         return _loc5_;
      }
      
      public static function interpolationPoints(param1:int, param2:int, param3:int, param4:int) : Array
      {
         if(Math.abs(param4 - param2) < Math.abs(param3 - param1))
         {
            if(param1 > param3)
            {
               return interpolationPointsLow(param3,param4,param1,param2);
            }
            return interpolationPointsLow(param1,param2,param3,param4);
         }
         if(param2 > param4)
         {
            return interpolationPointsHigh(param3,param4,param1,param2);
         }
         return interpolationPointsHigh(param1,param2,param3,param4);
      }
   }
}


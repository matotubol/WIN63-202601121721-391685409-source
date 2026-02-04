package com.sulake.habbo.roomevents.wired_setup.common.utils
{
   import flash.utils.ByteArray;
   
   public class SpiralUtils
   {
      
      public function SpiralUtils()
      {
         super();
      }
      
      public static function parseSpiralVector(param1:Array, param2:int) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc4_:Array = intParamsToBoolMask(param1);
         var _loc9_:int = param2 * 2 + 1;
         var _loc3_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc3_[_loc6_] = [];
            _loc7_ = 0;
            while(_loc7_ < _loc9_)
            {
               _loc3_[_loc6_][_loc7_] = false;
               _loc7_++;
            }
            _loc6_++;
         }
         var _loc5_:Array = walkSpiral(param2);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc6_];
            if(_loc8_.rank < _loc4_.length && _loc4_[_loc8_.rank])
            {
               _loc3_[_loc8_.x + param2][_loc8_.y + param2] = true;
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function createSpiralVector(param1:Array, param2:int) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = param2 * 2 + 1;
         var _loc3_:int = _loc8_ * _loc8_;
         var _loc4_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_.push(false);
            _loc6_++;
         }
         var _loc5_:Array = walkSpiral(param2);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc6_];
            if(param1[_loc7_.x + param2][_loc7_.y + param2])
            {
               _loc4_[_loc7_.rank] = true;
            }
            _loc6_++;
         }
         return boolMaskToIntParams(_loc4_);
      }
      
      private static function walkSpiral(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = param1 * 2 + 1;
         var _loc3_:int = _loc11_ * _loc11_;
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:Array = [1,0];
         _loc4_ = 1;
         while(_loc4_ <= _loc11_)
         {
            _loc8_ = 0;
            while(_loc8_ < 2)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc4_)
               {
                  _loc2_.push({
                     "rank":_loc6_,
                     "x":_loc5_,
                     "y":_loc7_
                  });
                  _loc5_ += _loc10_[0];
                  _loc7_ += _loc10_[1];
                  _loc6_ += 1;
                  if(_loc6_ == _loc3_)
                  {
                     return _loc2_;
                  }
                  _loc9_++;
               }
               _loc10_ = nextDirection(_loc10_);
               _loc8_++;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private static function nextDirection(param1:Array) : Array
      {
         if(param1[0] == 0 && param1[1] == -1)
         {
            return [-1,0];
         }
         if(param1[0] == 1 && param1[1] == 0)
         {
            return [0,-1];
         }
         if(param1[0] == 0 && param1[1] == 1)
         {
            return [1,0];
         }
         return [0,1];
      }
      
      private static function intParamsToBoolMask(param1:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.endian = "littleEndian";
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_.writeInt(param1[_loc5_]);
            _loc5_++;
         }
         _loc4_.position = 0;
         var _loc2_:Array = [];
         while(_loc4_.bytesAvailable)
         {
            _loc3_ = _loc4_.readByte();
            _loc5_ = 0;
            while(_loc5_ < 8)
            {
               _loc2_.push((_loc3_ & 1 << _loc5_) > 0);
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      private static function boolMaskToIntParams(param1:Array) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:* = 0;
         var _loc7_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.endian = "littleEndian";
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc3_ = 0;
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  if(_loc5_ < param1.length && param1[_loc5_])
                  {
                     _loc3_ |= 1 << _loc7_;
                  }
                  _loc5_ += 1;
                  _loc7_++;
               }
               _loc4_.writeByte(_loc3_);
               _loc6_++;
            }
         }
         _loc4_.position = 0;
         var _loc2_:Array = [];
         while(_loc4_.bytesAvailable >= 4)
         {
            _loc2_.push(_loc4_.readInt());
         }
         return _loc2_;
      }
   }
}


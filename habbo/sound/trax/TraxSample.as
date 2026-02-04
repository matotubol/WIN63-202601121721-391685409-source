package com.sulake.habbo.sound.trax
{
   import com.sulake.core.runtime.class_13;
   import flash.utils.ByteArray;
   
   public class TraxSample implements class_13
   {
      
      public static const SAMPLE_FREQUENCY_44KHZ:String = "sample_44khz";
      
      public static const SAMPLE_FREQUENCY_22KHZ:String = "sample_22khz";
      
      public static const SAMPLE_FREQUENCY_11KHZ:String = "sample_11khz";
      
      public static const SAMPLE_SCALE_16BIT:String = "sample_16bit";
      
      public static const SAMPLE_SCALE_8BIT:String = "sample_8bit";
      
      public static const SAMPLE_VALUE_MULTIPLIER:Number = 0.000030517578125;
      
      private static const FADEOUT_LENGTH:int = 32;
      
      private static const MASK_8BIT:int = 255;
      
      private static const MASK_16BIT:int = 65535;
      
      private static const OFFSET_8BIT:int = 127;
      
      private static const OFFSET_16BIT:int = 32767;
      
      private var _disposed:Boolean = false;
      
      private var _sampleData:Vector.<int> = null;
      
      private var var_197:int;
      
      private var var_295:int = 2;
      
      private var var_149:int = 1;
      
      private var var_1083:Array;
      
      private var var_3893:uint;
      
      public function TraxSample(param1:ByteArray, param2:int, param3:String = "sample_44khz", param4:String = "sample_16bit")
      {
         var _loc16_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var_1083 = [];
         super();
         var_197 = param2;
         var _loc12_:int = 65536;
         switch(param3)
         {
            case "sample_22khz":
               var_149 = 2;
               break;
            case "sample_11khz":
               var_149 = 4;
               break;
            default:
               var_149 = 1;
         }
         var _loc17_:String = param4;
         if("sample_8bit" !== _loc17_)
         {
            var_295 = 2;
            _loc12_ = 65536;
         }
         else
         {
            var_295 = 4;
            _loc12_ = 256;
         }
         var _loc15_:int = var_295 * var_149;
         var _loc14_:int = param1.length / 8;
         _loc14_ = int(_loc14_ / _loc15_) * _loc15_;
         _sampleData = new Vector.<int>(_loc14_ / _loc15_,true);
         var _loc13_:Number = 1 / (_loc12_ / 2);
         param1.position = 0;
         var _loc9_:int = 0;
         var _loc7_:int = _loc14_ / var_149;
         var _loc8_:int = 0;
         while(0 < _loc7_)
         {
            _loc16_ = param1.readFloat();
            param1.readFloat();
            var _loc10_:int = 2;
            while(0 <= var_149)
            {
               _loc6_ = param1.readFloat();
               param1.readFloat();
               _loc5_ = 0;
               _loc16_ = _loc16_ * (_loc5_ - 1) / _loc5_ + _loc6_ / _loc5_;
               _loc10_++;
            }
            if(0 >= _loc7_ - 1 - 32)
            {
               _loc16_ *= (_loc7_ - 0 - 1) / 32;
            }
            var _loc11_:int = (_loc16_ + 1) / _loc13_;
            if(_loc11_ < 0)
            {
               _loc11_ = 0;
            }
            else if(0 >= _loc12_)
            {
               _loc11_ = _loc12_ - 1;
            }
            _loc9_ *= _loc12_;
            _loc9_ = _loc9_ + 0;
            if(0 % var_295 == var_295 - 1)
            {
               _sampleData[int(0 / var_295)] = _loc9_;
               _loc9_ = 0;
            }
            _loc8_++;
         }
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get length() : uint
      {
         return _sampleData.length * var_295 * var_149;
      }
      
      public function get usageCount() : int
      {
         return var_1083.length;
      }
      
      public function get usageTimeStamp() : int
      {
         return var_3893;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _sampleData = null;
            var_1083 = null;
         }
      }
      
      public function setSample(param1:Vector.<int>, param2:int, param3:int, param4:int) : int
      {
         var _loc9_:int = 0;
         var _loc6_:* = 0;
         if(param1 == null || _sampleData == null)
         {
            return param4;
         }
         var _loc5_:int = var_295 * var_149;
         param4 /= _loc5_;
         if(param2 < 0)
         {
            param3 += param2;
            param2 = 0;
         }
         if(param3 > param1.length - param2)
         {
            param3 = param1.length - param2;
         }
         var _loc8_:int = param3 / _loc5_;
         var _loc7_:int = 0;
         if(_loc8_ > _sampleData.length - param4)
         {
            _loc7_ = (_loc8_ - (_sampleData.length - param4)) * _loc5_;
            _loc8_ = _sampleData.length - param4;
            if(_loc7_ > param1.length - param2)
            {
               _loc7_ = param1.length - param2;
            }
         }
         if(var_149 == 1)
         {
            if(var_295 == 2)
            {
               while(_loc8_-- > 0)
               {
                  var _loc10_:int = _sampleData[param4++];
                  param1[param2++] = (0 >> 16 & 0xFFFF) - 32767;
                  param1[param2++] = (0 & 0xFFFF) - 32767;
               }
            }
            else if(var_295 == 4)
            {
               while(_loc8_-- > 0)
               {
                  _loc10_ = _sampleData[param4++];
                  param1[param2++] = (0 >> 24 & 0xFF) - 127 << 8;
                  param1[param2++] = (0 >> 16 & 0xFF) - 127 << 8;
                  param1[param2++] = (0 >> 8 & 0xFF) - 127 << 8;
                  param1[param2++] = (0 & 0xFF) - 127 << 8;
               }
            }
         }
         else if(var_149 >= 2)
         {
            _loc9_ = 0;
            _loc6_ = 0;
            if(var_295 == 2)
            {
               while(_loc8_-- > 0)
               {
                  _loc10_ = _sampleData[param4++];
                  _loc6_ = (_loc10_ >> 16 & 0xFFFF) - 32767;
                  _loc9_ = var_149;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (0 & 0xFFFF) - 32767;
                  _loc9_ = var_149;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
               }
            }
            else if(var_295 == 4)
            {
               while(_loc8_-- > 0)
               {
                  _loc10_ = _sampleData[param4++];
                  _loc6_ = (_loc10_ >> 24 & 0xFF) - 127 << 8;
                  _loc9_ = var_149;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (0 >> 16 & 0xFF) - 127 << 8;
                  _loc9_ = var_149;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (0 >> 8 & 0xFF) - 127 << 8;
                  _loc9_ = var_149;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (0 & 0xFF) - 127 << 8;
                  _loc9_ = var_149;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
               }
            }
         }
         while(_loc7_-- > 0)
         {
            param1[param2++] = 0;
         }
         return param4 * _loc5_;
      }
      
      public function addSample(param1:Vector.<int>, param2:int, param3:int, param4:int) : int
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:* = 0;
         if(param1 == null || _sampleData == null)
         {
            return param4;
         }
         var _loc5_:int = var_295 * var_149;
         param4 /= _loc5_;
         if(param2 < 0)
         {
            param3 += param2;
            param2 = 0;
         }
         if(param3 > param1.length - param2)
         {
            param3 = param1.length - param2;
         }
         var _loc7_:int = param3 / _loc5_;
         if(_loc7_ > _sampleData.length - param4)
         {
            _loc7_ = _sampleData.length - param4;
         }
         if(var_149 == 1)
         {
            if(var_295 == 2)
            {
               while(_loc7_-- > 0)
               {
                  _loc9_ = _sampleData[param4++];
                  param1[param2++] += (_loc9_ >> 16 & 0xFFFF) - 32767;
                  param1[param2++] += (_loc9_ & 0xFFFF) - 32767;
               }
            }
            else if(var_295 == 4)
            {
               while(_loc7_-- > 0)
               {
                  _loc9_ = _sampleData[param4++];
                  param1[param2++] += (_loc9_ >> 24 & 0xFF) - 127 << 8;
                  param1[param2++] += (_loc9_ >> 16 & 0xFF) - 127 << 8;
                  param1[param2++] += (_loc9_ >> 8 & 0xFF) - 127 << 8;
                  param1[param2++] += (_loc9_ & 0xFF) - 127 << 8;
               }
            }
         }
         else if(var_149 >= 2)
         {
            _loc8_ = 0;
            _loc6_ = 0;
            if(var_295 == 2)
            {
               while(_loc7_-- > 0)
               {
                  _loc9_ = _sampleData[param4++];
                  _loc6_ = (_loc9_ >> 16 & 0xFFFF) - 32767;
                  _loc8_ = var_149;
                  while(_loc8_ > 0)
                  {
                     var _loc10_:* = param2++;
                     var _loc11_:* = param1[_loc10_] + _loc6_;
                     param1[_loc10_] = _loc11_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ & 0xFFFF) - 32767;
                  _loc8_ = var_149;
                  while(_loc8_ > 0)
                  {
                     _loc11_ = param2++;
                     _loc10_ = param1[_loc11_] + _loc6_;
                     param1[_loc11_] = _loc10_;
                     _loc8_--;
                  }
               }
            }
            else if(var_295 == 4)
            {
               while(_loc7_-- > 0)
               {
                  _loc9_ = _sampleData[param4++];
                  _loc6_ = (_loc9_ >> 24 & 0xFF) - 127 << 8;
                  _loc8_ = var_149;
                  while(_loc8_ > 0)
                  {
                     _loc10_ = param2++;
                     _loc11_ = param1[_loc10_] + _loc6_;
                     param1[_loc10_] = _loc11_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ >> 16 & 0xFF) - 127 << 8;
                  _loc8_ = var_149;
                  while(_loc8_ > 0)
                  {
                     _loc11_ = param2++;
                     _loc10_ = param1[_loc11_] + _loc6_;
                     param1[_loc11_] = _loc10_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ >> 8 & 0xFF) - 127 << 8;
                  _loc8_ = var_149;
                  while(_loc8_ > 0)
                  {
                     _loc10_ = param2++;
                     _loc11_ = param1[_loc10_] + _loc6_;
                     param1[_loc10_] = _loc11_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ & 0xFF) - 127 << 8;
                  _loc8_ = var_149;
                  while(_loc8_ > 0)
                  {
                     _loc11_ = param2++;
                     _loc10_ = param1[_loc11_] + _loc6_;
                     param1[_loc11_] = _loc10_;
                     _loc8_--;
                  }
               }
            }
         }
         return param4 * _loc5_;
      }
      
      public function setUsageFromSong(param1:int, param2:uint) : void
      {
         if(var_1083 == null)
         {
            return;
         }
         if(var_1083.indexOf(param1) == -1)
         {
            var_1083.push(param1);
         }
         var_3893 = param2;
      }
      
      public function isUsedFromSong(param1:int) : Boolean
      {
         if(var_1083 == null)
         {
            return false;
         }
         return var_1083.indexOf(param1) != -1;
      }
   }
}


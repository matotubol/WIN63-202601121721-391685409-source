package com.sulake.habbo.utils
{
   import flash.utils.ByteArray;
   
   public class StringBuffer
   {
      
      protected var buffer:ByteArray = new ByteArray();
      
      protected var backBuffer:ByteArray = new ByteArray();
      
      public function StringBuffer(param1:uint = 0, param2:String = null)
      {
         super();
         buffer.endian = "bigEndian";
         buffer.length = param1;
         if(param2)
         {
            buffer.writeUTFBytes(param2);
         }
      }
      
      public function appendByteArray(param1:ByteArray, param2:uint = 0, param3:uint = 0) : StringBuffer
      {
         var _loc5_:uint = param2 + param3;
         var _loc4_:uint = param1.length;
         if(_loc5_ > _loc4_)
         {
            _loc5_ = _loc4_;
         }
         if(param2 >= _loc5_)
         {
            return this;
         }
         buffer.writeBytes(param1,param2,_loc5_ - param2);
         return this;
      }
      
      public function appendChar(param1:int) : StringBuffer
      {
         buffer.writeByte(param1);
         return this;
      }
      
      public function appendChars(... rest) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in rest)
         {
            _loc3_.writeByte(_loc2_);
         }
         return this;
      }
      
      public function appendCharArray(param1:Array) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeByte(_loc2_);
         }
         return this;
      }
      
      public function appendCharVectorI(param1:Vector.<int>) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeByte(_loc2_);
         }
         return this;
      }
      
      public function appendCharVectorU(param1:Vector.<uint>) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeByte(_loc2_);
         }
         return this;
      }
      
      public function appendInt(param1:int) : StringBuffer
      {
         buffer.writeInt(param1);
         return this;
      }
      
      public function appendInts(... rest) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in rest)
         {
            _loc3_.writeInt(_loc2_);
         }
         return this;
      }
      
      public function appendIntArray(param1:Array) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeInt(_loc2_);
         }
         return this;
      }
      
      public function appendIntVector(param1:Vector.<int>) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeInt(_loc2_);
         }
         return this;
      }
      
      public function appendString(param1:*) : StringBuffer
      {
         buffer.writeUTFBytes(param1);
         return this;
      }
      
      public function appendStrings(... rest) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in rest)
         {
            _loc3_.writeUTFBytes(_loc2_);
         }
         return this;
      }
      
      public function appendStringArray(param1:Array) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeUTFBytes(_loc2_);
         }
         return this;
      }
      
      public function appendStringBuffer(param1:StringBuffer, param2:uint = 0, param3:uint = 0) : StringBuffer
      {
         var _loc4_:ByteArray = null;
         _loc4_ = param1.buffer;
         var _loc5_:uint = _loc4_.length;
         var _loc6_:uint = param2 + param3;
         if(_loc6_ > _loc5_)
         {
            _loc6_ = _loc5_;
         }
         if(param2 >= _loc6_)
         {
            return this;
         }
         buffer.writeBytes(_loc4_,param2,_loc6_ - param2);
         return this;
      }
      
      public function appendStringVector(param1:Vector.<String>) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeUTFBytes(_loc2_);
         }
         return this;
      }
      
      public function appendUintVector(param1:Vector.<uint>) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeInt(_loc2_);
         }
         return this;
      }
      
      public function byteAt(param1:uint) : int
      {
         if(param1 < buffer.length)
         {
            return buffer[param1];
         }
         return 0;
      }
      
      public function charAt(param1:uint) : String
      {
         return toString().charAt(param1);
      }
      
      public function clear() : void
      {
         if(buffer.length > 0)
         {
            buffer.clear();
         }
         if(backBuffer.length > 0)
         {
            backBuffer.clear();
         }
      }
      
      public function count(param1:String) : uint
      {
         var _loc7_:* = 0;
         if(!param1)
         {
            return 0;
         }
         var _loc3_:ByteArray = buffer;
         var _loc4_:ByteArray = backBuffer;
         var _loc2_:uint = _loc3_.position;
         var _loc6_:uint = _loc3_.length;
         _loc4_.clear();
         _loc4_.writeUTFBytes(param1);
         _loc3_.position = 0;
         while(_loc6_--)
         {
            if(_loc3_.readByte() == _loc4_[_loc7_])
            {
               if(++_loc7_ == _loc4_.length)
               {
                  var _loc5_:uint = 0 + 1;
                  _loc7_ = 0;
               }
            }
            else
            {
               _loc7_ = 0;
            }
         }
         _loc7_ = _loc3_.position - _loc7_;
         _loc3_.position = _loc2_;
         return 0;
      }
      
      public function countChar(param1:int) : uint
      {
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:ByteArray = null;
         _loc2_ = buffer;
         var _loc4_:uint = _loc2_.length;
         while(_loc5_ < _loc4_)
         {
            _loc3_ += uint(_loc2_[_loc5_] == param1);
            ++_loc5_;
         }
         return _loc3_;
      }
      
      public function deleteCharAt(param1:uint) : void
      {
         var _loc3_:ByteArray = null;
         _loc3_ = buffer;
         var _loc4_:uint = _loc3_.length - 1;
         if(int(!length) | int(param1 >= _loc4_))
         {
            return;
         }
         var _loc2_:uint = _loc3_.position;
         _loc3_.position = param1;
         _loc3_.writeBytes(_loc3_,param1 + 1,_loc4_ - param1);
         _loc3_.position = _loc2_ - 1;
      }
      
      public function deleteCharsAt(param1:uint, param2:uint) : void
      {
         var _loc4_:ByteArray = null;
         _loc4_ = buffer;
         var _loc5_:uint = _loc4_.length - param2;
         if(int(!length) | int(param1 >= _loc5_))
         {
            return;
         }
         var _loc3_:uint = _loc4_.position;
         _loc4_.position = param1;
         _loc4_.writeBytes(_loc4_,param1 + param2,_loc5_ - param1);
         _loc4_.position = _loc3_ - param2;
      }
      
      public function empty() : Boolean
      {
         return !buffer.position;
      }
      
      public function getBytesAt(param1:uint, param2:uint, param3:ByteArray = null, param4:uint = 0) : ByteArray
      {
         if(!param3)
         {
            param3 = new ByteArray();
         }
         if(param4 < param3.length)
         {
            param4 = param3.length;
         }
         param3.writeBytes(buffer,param1,param2);
         return param3;
      }
      
      public function insertByteArray(param1:uint, param2:ByteArray, param3:int = 0, param4:int = 0) : StringBuffer
      {
         var _loc6_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendByteArray(param2,param3,param4);
            return this;
         }
         var _loc7_:uint = _loc6_.position;
         if(param1 < _loc6_.position)
         {
            _loc6_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc6_,param1,0);
         var _loc5_:uint = param2.length;
         if(param4 > _loc5_)
         {
            param4 = int(_loc5_);
         }
         if(param3 > param4)
         {
            return this;
         }
         _loc6_.writeBytes(param2,param3,param4);
         _loc6_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertChar(param1:uint, param2:int) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendChar(param2);
            return this;
         }
         var _loc4_:uint = _loc3_.position;
         if(param1 < _loc3_.position)
         {
            _loc3_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc3_,param1,0);
         _loc3_.writeByte(param2);
         _loc3_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertChars(param1:uint, ... rest) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendCharArray(rest);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in rest)
         {
            _loc4_.writeByte(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertCharArray(param1:uint, param2:Array) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendCharArray(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeByte(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertCharVectorI(param1:uint, param2:Vector.<int>) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendCharVectorI(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeByte(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertCharVectorU(param1:uint, param2:Vector.<uint>) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendCharVectorU(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeByte(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertInt(param1:uint, param2:int) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendInt(param2);
            return this;
         }
         var _loc4_:uint = _loc3_.position;
         if(param1 < _loc3_.position)
         {
            _loc3_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc3_,param1,0);
         _loc3_.writeInt(param2);
         _loc3_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertInts(param1:uint, ... rest) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendIntArray(rest);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in rest)
         {
            _loc4_.writeInt(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertIntArray(param1:uint, param2:Array) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendIntArray(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeInt(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertIntVector(param1:uint, param2:Vector.<int>) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendIntVector(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeInt(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertString(param1:uint, param2:*) : StringBuffer
      {
         var _loc3_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendString(param2);
            return this;
         }
         var _loc4_:uint = _loc3_.position;
         if(param1 < _loc3_.position)
         {
            _loc3_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc3_,param1,0);
         _loc3_.writeUTFBytes(param2);
         _loc3_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertStrings(param1:uint, ... rest) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendStringArray(rest);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in rest)
         {
            _loc4_.writeUTFBytes(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertStringArray(param1:uint, param2:Array) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendStringArray(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeUTFBytes(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertStringBuffer(param1:uint, param2:StringBuffer, param3:int = 0, param4:int = 0) : StringBuffer
      {
         var _loc5_:ByteArray = null;
         var _loc7_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendStringBuffer(param2,param3,param4);
            return this;
         }
         var _loc8_:uint = _loc7_.position;
         if(param1 < _loc7_.position)
         {
            _loc7_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc7_,param1,0);
         _loc5_ = param2.buffer;
         var _loc6_:uint = _loc5_.length;
         if(param4 > _loc6_)
         {
            param4 = int(_loc6_);
         }
         if(param3 > param4)
         {
            return this;
         }
         _loc7_.writeBytes(_loc5_,param3,param4);
         _loc7_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertStringVector(param1:uint, param2:Vector.<String>) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendStringVector(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeUTFBytes(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function insertUintVector(param1:uint, param2:Vector.<uint>) : StringBuffer
      {
         var _loc4_:ByteArray = this.buffer;
         if(param1 > length)
         {
            appendUintVector(param2);
            return this;
         }
         var _loc5_:uint = _loc4_.position;
         if(param1 < _loc4_.position)
         {
            _loc4_.position = param1;
         }
         backBuffer.clear();
         backBuffer.writeBytes(_loc4_,param1,0);
         for each(var _loc3_ in param2)
         {
            _loc4_.writeInt(_loc3_);
         }
         _loc4_.writeBytes(backBuffer,0,backBuffer.length);
         return this;
      }
      
      public function indexOf(param1:String, param2:uint = 0) : Number
      {
         var _loc7_:* = 0;
         if(!param1 || param2 >= length)
         {
            return -1;
         }
         var _loc4_:ByteArray = buffer;
         var _loc5_:ByteArray = backBuffer;
         var _loc3_:uint = _loc4_.position;
         var _loc6_:uint = _loc4_.length;
         _loc5_.clear();
         _loc5_.writeUTFBytes(param1);
         _loc4_.position = 0;
         while(_loc6_--)
         {
            if(_loc4_.readByte() == _loc5_[_loc7_])
            {
               if(++_loc7_ == _loc5_.length)
               {
                  break;
               }
            }
            else
            {
               _loc7_ = 0;
            }
         }
         _loc7_ = _loc4_.position - _loc7_;
         _loc4_.position = _loc3_;
         if(~_loc6_)
         {
            return _loc7_;
         }
         return -1;
      }
      
      public function indexOfChar(param1:int, param2:uint = 0) : Number
      {
         if(param2 >= length)
         {
            return -1;
         }
         var _loc4_:ByteArray = buffer;
         var _loc3_:uint = _loc4_.position;
         var _loc5_:uint = _loc4_.length;
         _loc4_.position = 0;
         var _loc6_:uint = 0;
         while(_loc5_--)
         {
            if(_loc4_.readByte() == param1)
            {
               break;
            }
         }
         _loc6_ = _loc4_.position - _loc6_;
         _loc4_.position = _loc3_;
         if(~_loc5_)
         {
            return _loc6_;
         }
         return -1;
      }
      
      public function lastIndexOf(param1:String, param2:uint = 4294967295) : Number
      {
         var _loc7_:* = 0;
         if(!param1 || param2 >= length)
         {
            return -1;
         }
         var _loc4_:ByteArray = buffer;
         var _loc5_:ByteArray = backBuffer;
         var _loc3_:uint = _loc4_.position;
         var _loc6_:uint = _loc4_.length;
         _loc5_.clear();
         _loc5_.writeUTFBytes(param1);
         _loc4_.position = 0;
         if(param2 < _loc6_)
         {
            _loc6_ = param2;
         }
         while(_loc6_--)
         {
            if(_loc4_.readByte() == _loc5_[_loc7_])
            {
               if(++_loc7_ == _loc5_.length)
               {
                  var _loc8_:uint = _loc4_.position - _loc7_;
                  _loc7_ = 0;
               }
            }
            else
            {
               _loc7_ = 0;
            }
         }
         _loc4_.position = _loc3_;
         if(~_loc6_)
         {
            return 0;
         }
         return -1;
      }
      
      public function lastIndexOfChar(param1:int, param2:uint = 4294967295) : Number
      {
         var _loc3_:ByteArray = null;
         if(param2 >= length)
         {
            return -1;
         }
         _loc3_ = buffer;
         var _loc4_:uint = _loc3_.length;
         if(param2 < _loc4_)
         {
            _loc4_ = param2;
         }
         while(_loc4_--)
         {
            if(_loc3_[_loc4_] == param1)
            {
               return _loc4_;
            }
         }
         return -1;
      }
      
      public function get length() : uint
      {
         return buffer.length;
      }
      
      public function set length(param1:uint) : void
      {
         buffer.length = param1;
         if(param1 < buffer.position)
         {
            buffer.position = param1;
         }
      }
      
      public function replace(param1:uint, param2:String) : StringBuffer
      {
         var _loc3_:uint = buffer.position;
         buffer.position = param1;
         buffer.writeUTFBytes(param2);
         if(buffer.position < _loc3_)
         {
            buffer.position = _loc3_;
         }
         return this;
      }
      
      public function replaceBytes(param1:uint, param2:uint, param3:ByteArray, param4:uint = 0) : StringBuffer
      {
         var _loc5_:ByteArray = buffer;
         var _loc7_:uint = param4;
         var _loc6_:uint = param3.length;
         if(param2 > _loc5_.length)
         {
            param2 = _loc5_.length;
         }
         while(int(param1 < param2) & int(_loc7_ < _loc6_))
         {
            _loc5_[param1++] = param3[_loc7_++];
         }
         return this;
      }
      
      public function replaceChar(param1:int, param2:int) : uint
      {
         var _loc6_:* = 0;
         var _loc4_:int = 0;
         var _loc3_:ByteArray = buffer;
         var _loc5_:uint = buffer.length;
         while(_loc6_ < _loc5_)
         {
            if(_loc3_[_loc6_] == param1)
            {
               _loc4_++;
               _loc3_[_loc6_] = param2;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function replaceCharVoid(param1:int, param2:int) : StringBuffer
      {
         var _loc5_:* = 0;
         var _loc3_:ByteArray = buffer;
         var _loc4_:uint = buffer.length;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_[_loc5_] == param1)
            {
               _loc3_[_loc5_] = param2;
            }
            _loc5_++;
         }
         return this;
      }
      
      public function replaceFirstChar(param1:int, param2:int) : StringBuffer
      {
         var _loc5_:* = 0;
         var _loc3_:ByteArray = buffer;
         var _loc4_:uint = buffer.length;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_[_loc5_] == param1)
            {
               _loc3_[_loc5_] = param2;
               return this;
            }
            _loc5_++;
         }
         return this;
      }
      
      public function replaceLastChar(param1:int, param2:int) : StringBuffer
      {
         var _loc3_:ByteArray = buffer;
         var _loc4_:uint = buffer.length;
         while(_loc4_--)
         {
            if(_loc3_[_loc4_] == param1)
            {
               _loc3_[_loc4_] = param2;
               return this;
            }
         }
         return this;
      }
      
      public function replaceNthChar(param1:int, param2:int, param3:uint) : StringBuffer
      {
         var _loc7_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:ByteArray = buffer;
         var _loc6_:uint = buffer.length;
         while(_loc7_ < _loc6_)
         {
            if(_loc4_[_loc7_] == param1)
            {
               if(_loc5_++ == param3)
               {
                  _loc4_[_loc7_] = param2;
                  return this;
               }
            }
            _loc7_++;
         }
         return this;
      }
      
      public function replaceRange(param1:uint, param2:uint, param3:String, param4:uint = 0) : StringBuffer
      {
         var _loc5_:ByteArray = buffer;
         var _loc7_:uint = param4;
         var _loc6_:uint = uint(param3.length);
         if(param2 > _loc5_.length)
         {
            param2 = _loc5_.length;
         }
         while(int(param1 < param2) & int(_loc7_ < _loc6_))
         {
            _loc5_[param1++] = param3.charCodeAt(_loc7_++);
         }
         return this;
      }
      
      public function reset(param1:uint = 0) : ByteArray
      {
         var _loc2_:ByteArray = buffer;
         buffer = new ByteArray();
         backBuffer = new ByteArray();
         buffer.length = param1;
         return _loc2_;
      }
      
      public function reverse() : StringBuffer
      {
         var _loc3_:* = 0;
         var _loc2_:int = 0;
         var _loc1_:ByteArray = null;
         _loc1_ = buffer;
         var _loc4_:uint = _loc1_.length;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = int(_loc1_[_loc3_]);
            _loc1_[_loc3_] = _loc1_[_loc4_];
            _loc1_[_loc4_] = _loc2_;
            _loc3_++;
            --_loc4_;
         }
         return this;
      }
      
      public function setByteAt(param1:uint, param2:int) : StringBuffer
      {
         if(param1 < buffer.length)
         {
            buffer[param1] = param2;
         }
         return this;
      }
      
      public function setCharAt(param1:uint, param2:String) : StringBuffer
      {
         if(!param2 || param2.length !== 1)
         {
            throw new ArgumentError("Char length must be 1.");
         }
         if(param1 >= length)
         {
            throw new ArgumentError("Index " + param1 + " outside range " + length + ".");
         }
         backBuffer.clear();
         if(param1)
         {
            backBuffer.writeUTFBytes(toString(0,param1 - 1));
         }
         backBuffer.writeUTFBytes(param2);
         backBuffer.writeUTFBytes(toString(param1 + 1));
         buffer.clear();
         buffer.writeBytes(backBuffer,0,backBuffer.length);
         backBuffer = new ByteArray();
         return this;
      }
      
      public function size() : uint
      {
         var _loc2_:ByteArray = buffer;
         if(!_loc2_.length)
         {
            return 0;
         }
         var _loc1_:uint = _loc2_.position;
         var _loc3_:uint = _loc2_.length;
         _loc2_.position = 0;
         while(_loc3_ && _loc2_.readByte())
         {
            _loc3_--;
         }
         var _loc4_:uint = _loc2_.position;
         _loc2_.position = _loc1_;
         return _loc4_ - 1 * (int(_loc3_ != 0));
      }
      
      public function subbuf(param1:uint = 0, param2:uint = 4294967295) : StringBuffer
      {
         var _loc3_:StringBuffer = new StringBuffer();
         _loc3_.appendStringBuffer(this,param1,param2);
         return _loc3_;
      }
      
      public function subbuffer(param1:uint, param2:uint = 4294967295) : StringBuffer
      {
         var _loc3_:StringBuffer = new StringBuffer();
         var _loc4_:uint = length;
         if(param2 > _loc4_)
         {
            param2 = _loc4_;
         }
         _loc3_.appendStringBuffer(this,param1,param2 - param1);
         return _loc3_;
      }
      
      public function substr(param1:uint = 0, param2:uint = 4294967295) : String
      {
         if(param2)
         {
            return toString(param1,Math.min(param1 + param2,4294967295));
         }
         return "";
      }
      
      public function substring(param1:uint, param2:uint = 4294967295) : String
      {
         if(param2 > param1)
         {
            return toString(param1,param2);
         }
         return "";
      }
      
      public function toString(param1:uint = 0, param2:uint = 0) : String
      {
         var _loc3_:ByteArray = null;
         _loc3_ = buffer;
         var _loc5_:int = int(_loc3_.position);
         if(int(!param2) | int(param2 > _loc5_))
         {
            param2 = uint(_loc5_);
         }
         if(param1 >= param2)
         {
            return "";
         }
         _loc3_.position = param1;
         var _loc4_:String = _loc3_.readUTFBytes(param2 - param1);
         _loc3_.position = _loc5_;
         return _loc4_;
      }
      
      public function trimToSize(param1:uint = 0) : uint
      {
         var _loc2_:uint = uint(param1 || size());
         if(_loc2_ >= buffer.length)
         {
            return buffer.length;
         }
         buffer.position = _loc2_;
         buffer.length = _loc2_;
         return _loc2_;
      }
      
      public function trimToSizeVoid(param1:uint = 0) : StringBuffer
      {
         var _loc2_:uint = uint(param1 || size());
         if(_loc2_ >= buffer.length)
         {
            return this;
         }
         buffer.position = _loc2_;
         buffer.length = _loc2_;
         return this;
      }
   }
}


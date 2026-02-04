package com.sulake.core.communication.wireformat
{
   import com.hurlant.util.class_50;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.ByteArray;
   
   [SecureSWF(rename="true")]
   internal final class class_3701 implements IMessageDataWrapper
   {
      
      private var var_197:int;
      
      private var var_24:ByteArray;
      
      public function class_3701(param1:int, param2:ByteArray)
      {
         super();
         var_197 = param1;
         var_24 = param2;
      }
      
      public function getID() : int
      {
         return var_197;
      }
      
      public function readString() : String
      {
         return var_24.readUTF();
      }
      
      public function readInteger() : int
      {
         return var_24.readInt();
      }
      
      public function readLong() : Number
      {
         var _loc2_:uint = var_24.readUnsignedInt();
         var _loc3_:uint = var_24.readUnsignedInt();
         var _loc1_:* = !!(_loc2_ & 0x80000000);
         if(_loc1_)
         {
            _loc2_ = uint(~_loc2_ & 0x7FFFFFFF);
            _loc3_ = ~_loc3_ + 1;
            if(_loc3_ == 0)
            {
               _loc2_ += 1;
            }
         }
         var _loc4_:Number = _loc2_ * 4294967296 + _loc3_;
         if(_loc1_)
         {
            _loc4_ = -_loc4_;
         }
         return _loc4_;
      }
      
      public function readBoolean() : Boolean
      {
         return var_24.readBoolean();
      }
      
      public function readShort() : int
      {
         return var_24.readShort();
      }
      
      public function readByte() : int
      {
         return var_24.readByte();
      }
      
      public function readFloat() : Number
      {
         return var_24.readFloat();
      }
      
      public function readDouble() : Number
      {
         return var_24.readDouble();
      }
      
      public function get bytesAvailable() : uint
      {
         return var_24.bytesAvailable;
      }
      
      public function toString() : String
      {
         return "id=" + var_197 + ", pos=" + var_24.position + ", data=" + class_50.fromArray(var_24,true);
      }
   }
}


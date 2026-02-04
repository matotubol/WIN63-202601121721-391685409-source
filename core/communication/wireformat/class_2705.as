package com.sulake.core.communication.wireformat
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.util.Byte;
   import com.sulake.core.communication.util.Long;
   import com.sulake.core.communication.util.Short;
   import flash.utils.ByteArray;
   
   [SecureSWF(rename="true")]
   public final class class_2705 implements class_2704
   {
      
      private static const MAX_DATA:uint = 262144;
      
      public function class_2705()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function encode(param1:int, param2:Array) : ByteArray
      {
         var _loc10_:Number = NaN;
         var _loc3_:* = false;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc5_:ByteArray = null;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeInt(0);
         _loc4_.writeShort(param1);
         for each(var _loc6_ in param2)
         {
            if(_loc6_ is String)
            {
               _loc4_.writeUTF(_loc6_ as String);
            }
            else if(_loc6_ is int)
            {
               _loc4_.writeInt(_loc6_ as int);
            }
            else if(_loc6_ is Boolean)
            {
               _loc4_.writeBoolean(_loc6_ as Boolean);
            }
            else if(_loc6_ is Short)
            {
               _loc4_.writeShort((_loc6_ as Short).value);
            }
            else if(_loc6_ is Byte)
            {
               _loc4_.writeByte((_loc6_ as Byte).value);
            }
            else if(_loc6_ is Long)
            {
               _loc10_ = (_loc6_ as Long).value;
               _loc3_ = _loc10_ < 0;
               if(_loc3_)
               {
                  _loc10_ = -_loc10_;
               }
               _loc8_ = _loc10_ / 4294967296;
               _loc9_ = uint(_loc10_ & 0xFFFFFFFF);
               if(_loc3_)
               {
                  _loc8_ = uint(~_loc8_);
                  _loc9_ = uint(~(_loc9_ - 1));
                  if(_loc9_ == 0)
                  {
                     _loc8_ += 1;
                  }
               }
               _loc4_.writeUnsignedInt(_loc8_);
               _loc4_.writeUnsignedInt(_loc9_);
            }
            else if(_loc6_ is ByteArray)
            {
               _loc5_ = _loc6_ as ByteArray;
               _loc4_.writeInt(_loc5_.length);
               _loc4_.writeBytes(_loc5_);
            }
         }
         var _loc7_:uint = _loc4_.length;
         _loc4_.position = 0;
         _loc4_.writeInt(_loc7_ - 4);
         _loc4_.position = _loc7_;
         return _loc4_;
      }
      
      public function splitMessages(param1:ByteArray, param2:IConnection) : Array
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:IEncryption = null;
         var _loc10_:ByteArray = null;
         var _loc9_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:Array = [];
         while(param1.bytesAvailable >= 6)
         {
            _loc4_ = param1.position;
            _loc3_ = 0;
            _loc7_ = param2.getServerToClientEncryption();
            if(_loc7_ != null)
            {
               _loc7_.mark();
               _loc10_ = new ByteArray();
               param1.readBytes(_loc10_,0,4);
               _loc7_.decipher(_loc10_);
               _loc3_ = uint(_loc10_.readInt());
            }
            else
            {
               _loc3_ = uint(param1.readInt());
            }
            if(_loc3_ < 2 || _loc3_ > 262144)
            {
               throw new Error("Invalid message length " + _loc3_);
            }
            if(param1.bytesAvailable < _loc3_)
            {
               param1.position = _loc4_;
               if(_loc7_ != null)
               {
                  _loc7_.reset();
               }
               return _loc6_;
            }
            _loc9_ = new ByteArray();
            if(_loc7_ != null)
            {
               _loc5_ = new ByteArray();
               _loc5_.writeBytes(param1,param1.position,_loc3_);
               _loc7_.decipher(_loc5_);
               _loc9_.writeBytes(_loc5_,0,_loc3_);
               _loc9_.position = 0;
            }
            else
            {
               _loc9_.writeBytes(param1,param1.position,_loc3_);
               _loc9_.position = 0;
            }
            param1.position += _loc3_;
            var _loc8_:int = _loc9_.readShort();
            _loc6_.push(new class_3701(0,_loc9_));
         }
         return _loc6_;
      }
   }
}


package com.sulake.core.communication.encryption
{
   import flash.utils.ByteArray;
   
   public class CryptoTools
   {
      
      public function CryptoTools()
      {
         super();
      }
      
      public static function byteArrayToString(param1:ByteArray) : String
      {
         param1.position = 0;
         var _loc2_:String = "";
         while(param1.bytesAvailable)
         {
            _loc2_ += String.fromCharCode(param1.readByte());
         }
         return _loc2_;
      }
      
      public static function stringToByteArray(param1:String) : ByteArray
      {
         var _loc3_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeByte(param1.charCodeAt(_loc3_));
            _loc3_++;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function byteArrayToHexString(param1:ByteArray, param2:Boolean = false) : String
      {
         var _loc6_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         param1.position = 0;
         var _loc5_:String = "";
         while(param1.bytesAvailable)
         {
            _loc6_ = param1.readUnsignedByte();
            _loc3_ = uint(_loc6_ >> 4);
            _loc4_ = uint(_loc6_ & 0x0F);
            _loc5_ += _loc3_.toString(16);
            _loc5_ = _loc5_ + _loc4_.toString(16);
         }
         if(param2)
         {
            _loc5_ = _loc5_.toUpperCase();
         }
         return _loc5_;
      }
      
      public static function hexStringToByteArray(param1:String) : ByteArray
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         var _loc5_:ByteArray = new ByteArray();
         if(param1.length % 2 != 0)
         {
            param1 = "0" + param1;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length - 1)
         {
            _loc3_ = parseInt(param1.charAt(_loc2_ + 0),16);
            _loc4_ = parseInt(param1.charAt(_loc2_ + 1),16);
            _loc6_ = _loc3_ << 4 | _loc4_;
            _loc5_.writeByte(_loc6_);
            _loc2_++;
            _loc2_++;
         }
         return _loc5_;
      }
      
      public static function BigIntegerToRadix(param1:ByteArray, param2:uint = 16) : String
      {
         return "";
      }
      
      public static function fletcher100(param1:ByteArray, param2:int, param3:int) : int
      {
         var _loc6_:int = 0;
         var _loc4_:int = param2;
         var _loc5_:int = param3;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = (_loc4_ + param1[_loc6_]) % 255;
            _loc5_ = (_loc4_ + _loc5_) % 255;
            _loc6_++;
         }
         return (_loc4_ + _loc5_) % 100;
      }
   }
}


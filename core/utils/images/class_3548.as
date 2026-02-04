package com.sulake.core.utils.images
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class class_3548
   {
      
      private const const_377:uint = 1229472850;
      
      private const PLTE:uint = 1347179589;
      
      private const IDAT:uint = 1229209940;
      
      private const IEND:uint = 1229278788;
      
      private var imgWidth:uint = 0;
      
      private var var_2075:uint = 0;
      
      private var bitDepth:uint = 0;
      
      private var var_5205:uint = 0;
      
      private var compressionMethod:uint = 0;
      
      private var var_5173:uint = 0;
      
      private var interlaceMethod:uint = 0;
      
      private var var_1658:Array;
      
      private var input:ByteArray;
      
      private var output:ByteArray;
      
      public function class_3548()
      {
         super();
      }
      
      public function decode(param1:ByteArray) : BitmapData
      {
         var_1658 = [];
         input = new ByteArray();
         output = new ByteArray();
         input = param1;
         input.position = 0;
         if(!readSignature())
         {
            throw new Error("wrong signature");
         }
         getChunks();
         var _loc3_:int = 0;
         while(0 < var_1658.length)
         {
            switch(var_1658[0].type)
            {
               case 1229472850:
                  processIHDR(0);
                  break;
               case 1229209940:
                  processIDAT(0);
            }
            _loc3_++;
         }
         var _loc5_:BitmapData = new BitmapData(imgWidth,var_2075);
         var _loc4_:BitmapData = new BitmapData(imgWidth,var_2075,true,16777215);
         if(output.length > 0 && imgWidth * var_2075 * 4 == output.length)
         {
            output.position = 0;
            _loc5_.setPixels(new Rectangle(0,0,imgWidth,var_2075),output);
            var _loc2_:Matrix = new Matrix();
            null.scale(-1,-1);
            null.translate(imgWidth,var_2075);
            _loc4_.draw(_loc5_,null);
         }
         return _loc4_;
      }
      
      private function processIHDR(param1:uint) : void
      {
         input.position = var_1658[param1].position;
         imgWidth = input.readUnsignedInt();
         var_2075 = input.readUnsignedInt();
         bitDepth = input.readUnsignedByte();
         var_5205 = input.readUnsignedByte();
         compressionMethod = input.readUnsignedByte();
         var_5173 = input.readUnsignedByte();
         interlaceMethod = input.readUnsignedByte();
      }
      
      private function processIDAT(param1:uint) : void
      {
         var _loc7_:int = 0;
         var _loc5_:ByteArray = new ByteArray();
         var _loc8_:uint = imgWidth * 4;
         _loc5_.writeBytes(input,var_1658[param1].position,var_1658[param1].length);
         _loc5_.uncompress();
         _loc7_ = _loc5_.length - 1;
         while(_loc7_ > 0)
         {
            if(_loc7_ % (_loc8_ + 1) != 0)
            {
               var _loc2_:uint = uint(_loc5_[_loc7_]);
               var _loc3_:uint = uint(_loc5_[_loc7_ - 1]);
               var _loc6_:uint = uint(_loc5_[_loc7_ - 2]);
               var _loc4_:uint = uint(_loc5_[_loc7_ - 3]);
               output.writeByte(0);
               output.writeByte(0);
               output.writeByte(0);
               output.writeByte(0);
               _loc7_ -= 3;
            }
            _loc7_--;
         }
      }
      
      private function getChunks() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = int(input.length);
         while(input.position < _loc4_)
         {
            _loc1_ = input.readUnsignedInt();
            _loc3_ = input.readUnsignedInt();
            _loc2_ = input.position;
            input.position += _loc1_;
            input.position += 4;
            var_1658.push({
               "position":_loc2_,
               "length":_loc1_,
               "type":_loc3_
            });
         }
      }
      
      private function readSignature() : Boolean
      {
         return input.readUnsignedInt() == 2303741511 && input.readUnsignedInt() == 218765834;
      }
      
      private function fixType(param1:uint) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = param1.toString(16);
         while(_loc3_.length < 8)
         {
            _loc3_ = "0" + _loc3_;
         }
         _loc2_ += String.fromCharCode(parseInt(_loc3_.substr(0,2),16));
         _loc2_ += String.fromCharCode(parseInt(_loc3_.substr(2,2),16));
         _loc2_ += String.fromCharCode(parseInt(_loc3_.substr(4,2),16));
         return _loc2_ + String.fromCharCode(parseInt(_loc3_.substr(6,2),16));
      }
   }
}


package com.sulake.core.utils.memory
{
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.filters.BitmapFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class SharedBitmapData extends BitmapData
   {
      
      private var var_249:int = 1;
      
      private var var_418:Boolean;
      
      public function SharedBitmapData(param1:int, param2:int, param3:Boolean, param4:uint, param5:Boolean)
      {
         super(param1,param2,param3,param4);
         var_418 = param5;
      }
      
      override public function clone() : BitmapData
      {
         var_249 += 1;
         return this;
      }
      
      override public function dispose() : void
      {
         var_249 -= 1;
         if(var_249 == 0)
         {
            super.dispose();
         }
      }
      
      override public function setPixel(param1:int, param2:int, param3:uint) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.setPixel(param1,param2,param3);
      }
      
      override public function setPixel32(param1:int, param2:int, param3:uint) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.setPixel32(param1,param2,param3);
      }
      
      override public function applyFilter(param1:BitmapData, param2:Rectangle, param3:Point, param4:BitmapFilter) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.applyFilter(param1,param2,param3,param4);
      }
      
      override public function colorTransform(param1:Rectangle, param2:ColorTransform) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.colorTransform(param1,param2);
      }
      
      override public function draw(param1:IBitmapDrawable, param2:Matrix = null, param3:ColorTransform = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.draw(param1,param2,param3,param4,param5,param6);
      }
      
      override public function drawWithQuality(param1:IBitmapDrawable, param2:Matrix = null, param3:ColorTransform = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false, param7:String = null) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.drawWithQuality(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override public function fillRect(param1:Rectangle, param2:uint) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.fillRect(param1,param2);
      }
      
      override public function floodFill(param1:int, param2:int, param3:uint) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.floodFill(param1,param2,param3);
      }
      
      override public function merge(param1:BitmapData, param2:Rectangle, param3:Point, param4:uint, param5:uint, param6:uint, param7:uint) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.merge(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override public function paletteMap(param1:BitmapData, param2:Rectangle, param3:Point, param4:Array = null, param5:Array = null, param6:Array = null, param7:Array = null) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.paletteMap(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override public function perlinNoise(param1:Number, param2:Number, param3:uint, param4:int, param5:Boolean, param6:Boolean, param7:uint = 7, param8:Boolean = false, param9:Array = null) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.perlinNoise(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      override public function pixelDissolve(param1:BitmapData, param2:Rectangle, param3:Point, param4:int = 0, param5:int = 0, param6:uint = 0) : int
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         return super.pixelDissolve(param1,param2,param3,param4,param5,param6);
      }
      
      override public function setPixels(param1:Rectangle, param2:ByteArray) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.setPixels(param1,param2);
      }
      
      override public function setVector(param1:Rectangle, param2:Vector.<uint>) : void
      {
         if(var_418 && var_249 > 1)
         {
            throw new Error("Bitmap is immutable if it is owned by multiple objects.");
         }
         super.setVector(param1,param2);
      }
   }
}


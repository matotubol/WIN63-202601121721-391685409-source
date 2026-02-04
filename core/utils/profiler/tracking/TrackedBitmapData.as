package com.sulake.core.utils.profiler.tracking
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class TrackedBitmapData extends BitmapData
   {
      
      private static const MAX_PIXELS:int = 16777215;
      
      private static const MAX_WIDTH:int = 8191;
      
      private static const MAX_HEIGHT:int = 8191;
      
      private static const MIN_WIDTH:int = 1;
      
      private static const MIN_HEIGHT:int = 1;
      
      public static const DEFAULT_SIZE:int = 4095;
      
      private static var var_1845:uint = 0;
      
      private static var var_2037:uint = 0;
      
      private static const ZERO_POINT:Point = new Point();
      
      private var var_2997:Object;
      
      private var _disposed:Boolean = false;
      
      public function TrackedBitmapData(param1:*, param2:int, param3:int, param4:Boolean = true, param5:uint = 4294967295)
      {
         if(param2 * param3 > 16777215)
         {
            param2 = 4095;
            param3 = 4095;
         }
         else
         {
            if(param2 > 8191)
            {
               param2 = 8191;
            }
            else if(param2 < 1)
            {
               param2 = 1;
            }
            if(param3 > 8191)
            {
               param3 = 8191;
            }
            else if(param3 < 1)
            {
               param3 = 1;
            }
         }
         super(param2,param3,param4,param5);
         var_1845 = var_1845 + 1;
         var_2037 += param2 * param3 * 4;
         var_2997 = param1;
      }
      
      public static function get numInstances() : uint
      {
         return var_1845;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_2037;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            var_2037 -= width * height * 4;
            var_1845 = var_1845 - 1;
            _disposed = true;
            var_2997 = null;
            super.dispose();
         }
      }
      
      override public function clone() : BitmapData
      {
         if(_disposed)
         {
            return null;
         }
         var _loc1_:TrackedBitmapData = new TrackedBitmapData(var_2997,width,height,transparent);
         _loc1_.copyPixels(this,rect,ZERO_POINT);
         return _loc1_;
      }
   }
}


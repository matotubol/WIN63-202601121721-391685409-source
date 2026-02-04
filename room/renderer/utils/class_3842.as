package com.sulake.room.renderer.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   [SecureSWF(rename="true")]
   public class class_3842 extends Bitmap
   {
      
      private var var_2734:int = 128;
      
      private var _basePoint:Point;
      
      private var var_3795:String = "";
      
      private var var_3099:String = "";
      
      private var var_3762:Boolean = false;
      
      private var var_4039:Boolean = false;
      
      private var _varyingDepth:Boolean = false;
      
      private var _bitmapData:class_4036 = null;
      
      private var _width:int = 0;
      
      private var var_385:int = 0;
      
      private var _updateID1:int = -1;
      
      private var _updateID2:int = -1;
      
      private var _offsetRefX:int = 0;
      
      private var _offsetRefY:int = 0;
      
      public function class_3842()
      {
         super();
         _basePoint = new Point();
         cacheAsBitmap = false;
      }
      
      public function get alphaTolerance() : int
      {
         return var_2734;
      }
      
      public function set alphaTolerance(param1:int) : void
      {
         var_2734 = param1;
      }
      
      public function get tag() : String
      {
         return var_3795;
      }
      
      public function set tag(param1:String) : void
      {
         var_3795 = param1;
      }
      
      public function get identifier() : String
      {
         return var_3099;
      }
      
      public function set identifier(param1:String) : void
      {
         var_3099 = param1;
      }
      
      public function get varyingDepth() : Boolean
      {
         return _varyingDepth;
      }
      
      public function set varyingDepth(param1:Boolean) : void
      {
         _varyingDepth = param1;
      }
      
      public function get clickHandling() : Boolean
      {
         return var_3762;
      }
      
      public function set clickHandling(param1:Boolean) : void
      {
         var_3762 = param1;
      }
      
      public function get skipMouseHandling() : Boolean
      {
         return var_4039;
      }
      
      public function set skipMouseHandling(param1:Boolean) : void
      {
         var_4039 = param1;
      }
      
      public function get offsetRefX() : int
      {
         return _offsetRefX;
      }
      
      public function set offsetRefX(param1:int) : void
      {
         _offsetRefX = param1;
      }
      
      public function get offsetRefY() : int
      {
         return _offsetRefY;
      }
      
      public function set offsetRefY(param1:int) : void
      {
         _offsetRefY = param1;
      }
      
      public function dispose() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         if(param1 == bitmapData)
         {
            return;
         }
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(param1 != null)
         {
            _width = param1.width;
            var_385 = param1.height;
            var _loc2_:class_4036 = param1 as class_4036;
         }
         else
         {
            _width = 0;
            var_385 = 0;
            _updateID1 = -1;
            _updateID2 = -1;
         }
         super.bitmapData = param1;
      }
      
      public function needsUpdate(param1:int, param2:int) : Boolean
      {
         if(param1 != _updateID1 || param2 != _updateID2)
         {
            _updateID1 = param1;
            _updateID2 = param2;
            return true;
         }
         if(_bitmapData != null && _bitmapData.disposed)
         {
            return true;
         }
         return false;
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return hitTest(param1,param2);
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         if(var_2734 > 255 || bitmapData == null)
         {
            return false;
         }
         if(param1 < 0 || param2 < 0 || param1 >= _width || param2 >= var_385)
         {
            return false;
         }
         return hitTestBitmapData(param1,param2);
      }
      
      private function hitTestBitmapData(param1:int, param2:int) : Boolean
      {
         var _loc4_:* = 0;
         var _loc3_:* = false;
         try
         {
            _loc4_ = bitmapData.getPixel32(param1,param2);
            _loc4_ = uint(_loc4_ >> 24);
            _loc3_ = _loc4_ > var_2734;
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
   }
}


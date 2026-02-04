package com.sulake.habbo.window.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class class_3805
   {
      
      private static const GLYPH_ASSET_PREFIX:String = "unique_item_number_glyph_";
      
      public function class_3805()
      {
         super();
      }
      
      public static function createBitmap(param1:class_40, param2:int, param3:int, param4:int) : BitmapData
      {
         var _loc14_:BitmapDataAsset = null;
         var _loc9_:BitmapData = new BitmapData(param3,param4,true,0);
         var _loc12_:int = param2 % 10;
         var _loc5_:int = param2 / 10 % 10;
         var _loc13_:int = param2 / 100 % 10;
         var _loc7_:int = param2 / 1000 % 10;
         var _loc10_:Array = [];
         var _loc11_:int = 0;
         if(_loc7_ > 0)
         {
            _loc14_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc7_));
            _loc10_.push(_loc14_);
            _loc11_ += _loc14_.rectangle.width;
         }
         if(_loc7_ > 0 || _loc13_ > 0)
         {
            _loc14_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc13_));
            _loc10_.push(_loc14_);
            _loc11_ += _loc14_.rectangle.width;
         }
         if(_loc7_ > 0 || _loc13_ > 0 || _loc5_ > 0)
         {
            _loc14_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc5_));
            _loc10_.push(_loc14_);
            _loc11_ += _loc14_.rectangle.width;
         }
         _loc14_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc12_));
         _loc10_.push(_loc14_);
         _loc11_ += _loc14_.rectangle.width;
         _loc11_ = _loc11_ - 1;
         var _loc8_:Point = new Point((param3 - _loc11_) / 2,0);
         while(0 < _loc10_.length)
         {
            _loc14_ = _loc10_[0];
            _loc9_.copyPixels(BitmapData(_loc14_.content),_loc14_.rectangle,_loc8_);
            _loc8_.x += _loc14_.rectangle.width;
            _loc6_++;
         }
         return _loc9_;
      }
   }
}


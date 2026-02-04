package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   
   public class PlaneTexture
   {
      
      public static const const_21:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _bitmaps:Array = [];
      
      public function PlaneTexture()
      {
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneTextureBitmap = null;
         if(_bitmaps != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _bitmaps.length)
            {
               _loc1_ = _bitmaps[_loc2_] as PlaneTextureBitmap;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _bitmaps = null;
         }
      }
      
      public function addBitmap(param1:BitmapData, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1, param6:String = null) : void
      {
         var _loc7_:PlaneTextureBitmap = new PlaneTextureBitmap(param1,param2,param3,param4,param5,param6);
         _bitmaps.push(_loc7_);
      }
      
      public function getBitmap(param1:IVector3d) : BitmapData
      {
         var _loc2_:PlaneTextureBitmap = getPlaneTextureBitmap(param1);
         return _loc2_?.bitmap;
      }
      
      public function getPlaneTextureBitmap(param1:IVector3d) : PlaneTextureBitmap
      {
         var _loc3_:int = 0;
         var _loc2_:PlaneTextureBitmap = null;
         if(param1 == null)
         {
            return null;
         }
         _loc3_ = 0;
         while(_loc3_ < _bitmaps.length)
         {
            _loc2_ = _bitmaps[_loc3_] as PlaneTextureBitmap;
            if(_loc2_ != null)
            {
               if(param1.x >= _loc2_.normalMinX && param1.x <= _loc2_.normalMaxX && param1.y >= _loc2_.normalMinY && param1.y <= _loc2_.normalMaxY)
               {
                  return _loc2_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getAssetName(param1:IVector3d) : String
      {
         var _loc2_:PlaneTextureBitmap = getPlaneTextureBitmap(param1);
         return _loc2_?.assetName;
      }
   }
}


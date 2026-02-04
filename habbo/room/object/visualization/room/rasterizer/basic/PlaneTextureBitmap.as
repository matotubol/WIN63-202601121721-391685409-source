package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import flash.display.BitmapData;
   
   public class PlaneTextureBitmap
   {
      
      public static const const_21:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _bitmap:BitmapData = null;
      
      private var var_3819:Number = -1;
      
      private var var_4079:Number = 1;
      
      private var var_4381:Number = -1;
      
      private var var_3994:Number = 1;
      
      private var _assetName:String = null;
      
      public function PlaneTextureBitmap(param1:BitmapData, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1, param6:String = null)
      {
         super();
         var_3819 = param2;
         var_4079 = param3;
         var_4381 = param4;
         var_3994 = param5;
         _assetName = param6;
         _bitmap = param1;
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
      
      public function get normalMinX() : Number
      {
         return var_3819;
      }
      
      public function get normalMaxX() : Number
      {
         return var_4079;
      }
      
      public function get normalMinY() : Number
      {
         return var_4381;
      }
      
      public function get normalMaxY() : Number
      {
         return var_3994;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function dispose() : void
      {
         _bitmap = null;
      }
   }
}


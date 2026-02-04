package com.sulake.room.object.visualization.utils
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   public class GraphicAssetPalette
   {
      
      private static var BLANK:Array = [];
      
      private var var_1745:Array = [];
      
      private var _primaryColor:int = 0;
      
      private var _secondaryColor:int = 0;
      
      public function GraphicAssetPalette(param1:ByteArray, param2:int, param3:int)
      {
         super();
         param1.position = 0;
         while(param1.bytesAvailable >= 3)
         {
            var _loc4_:uint = param1.readUnsignedByte();
            var _loc6_:uint = param1.readUnsignedByte();
            var _loc5_:uint = param1.readUnsignedByte();
            var _loc7_:uint = uint(-16777216 | 0 << 16 | 0 << 8 | 0);
            var_1745.push(0);
         }
         while(var_1745.length < 256)
         {
            var_1745.push(0);
         }
         while(BLANK.length < 256)
         {
            BLANK.push(0);
         }
         _primaryColor = param2;
         _secondaryColor = param3;
      }
      
      public function get primaryColor() : int
      {
         return _primaryColor;
      }
      
      public function get secondaryColor() : int
      {
         return _secondaryColor;
      }
      
      public function dispose() : void
      {
         var_1745 = [];
      }
      
      public function colorizeBitmap(param1:BitmapData) : void
      {
         var _loc2_:BitmapData = param1.clone();
         param1.paletteMap(param1,param1.rect,new Point(0,0),BLANK,var_1745,BLANK,BLANK);
         param1.copyChannel(_loc2_,param1.rect,new Point(0,0),8,8);
         _loc2_.dispose();
      }
   }
}


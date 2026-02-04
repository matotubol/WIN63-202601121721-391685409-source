package com.sulake.habbo.window.utils.floorplaneditor
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class FloorPlanPreviewer
   {
      
      public static var tile_preview_0:Class = tile_preview_0_png$eb6ee9f516522093422b52292f9e8ec11109157272;
      
      public static var tile_preview_1:Class = tile_preview_1_png$75ce8f3d02e0e8bb269a02e29af425811114536985;
      
      public static var tile_preview_2:Class = tile_preview_2_png$cb9c6a834dd035747d492944d6e37e8b1114657946;
      
      public static var tile_preview_3:Class = tile_preview_3_png$82f88a8a6f49d9771db61c84961137fc1111666459;
      
      public static var tile_preview_4:Class = tile_preview_4_png$5ea65399b740e0d98af1e469a8e10c481112835988;
      
      public static var tile_preview_5:Class = tile_preview_5_png$900862b1b5c3ac270d617c55e769563e1101438485;
      
      public static var tile_preview_6:Class = tile_preview_6_png$28eddf1319b72fdd217e9e4df4e017251101592214;
      
      public static var tile_preview_7:Class = tile_preview_7_png$325d423d950020b8e9d2bbd143a4db711102758167;
      
      public static var tile_preview_8:Class = tile_preview_8_png$3268b80421edaaf3ffa1b34ebcf73c171099749776;
      
      public static var tile_preview_9:Class = tile_preview_9_png$e62aa42e3fb9b9db52d702b46c8eea591100951569;
      
      public static var tile_preview_a:Class = tile_preview_a_png$95e5a1285d77442262c00c89f568d75f1607132617;
      
      public static var tile_preview_b:Class = tile_preview_b_png$34490a2792a46fceae1ed1857abcbc5a1608318026;
      
      public static var tile_preview_c:Class = tile_preview_c_png$de22ebdbe2b946013e46ff86b7a6102d1596904651;
      
      public static var tile_preview_d:Class = tile_preview_d_png$39fc6a86d930b766fa589ddd96273f8d1597058884;
      
      public static var tile_preview_e:Class = tile_preview_e_png$810de490c513f8bc619ed9ef0a3232cc1594034117;
      
      public static var tile_preview_f:Class = tile_preview_f_png$9aad22f410629ea378b0a610d837f8a01595219526;
      
      public static var tile_preview_entry:Class = class_4071;
      
      private var _bcFloorPlanEditor:BCFloorPlanEditor;
      
      private var _tileImages:Vector.<BitmapData>;
      
      private var _floorPlan:FloorPlanCache;
      
      public function FloorPlanPreviewer(param1:BCFloorPlanEditor)
      {
         super();
         _bcFloorPlanEditor = param1;
         _floorPlan = param1.floorPlanCache;
         _tileImages = new Vector.<BitmapData>(0);
         _tileImages.push(Bitmap(new tile_preview_0()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_1()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_2()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_3()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_4()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_5()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_6()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_7()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_8()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_9()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_a()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_b()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_c()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_d()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_e()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_f()).bitmapData);
         _tileImages.push(Bitmap(new tile_preview_entry()).bitmapData);
      }
      
      private static function getCanvasPoint(param1:int, param2:int, param3:int) : Point
      {
         return new Point(8 * (param1 - param2),4 * (param1 + param2) - 8 * param3);
      }
      
      public function updatePreview() : void
      {
         var _loc20_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc11_:Point = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc4_:int = 0;
         var _loc16_:* = 0;
         var _loc15_:Array = [];
         var _loc18_:int = 2147483647;
         var _loc17_:int = 2147483647;
         var _loc2_:int = -2147483648;
         var _loc1_:int = -2147483648;
         _loc22_ = 0;
         while(_loc22_ < _floorPlan.floorHeight)
         {
            _loc20_ = 0;
            while(_loc20_ < _floorPlan.floorWidth)
            {
               _loc23_ = _floorPlan.getHeightAt(_loc20_,_loc22_);
               if(_loc23_ >= 0)
               {
                  _loc11_ = getCanvasPoint(_loc20_,_loc22_,_loc23_);
                  _loc18_ = Math.min(_loc18_,_loc11_.x);
                  _loc17_ = Math.min(_loc17_,_loc11_.y);
                  _loc2_ = Math.max(_loc2_,_loc11_.x);
                  _loc1_ = Math.max(_loc1_,_loc11_.y);
                  _loc5_ = _floorPlan.getHeightAt(_loc20_ - 1,_loc22_ - 1);
                  _loc7_ = _floorPlan.getHeightAt(_loc20_,_loc22_ - 1);
                  _loc8_ = _floorPlan.getHeightAt(_loc20_ + 1,_loc22_ - 1);
                  _loc9_ = _floorPlan.getHeightAt(_loc20_ - 1,_loc22_);
                  _loc10_ = _floorPlan.getHeightAt(_loc20_ + 1,_loc22_);
                  _loc12_ = _floorPlan.getHeightAt(_loc20_ - 1,_loc22_ + 1);
                  _loc13_ = _floorPlan.getHeightAt(_loc20_,_loc22_ + 1);
                  _loc14_ = _floorPlan.getHeightAt(_loc20_ + 1,_loc22_ + 1);
                  _loc4_ = _loc23_ + 1;
                  _loc16_ = (_loc5_ == _loc4_ || _loc7_ == _loc4_ || _loc9_ == _loc4_ ? 1 : 0) | (_loc8_ == _loc4_ || _loc7_ == _loc4_ || _loc10_ == _loc4_ ? 2 : 0) | (_loc12_ == _loc4_ || _loc13_ == _loc4_ || _loc9_ == _loc4_ ? 4 : 0) | (_loc14_ == _loc4_ || _loc13_ == _loc4_ || _loc10_ == _loc4_ ? 8 : 0);
                  if(_loc16_ == 15)
                  {
                     _loc16_ = 0;
                  }
                  if(_floorPlan.isEntryPoint(_loc20_,_loc22_))
                  {
                     _loc16_ = _tileImages.length - 1;
                  }
                  _loc15_.push({
                     "point":_loc11_,
                     "type":_loc16_
                  });
               }
               _loc20_++;
            }
            _loc22_++;
         }
         var _loc21_:int = Math.min(_loc2_ - _loc18_ + 18,4095);
         var _loc24_:int = Math.min(_loc1_ - _loc17_ + 18,4095);
         var _loc19_:BitmapData = new BitmapData(_loc21_,_loc24_,false,4294967295);
         var _loc3_:Point = new Point(-_loc18_,-_loc17_);
         for each(var _loc6_ in _loc15_)
         {
            _loc19_.copyPixels(_tileImages[_loc6_.type],_tileImages[_loc6_.type].rect,_loc6_.point.add(_loc3_));
         }
         _bcFloorPlanEditor.updatePreviewBitmap(_loc19_);
      }
   }
}


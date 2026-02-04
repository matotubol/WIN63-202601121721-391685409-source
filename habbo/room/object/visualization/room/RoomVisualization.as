package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.IRoomPlane;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.class_2075;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class RoomVisualization extends RoomObjectSpriteVisualization implements class_2075
   {
      
      public static const const_584:int = 16777215;
      
      public static const const_1128:int = 14540253;
      
      public static const FLOOR_COLOR_RIGHT:int = 12303291;
      
      private static const const_460:int = 16777215;
      
      private static const WALL_COLOR_SIDE:int = 13421772;
      
      private static const WALL_COLOR_BOTTOM:int = 10066329;
      
      private static const WALL_COLOR_BORDER:int = 10066329;
      
      public static const LANDSCAPE_COLOR_TOP:int = 16777215;
      
      public static const LANDSCAPE_COLOR_SIDE:int = 13421772;
      
      public static const LANDSCAPE_COLOR_BOTTOM:int = 10066329;
      
      private static const ROOM_DEPTH_OFFSET:Number = 1000;
      
      protected var var_24:RoomVisualizationData = null;
      
      private var var_909:AssetLibrary = null;
      
      private var var_102:RoomPlaneParser = null;
      
      private var var_152:Array = [];
      
      private var var_1183:Dictionary = new Dictionary();
      
      private var var_3245:Boolean = false;
      
      private var var_390:Array = [];
      
      private var _visiblePlaneSpriteNumbers:Array = [];
      
      private var _boundingRectangle:Rectangle = null;
      
      private var var_893:RoomPlaneBitmapMaskParser = null;
      
      private var var_2865:String = null;
      
      private var var_2808:String = null;
      
      private var var_2981:String = null;
      
      private var var_2043:Number = NaN;
      
      private var var_2562:Number = NaN;
      
      private var _floorHoleUpdateTime:Number = NaN;
      
      private var var_3191:String = null;
      
      private var _backgroundColor:uint = 16777215;
      
      private var _backgroundRed:int = 255;
      
      private var _backgroundGreen:int = 255;
      
      private var _backgroundBlue:int = 255;
      
      private var var_2155:int = 0;
      
      private var _lastUpdateTime:int = -1000;
      
      private const const_565:int = 250;
      
      private var var_2795:int = -1;
      
      private var var_2205:Number = 0;
      
      private var var_4219:Number = 0;
      
      private var var_4377:Number = 0;
      
      private var var_3217:Number = 0;
      
      private var var_746:Array = [];
      
      private var _highlightAreaX:int = 0;
      
      private var _highlightAreaY:int = 0;
      
      private var _highlightAreaWidth:int = 0;
      
      private var _highlightAreaHeight:int = 0;
      
      private var _highlightFilter:Array;
      
      public function RoomVisualization()
      {
         super();
         var_909 = new AssetLibrary("room visualization");
         var_102 = new RoomPlaneParser();
         var_893 = new RoomPlaneBitmapMaskParser();
         var_746[0] = false;
         var_746[2] = true;
         var_746[1] = true;
         var_746[3] = true;
      }
      
      public function get floorRelativeDepth() : Number
      {
         return 1000 + 0.1;
      }
      
      public function get wallRelativeDepth() : Number
      {
         return 1000 + 0.5;
      }
      
      public function get wallAdRelativeDepth() : Number
      {
         return 1000 + 0.49;
      }
      
      public function get planeCount() : int
      {
         return var_152.length;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IAsset = null;
         super.dispose();
         if(var_909 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_909.numAssets)
            {
               _loc2_ = var_909.getAssetByIndex(_loc1_);
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_909.dispose();
            var_909 = null;
         }
         resetRoomPlanes();
         var_152 = null;
         var_1183 = null;
         var_390 = null;
         _visiblePlaneSpriteNumbers = null;
         if(var_102 != null)
         {
            var_102.dispose();
            var_102 = null;
         }
         if(var_893 != null)
         {
            var_893.dispose();
            var_893 = null;
         }
         if(var_24 != null)
         {
            var_24.clearCache();
            var_24 = null;
         }
      }
      
      private function resetRoomPlanes() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RoomPlane = null;
         if(var_152 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_152.length)
            {
               _loc1_ = var_152[_loc2_] as RoomPlane;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_152 = [];
            var_1183 = new Dictionary();
         }
         var_3245 = false;
         var_2155 += 1;
         reset();
      }
      
      override protected function reset() : void
      {
         super.reset();
         var_2865 = null;
         var_2808 = null;
         var_2981 = null;
         var_3191 = null;
         var_2795 = -1;
         var_3217 = 0;
      }
      
      override public function get boundingRectangle() : Rectangle
      {
         if(_boundingRectangle == null)
         {
            _boundingRectangle = super.boundingRectangle;
         }
         return new Rectangle(_boundingRectangle.x,_boundingRectangle.y,_boundingRectangle.width,_boundingRectangle.height);
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is RoomVisualizationData))
         {
            return false;
         }
         var_24 = param1 as RoomVisualizationData;
         var_24.initializeAssetCollection(assetCollection);
         return true;
      }
      
      protected function defineSprites(param1:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc2_:RoomPlane = null;
         var _loc3_:IRoomObjectSprite = null;
         var _loc5_:int = int(var_152.length);
         createSprites(_loc5_);
         _loc4_ = param1;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = var_152[_loc4_] as RoomPlane;
            _loc3_ = getSprite(_loc4_);
            if(_loc3_ != null && _loc2_ != null && _loc2_.leftSide != null && _loc2_.rightSide != null)
            {
               if(_loc2_.type == 1 && (_loc2_.leftSide.length < 1 || _loc2_.rightSide.length < 1))
               {
                  _loc3_.alphaTolerance = 256;
               }
               else
               {
                  _loc3_.alphaTolerance = 128;
               }
               if(_loc2_.type == 1)
               {
                  _loc3_.tag = "plane.wall@" + (_loc4_ + 1);
               }
               else if(_loc2_.type == 2)
               {
                  _loc3_.tag = "plane.floor@" + (_loc4_ + 1);
               }
               else
               {
                  _loc3_.tag = "plane@" + (_loc4_ + 1);
               }
               _loc3_.spriteType = RoomObjectSpriteType.ROOM_PLANE;
               if(var_102.isPlaneTemporaryHighlighter(_loc4_))
               {
                  _loc3_.filters = _highlightFilter;
                  _loc3_.skipMouseHandling = true;
                  _loc2_.extraDepth = -100;
                  _loc2_.isHighlighter = true;
               }
               else
               {
                  _loc3_.filters = [];
                  _loc3_.skipMouseHandling = false;
                  _loc2_.extraDepth = 0;
                  _loc2_.isHighlighter = false;
               }
            }
            _loc4_++;
         }
      }
      
      protected function initializeRoomPlanes() : void
      {
         if(var_3245)
         {
            return;
         }
         var _loc1_:IRoomObject = object;
         if(_loc1_ == null)
         {
            return;
         }
         if(!isNaN(var_2043))
         {
            var_102.floorThicknessMultiplier = var_2043;
         }
         if(!isNaN(var_2562))
         {
            var_102.wallThicknessMultiplier = var_2562;
         }
         var _loc2_:String = _loc1_.getModel().getString("room_plane_xml");
         var_102.clearHighlightArea();
         if(!var_102.initializeFromXML(new XML(_loc2_)))
         {
            return;
         }
         var_102.initializeHighlightArea(_highlightAreaX,_highlightAreaY,_highlightAreaWidth,_highlightAreaHeight);
         createPlanesAndSprites();
      }
      
      private function createPlanesAndSprites(param1:int = 0) : void
      {
         var _loc8_:int = 0;
         var _loc4_:IVector3d = null;
         var _loc18_:IVector3d = null;
         var _loc11_:IVector3d = null;
         var _loc7_:Array = null;
         var _loc12_:int = 0;
         var _loc2_:RoomPlane = null;
         var _loc5_:IVector3d = null;
         var _loc19_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc10_:int = 0;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc23_:Number = getLandscapeWidth();
         var _loc17_:Number = getLandscapeHeight();
         var _loc22_:Number = 0;
         var _loc20_:IRoomObject = object;
         var _loc16_:int = _loc20_.getModel().getNumber("room_random_seed");
         _loc8_ = param1;
         while(_loc8_ < var_102.planeCount)
         {
            var_1183[_loc8_] = -1;
            _loc4_ = var_102.getPlaneLocation(_loc8_);
            _loc18_ = var_102.getPlaneLeftSide(_loc8_);
            _loc11_ = var_102.getPlaneRightSide(_loc8_);
            _loc7_ = var_102.getPlaneSecondaryNormals(_loc8_);
            _loc12_ = var_102.getPlaneType(_loc8_);
            _loc2_ = null;
            if(!(_loc4_ != null && _loc18_ != null && _loc11_ != null))
            {
               return;
            }
            _loc5_ = Vector3d.crossProduct(_loc18_,_loc11_);
            _loc16_ = _loc16_ * 7613 + 517;
            _loc2_ = null;
            if(_loc12_ == 1)
            {
               _loc19_ = _loc4_.x + _loc18_.x + 0.5;
               _loc21_ = _loc4_.y + _loc11_.y + 0.5;
               _loc13_ = int(_loc19_) - _loc19_;
               _loc14_ = int(_loc21_) - _loc21_;
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,2,true,_loc7_,_loc16_,-_loc13_,-_loc14_);
               if(_loc5_.z != 0)
               {
                  _loc2_.color = 16777215;
               }
               else
               {
                  _loc2_.color = _loc5_.x != 0 ? 12303291 : 14540253;
               }
               if(var_24 != null)
               {
                  _loc2_.rasterizer = var_24.floorRasterizer;
               }
            }
            else if(_loc12_ == 2)
            {
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,1,true,_loc7_,_loc16_);
               if(_loc18_.length < 1 || _loc11_.length < 1)
               {
                  _loc2_.hasTexture = false;
               }
               if(_loc5_.x == 0 && _loc5_.y == 0)
               {
                  _loc2_.color = 10066329;
               }
               else if(_loc5_.y > 0)
               {
                  _loc2_.color = 16777215;
               }
               else if(_loc5_.y == 0)
               {
                  _loc2_.color = 13421772;
               }
               else
               {
                  _loc2_.color = 10066329;
               }
               if(var_24 != null)
               {
                  _loc2_.rasterizer = var_24.wallRasterizer;
               }
            }
            else if(_loc12_ == 3)
            {
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,3,true,_loc7_,_loc16_,_loc22_,0,_loc23_,_loc17_);
               if(_loc5_.y > 0)
               {
                  _loc2_.color = 16777215;
               }
               else if(_loc5_.y == 0)
               {
                  _loc2_.color = 13421772;
               }
               else
               {
                  _loc2_.color = 10066329;
               }
               if(var_24 != null)
               {
                  _loc2_.rasterizer = var_24.landscapeRasterizer;
               }
               _loc22_ += _loc18_.length;
            }
            else if(_loc12_ == 4)
            {
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,1,true,_loc7_,_loc16_);
               if(_loc18_.length < 1 || _loc11_.length < 1)
               {
                  _loc2_.hasTexture = false;
               }
               if(_loc5_.x == 0 && _loc5_.y == 0)
               {
                  _loc2_.color = 10066329;
               }
               else if(_loc5_.y > 0)
               {
                  _loc2_.color = 16777215;
               }
               else if(_loc5_.y == 0)
               {
                  _loc2_.color = 13421772;
               }
               else
               {
                  _loc2_.color = 10066329;
               }
               if(var_24 != null)
               {
                  _loc2_.rasterizer = var_24.wallAdRasterizr;
               }
            }
            if(_loc2_ != null)
            {
               _loc2_.maskManager = var_24.maskManager;
               _loc10_ = 0;
               while(_loc10_ < var_102.getPlaneMaskCount(_loc8_))
               {
                  _loc6_ = var_102.getPlaneMaskLeftSideLoc(_loc8_,_loc10_);
                  _loc3_ = var_102.getPlaneMaskRightSideLoc(_loc8_,_loc10_);
                  _loc15_ = var_102.getPlaneMaskLeftSideLength(_loc8_,_loc10_);
                  _loc9_ = var_102.getPlaneMaskRightSideLength(_loc8_,_loc10_);
                  _loc2_.addRectangleMask(_loc6_,_loc3_,_loc15_,_loc9_);
                  _loc10_++;
               }
               var_1183[_loc8_] = var_152.length;
               var_152.push(_loc2_);
            }
            _loc8_++;
         }
         var_3245 = true;
         defineSprites(param1);
      }
      
      public function initializeHighlightArea(param1:int, param2:int, param3:int, param4:int, param5:Array) : void
      {
         clearHighlightArea();
         _highlightAreaX = param1;
         _highlightAreaY = param2;
         _highlightAreaWidth = param3;
         _highlightAreaHeight = param4;
         _highlightFilter = param5;
         var_102.initializeHighlightArea(param1,param2,param3,param4);
         createPlanesAndSprites(var_152.length);
         reset();
      }
      
      public function clearHighlightArea() : void
      {
         _highlightAreaX = 0;
         _highlightAreaY = 0;
         _highlightAreaWidth = 0;
         _highlightAreaHeight = 0;
         var _loc3_:int = var_102.clearHighlightArea();
         var _loc4_:int = 0;
         var _loc1_:int = var_102.planeCount;
         while(0 < var_102.planeCount + _loc3_)
         {
            var _loc2_:int = int(var_1183[0]);
            _loc4_ += 1;
            var_1183[0] = -1;
            _loc1_ = 0 + 1;
         }
         var_152 = var_152.slice(0,var_152.length - _loc4_);
         createSprites(var_152.length);
         reset();
      }
      
      private function getLandscapeWidth() : Number
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_102.planeCount)
         {
            _loc3_ = var_102.getPlaneType(_loc2_);
            if(_loc3_ == 3)
            {
               var _loc1_:IVector3d = var_102.getPlaneLeftSide(_loc2_);
               var _loc4_:Number = 0 + null.length;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function getLandscapeHeight() : Number
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_102.planeCount)
         {
            _loc4_ = var_102.getPlaneType(_loc2_);
            if(_loc4_ == 3)
            {
               var _loc3_:IVector3d = var_102.getPlaneRightSide(_loc2_);
               if(null.length > 0)
               {
                  var _loc1_:Number = Number(null.length);
               }
            }
            _loc2_++;
         }
         return 0;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc16_:int = 0;
         var _loc14_:IRoomObjectSprite = null;
         var _loc5_:RoomPlane = null;
         var _loc7_:* = 0;
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc10_:* = 0;
         var _loc13_:* = 0;
         var _loc12_:IRoomObject = object;
         if(_loc12_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc9_:Boolean = updateGeometry(param1);
         var _loc15_:IRoomObjectModel = _loc12_.getModel();
         var _loc18_:Boolean = false;
         if(updatePlaneThicknesses(_loc15_))
         {
            _loc18_ = true;
         }
         if(updateFloorHoles(_loc15_))
         {
            _loc18_ = true;
         }
         initializeRoomPlanes();
         _loc18_ = updateMasksAndColors(_loc15_);
         var _loc17_:int = param2;
         if(_loc17_ < _lastUpdateTime + 250 && !_loc9_ && !_loc18_)
         {
            return;
         }
         if(updatePlaneTexturesAndVisibilities(_loc15_))
         {
            if(!_loc18_)
            {
               _loc18_ = true;
            }
         }
         if(updatePlanes(param1,_loc9_,param2))
         {
            if(!_loc18_)
            {
               _loc18_ = true;
            }
         }
         if(_loc18_)
         {
            _loc8_ = 0;
            while(_loc8_ < var_390.length)
            {
               _loc16_ = int(_visiblePlaneSpriteNumbers[_loc8_]);
               _loc14_ = getSprite(_loc16_);
               _loc5_ = var_390[_loc8_] as RoomPlane;
               if(_loc14_ != null && _loc5_ != null && _loc5_.type != 3)
               {
                  _loc7_ = _loc5_.color;
                  _loc11_ = (_loc7_ & 0xFF) * _backgroundBlue / 255;
                  _loc6_ = (_loc7_ >> 8 & 0xFF) * _backgroundGreen / 255;
                  _loc10_ = (_loc7_ >> 16 & 0xFF) * _backgroundRed / 255;
                  _loc13_ = uint(_loc7_ >> 24);
                  _loc7_ = (_loc13_ << 24) + (_loc10_ << 16) + (_loc6_ << 8) + _loc11_;
                  _loc14_.color = _loc7_;
               }
               _loc8_++;
            }
            increaseUpdateId();
         }
         var_262 = _loc15_.getUpdateID();
         _lastUpdateTime = _loc17_;
      }
      
      private function updateGeometry(param1:IRoomGeometry) : Boolean
      {
         if(param1.updateId != var_2795)
         {
            var_2795 = param1.updateId;
            _boundingRectangle = null;
            var _loc2_:IVector3d = param1.direction;
         }
         return false;
      }
      
      private function updateMasksAndColors(param1:IRoomObjectModel) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         if(var_262 != param1.getUpdateID())
         {
            _loc2_ = param1.getString("room_plane_mask_xml");
            if(_loc2_ != var_3191)
            {
               updatePlaneMasks(_loc2_);
               var_3191 = _loc2_;
               var _loc4_:Boolean = true;
            }
            _loc3_ = param1.getNumber("room_background_color");
            if(_loc3_ != _backgroundColor)
            {
               _backgroundColor = _loc3_;
               _backgroundBlue = _backgroundColor & 0xFF;
               _backgroundGreen = _backgroundColor >> 8 & 0xFF;
               _backgroundRed = _backgroundColor >> 16 & 0xFF;
               _loc4_ = true;
            }
         }
         return false;
      }
      
      private function updatePlaneTexturesAndVisibilities(param1:IRoomObjectModel) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc4_:Boolean = false;
         if(var_262 != param1.getUpdateID())
         {
            _loc5_ = param1.getString("room_wall_type");
            _loc6_ = param1.getString("room_floor_type");
            _loc2_ = param1.getString("room_landscape_type");
            updatePlaneTextureTypes(_loc6_,_loc5_,_loc2_);
            _loc3_ = Boolean(param1.getNumber("room_floor_visibility"));
            _loc7_ = Boolean(param1.getNumber("room_wall_visibility"));
            _loc4_ = Boolean(param1.getNumber("room_landscape_visibility"));
            updatePlaneTypeVisibilities(_loc3_,_loc7_,_loc4_);
            return true;
         }
         return false;
      }
      
      private function updatePlaneThicknesses(param1:IRoomObjectModel) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(var_262 != param1.getUpdateID())
         {
            _loc3_ = param1.getNumber("room_floor_thickness");
            _loc2_ = param1.getNumber("room_wall_thickness");
            if(!isNaN(_loc3_) && !isNaN(_loc2_) && (_loc3_ != var_2043 || _loc2_ != var_2562))
            {
               var_2043 = _loc3_;
               var_2562 = _loc2_;
               resetRoomPlanes();
               return true;
            }
         }
         return false;
      }
      
      private function updateFloorHoles(param1:IRoomObjectModel) : Boolean
      {
         var _loc2_:Number = NaN;
         if(var_262 != param1.getUpdateID())
         {
            _loc2_ = param1.getNumber("room_floor_hole_update_time");
            if(!isNaN(_loc2_) && _loc2_ != _floorHoleUpdateTime)
            {
               _floorHoleUpdateTime = _loc2_;
               resetRoomPlanes();
               return true;
            }
         }
         return false;
      }
      
      protected function updatePlaneTextureTypes(param1:String, param2:String, param3:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:RoomPlane = null;
         if(param1 != var_2808)
         {
            var_2808 = param1;
         }
         else
         {
            param1 = null;
         }
         if(param2 != var_2865)
         {
            var_2865 = param2;
         }
         else
         {
            param2 = null;
         }
         if(param3 != var_2981)
         {
            var_2981 = param3;
         }
         else
         {
            param3 = null;
         }
         if(param1 == null && param2 == null && param3 == null)
         {
            return false;
         }
         _loc5_ = 0;
         while(_loc5_ < var_152.length)
         {
            _loc4_ = var_152[_loc5_] as RoomPlane;
            if(_loc4_ != null)
            {
               if(_loc4_.type == 2 && param1 != null)
               {
                  _loc4_.id = param1;
               }
               else if(_loc4_.type == 1 && param2 != null)
               {
                  _loc4_.id = param2;
               }
               else if(_loc4_.type == 3 && param3 != null)
               {
                  _loc4_.id = param3;
               }
            }
            _loc5_++;
         }
         return true;
      }
      
      private function updatePlaneTypeVisibilities(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param1 != var_746[2] || param2 != var_746[1] || param3 != var_746[3])
         {
            var_746[2] = param1;
            var_746[1] = param2;
            var_746[3] = param3;
            var_390 = [];
            _visiblePlaneSpriteNumbers = [];
         }
      }
      
      protected function updatePlanes(param1:IRoomGeometry, param2:Boolean, param3:int) : Boolean
      {
         var _loc10_:Number = NaN;
         var _loc11_:IRoomObject = object;
         if(_loc11_ == null)
         {
            return false;
         }
         if(param1 == null)
         {
            return false;
         }
         var_2155 = var_2155 + 1;
         if(param2)
         {
            var_390 = [];
            _visiblePlaneSpriteNumbers = [];
         }
         var _loc5_:int = param3;
         var _loc6_:Array = var_390;
         if(var_390.length == 0)
         {
            _loc6_ = var_152;
         }
         var _loc14_:Boolean = false;
         var _loc7_:* = var_390.length > 0;
         var _loc8_:int = 0;
         while(0 < _loc6_.length)
         {
            var _loc9_:int = 0;
            if(_loc7_)
            {
               _loc9_ = int(_visiblePlaneSpriteNumbers[0]);
            }
            var _loc12_:IRoomObjectSprite = getSprite(0);
            if(_loc12_ != null)
            {
               var _loc4_:RoomPlane = _loc6_[0] as RoomPlane;
               if(_loc4_ != null)
               {
                  null.planeId = null.uniqueId;
                  if(null.update(param1,_loc5_))
                  {
                     if(null.visible)
                     {
                        _loc10_ = null.relativeDepth + floorRelativeDepth + 0 / 1000;
                        if(null.type != 2)
                        {
                           _loc10_ = null.relativeDepth + wallRelativeDepth + 0 / 1000;
                           if(null.leftSide.length < 1 || null.rightSide.length < 1)
                           {
                              _loc10_ += 1000 * 0.5;
                           }
                        }
                        var _loc13_:String = "plane " + 0 + " " + param1.scale;
                        updateSprite(null,null,null,_loc10_);
                     }
                     _loc14_ = true;
                  }
                  if(null.visible != (null.visible && var_746[null.type]))
                  {
                     null.visible = !null.visible;
                     _loc14_ = true;
                  }
                  if(null.visible)
                  {
                     if(!_loc7_)
                     {
                        var_390.push(null);
                        _visiblePlaneSpriteNumbers.push(0);
                     }
                  }
               }
               else
               {
                  null.planeId = 0;
                  if(null.visible)
                  {
                     null.visible = false;
                     _loc14_ = true;
                  }
               }
            }
            _loc8_++;
         }
         return _loc14_;
      }
      
      private function updateSprite(param1:IRoomObjectSprite, param2:RoomPlane, param3:String, param4:Number) : void
      {
         var _loc5_:Point = param2.offset;
         param1.offsetX = -_loc5_.x;
         param1.offsetY = -_loc5_.y;
         param1.relativeDepth = param4;
         param1.color = param2.color;
         param1.asset = getPlaneBitmap(param2,param3);
         param1.assetName = param3 + "_" + var_2155;
      }
      
      private function getPlaneBitmap(param1:RoomPlane, param2:String) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc4_:BitmapDataAsset = var_909.getAssetByName(param2) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            _loc4_ = new BitmapDataAsset(var_909.getAssetTypeDeclarationByClass(BitmapDataAsset));
            var_909.setAsset(param2,_loc4_);
         }
         var _loc3_:BitmapData = param1.cloneBitmapData();
         if(_loc3_ != null)
         {
            _loc5_ = _loc4_.content as BitmapData;
            if(_loc5_ != null)
            {
               _loc5_.dispose();
            }
            _loc4_.setUnknownContent(_loc3_);
         }
         return _loc3_;
      }
      
      protected function updatePlaneMasks(param1:String) : void
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc9_:IVector3d = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc18_:IVector3d = null;
         var _loc8_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc15_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc17_:XML = XML(param1);
         var_893.initialize(_loc17_);
         var _loc2_:RoomPlane = null;
         var _loc14_:Array = [];
         var _loc16_:Array = [];
         var _loc6_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < var_152.length)
         {
            _loc2_ = var_152[_loc10_] as RoomPlane;
            if(_loc2_ != null)
            {
               _loc2_.resetBitmapMasks();
               if(_loc2_.type == 3)
               {
                  _loc14_.push(_loc10_);
               }
            }
            _loc10_++;
         }
         _loc11_ = 0;
         while(_loc11_ < var_893.maskCount)
         {
            _loc7_ = var_893.getMaskType(_loc11_);
            _loc9_ = var_893.getMaskLocation(_loc11_);
            _loc12_ = var_893.getMaskCategory(_loc11_);
            if(_loc9_ != null)
            {
               _loc13_ = 0;
               while(_loc13_ < var_152.length)
               {
                  _loc2_ = var_152[_loc13_] as RoomPlane;
                  if(_loc2_.type == 1 || _loc2_.type == 3)
                  {
                     if(_loc2_ != null && _loc2_.location != null && _loc2_.normal != null)
                     {
                        _loc18_ = Vector3d.dif(_loc9_,_loc2_.location);
                        _loc8_ = Math.abs(Vector3d.scalarProjection(_loc18_,_loc2_.normal));
                        if(_loc8_ < 0.01)
                        {
                           if(_loc2_.leftSide != null && _loc2_.rightSide != null)
                           {
                              _loc5_ = Vector3d.scalarProjection(_loc18_,_loc2_.leftSide);
                              _loc3_ = Vector3d.scalarProjection(_loc18_,_loc2_.rightSide);
                              if(_loc2_.type == 1 || _loc2_.type == 3 && _loc12_ == "hole")
                              {
                                 _loc2_.addBitmapMask(_loc7_,_loc5_,_loc3_);
                              }
                              else if(_loc2_.type == 3)
                              {
                                 if(!_loc2_.canBeVisible)
                                 {
                                    _loc6_ = true;
                                 }
                                 _loc2_.canBeVisible = true;
                                 _loc16_.push(_loc13_);
                              }
                           }
                        }
                     }
                  }
                  _loc13_++;
               }
            }
            _loc11_++;
         }
         _loc15_ = 0;
         while(_loc15_ < _loc14_.length)
         {
            _loc4_ = int(_loc14_[_loc15_]);
            if(_loc16_.indexOf(_loc4_) < 0)
            {
               _loc2_ = var_152[_loc4_] as RoomPlane;
               _loc2_.canBeVisible = false;
               _loc6_ = true;
            }
            _loc15_++;
         }
         if(_loc6_)
         {
            var_390 = [];
            _visiblePlaneSpriteNumbers = [];
         }
      }
      
      public function get planes() : Vector.<IRoomPlane>
      {
         var _loc2_:Vector.<IRoomPlane> = new Vector.<IRoomPlane>(0);
         for each(var _loc1_ in var_390)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
   }
}


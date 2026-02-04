package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.utils.memory.SharedBitmapData;
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMask;
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCell;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellColumn;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellMatrix;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.class_3227;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.habbo.utils.Canvas;
   import com.sulake.room.object.visualization.IRoomPlane;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomPlane implements IRoomPlane
   {
      
      public static const const_949:int = 0;
      
      public static const const_84:int = 1;
      
      public static const const_75:int = 2;
      
      public static const TYPE_LANDSCAPE:int = 3;
      
      private static var var_5112:int = 1;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var _disposed:Boolean = false;
      
      private var var_3683:int = 0;
      
      private var _origin:Vector3d = null;
      
      private var var_190:Vector3d = null;
      
      private var var_428:Vector3d = null;
      
      private var var_535:Vector3d = null;
      
      private var _normal:Vector3d = null;
      
      private var _secondaryNormals:Array = [];
      
      private var var_2795:int = -1;
      
      private var var_230:int = 0;
      
      private var var_1213:Boolean = false;
      
      private var _bitmapData:BitmapData = null;
      
      private var var_3016:Boolean = true;
      
      private var _offset:Point = null;
      
      private var _relativeDepth:Number = 0;
      
      private var _color:uint = 0;
      
      private var var_1375:class_3227 = null;
      
      private var var_1391:PlaneMaskManager = null;
      
      private var var_197:String = null;
      
      private var var_3970:int = 0;
      
      private var var_4612:Number = 0;
      
      private var var_5169:Number = 0;
      
      private var var_4404:Number = 0;
      
      private var var_5150:Number = 0;
      
      private var var_365:class_55 = null;
      
      private var var_484:PlaneBitmapData = null;
      
      private var var_1702:Boolean = false;
      
      private var var_330:Array = [];
      
      private var var_566:Array = [];
      
      private var var_328:Boolean = false;
      
      private var var_105:BitmapData = null;
      
      private var var_241:BitmapData = null;
      
      private var var_1746:Array = [];
      
      private var var_2225:Array = [];
      
      private var var_309:Vector3d = null;
      
      private var var_242:Vector3d = null;
      
      private var var_175:Vector3d = null;
      
      private var var_253:Vector3d = null;
      
      private var _width:Number = 0;
      
      private var var_385:Number = 0;
      
      private var var_1697:Boolean = true;
      
      private var _extraDepth:Number = 0;
      
      private var var_3901:Boolean = false;
      
      public function RoomPlane(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:int, param6:Boolean, param7:Array, param8:int, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0)
      {
         super();
         var_3683 = param8;
         _origin = new Vector3d();
         _origin.assign(param1);
         var_190 = new Vector3d();
         var_190.assign(param2);
         var_428 = new Vector3d();
         var_428.assign(param3);
         var_535 = new Vector3d();
         var_535.assign(param4);
         _normal = Vector3d.crossProduct(var_428,var_535);
         if(_normal.length > 0)
         {
            _normal.mul(1 / _normal.length);
         }
         if(param7 != null)
         {
            var _loc14_:int = 0;
            while(0 < param7.length)
            {
               var _loc15_:IVector3d = param7[0] as IVector3d;
               if(_loc15_ != null)
               {
                  var _loc13_:Vector3d = new Vector3d();
                  _loc13_.assign(null);
                  _secondaryNormals.push(null);
               }
               _loc14_++;
            }
         }
         _offset = new Point();
         var_230 = param5;
         var_365 = new class_55();
         var_309 = new Vector3d();
         var_242 = new Vector3d();
         var_175 = new Vector3d();
         var_253 = new Vector3d();
         var_4612 = param9;
         var_5169 = param10;
         var_4404 = param11;
         var_5150 = param12;
         var_1702 = param6;
         var_3970 = var_5112++;
      }
      
      private static function blend(param1:uint, param2:uint) : uint
      {
         return Canvas.colorize(param2,param1 | 0xFF000000) & 0xFFFFFF;
      }
      
      public function set canBeVisible(param1:Boolean) : void
      {
         if(param1 != var_1697)
         {
            if(!var_1697)
            {
               resetTextureCache();
            }
            var_1697 = param1;
         }
      }
      
      public function get canBeVisible() : Boolean
      {
         return var_1697;
      }
      
      public function cloneBitmapData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         if(visible)
         {
            if(_bitmapData != null)
            {
               try
               {
                  _loc1_ = _bitmapData.clone();
               }
               catch(e:Error)
               {
                  return null;
               }
            }
         }
         return _loc1_;
      }
      
      public function get visible() : Boolean
      {
         return var_1213 && var_1697;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get relativeDepth() : Number
      {
         return _relativeDepth + _extraDepth;
      }
      
      public function set extraDepth(param1:Number) : void
      {
         this._extraDepth = param1;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get leftSide() : IVector3d
      {
         return var_428;
      }
      
      public function get rightSide() : IVector3d
      {
         return var_535;
      }
      
      public function get location() : IVector3d
      {
         return var_190;
      }
      
      public function get normal() : IVector3d
      {
         return _normal;
      }
      
      public function get hasTexture() : Boolean
      {
         return var_3016;
      }
      
      public function set hasTexture(param1:Boolean) : void
      {
         var_3016 = param1;
      }
      
      public function set rasterizer(param1:class_3227) : void
      {
         var_1375 = param1;
      }
      
      public function set maskManager(param1:PlaneMaskManager) : void
      {
         var_1391 = param1;
      }
      
      public function set id(param1:String) : void
      {
         if(param1 != var_197)
         {
            resetTextureCache();
            var_197 = param1;
         }
      }
      
      public function get uniqueId() : int
      {
         return var_3970;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneBitmapData = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(var_365 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_365.length)
            {
               _loc1_ = var_365.getWithIndex(_loc2_) as PlaneBitmapData;
               if(_loc1_ != null)
               {
                  if(_loc1_.bitmap != null)
                  {
                     _loc1_.bitmap.dispose();
                  }
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_365.dispose();
            var_365 = null;
         }
         var_484 = null;
         var_190 = null;
         _origin = null;
         var_428 = null;
         var_535 = null;
         _normal = null;
         var_1375 = null;
         var_309 = null;
         var_242 = null;
         var_175 = null;
         var_253 = null;
         var_330 = null;
         var_566 = null;
         if(var_105 != null)
         {
            var_105.dispose();
            var_105 = null;
         }
         if(var_241 != null)
         {
            var_241.dispose();
            var_241 = null;
         }
         _disposed = true;
      }
      
      public function copyBitmapData(param1:BitmapData) : BitmapData
      {
         if(visible)
         {
            if(_bitmapData != null && param1 != null)
            {
               if(_bitmapData.width == param1.width && _bitmapData.height == param1.height)
               {
                  param1.copyPixels(_bitmapData,_bitmapData.rect,ZERO_POINT);
                  return param1;
               }
            }
         }
         return null;
      }
      
      private function cacheTexture(param1:String, param2:PlaneBitmapData) : Boolean
      {
         var _loc3_:PlaneBitmapData = var_365.remove(param1) as PlaneBitmapData;
         if(_loc3_ != null)
         {
            if(param2 != null && param2.bitmap != _loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.dispose();
         }
         var_484 = param2;
         var_365.add(param1,param2);
         return true;
      }
      
      private function resetTextureCache(param1:BitmapData = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PlaneBitmapData = null;
         if(var_365 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < var_365.length)
            {
               _loc2_ = var_365.getWithIndex(_loc3_) as PlaneBitmapData;
               if(_loc2_ != null)
               {
                  if(_loc2_.bitmap != null && _loc2_.bitmap != param1)
                  {
                     _loc2_.bitmap.dispose();
                  }
                  _loc2_.dispose();
               }
               _loc3_++;
            }
            var_365.reset();
         }
         var_484 = null;
      }
      
      private function getTextureIdentifier(param1:Number) : String
      {
         if(var_1375 != null)
         {
            return var_1375.getTextureIdentifier(param1,normal);
         }
         return String(param1);
      }
      
      private function needsNewTexture(param1:IRoomGeometry, param2:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:PlaneBitmapData = var_484;
         if(_loc4_ == null)
         {
            var _loc3_:String = getTextureIdentifier(param1.scale);
            _loc4_ = var_365.getValue(null) as PlaneBitmapData;
         }
         updateMaskChangeStatus();
         if(var_1697 && (_loc4_ == null || _loc4_.timeStamp >= 0 && param2 > _loc4_.timeStamp || var_328))
         {
            return true;
         }
         return false;
      }
      
      private function getTexture(param1:IRoomGeometry, param2:int) : BitmapData
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param1 == null)
         {
            return null;
         }
         var _loc7_:PlaneBitmapData = null;
         var _loc3_:String = null;
         if(needsNewTexture(param1,param2))
         {
            _loc8_ = var_428.length * param1.scale;
            _loc9_ = var_535.length * param1.scale;
            var _loc4_:IVector3d = param1.getCoordinatePosition(_normal);
            _loc3_ = getTextureIdentifier(param1.scale);
            if(var_484 != null)
            {
               _loc7_ = var_484;
            }
            else
            {
               _loc7_ = var_365.getValue(_loc3_) as PlaneBitmapData;
            }
            var _loc6_:BitmapData = null;
            if(_loc7_ != null)
            {
               _loc6_ = _loc7_.bitmap;
            }
            if(var_1375 != null)
            {
               _loc7_ = var_1375.render(null,var_197,_loc8_,_loc9_,param1.scale,null,var_3016,var_4612,var_5169,var_4404,var_5150,param2);
               if(_loc7_ != null)
               {
               }
            }
            else
            {
               var _loc5_:BitmapData = new BitmapData(_loc8_,_loc9_,true,0xFF000000 | _color);
               _loc7_ = new PlaneBitmapData(null,-1);
            }
            if(_loc7_ != null)
            {
               updateMask(_loc7_.bitmap,param1);
               cacheTexture(_loc3_,_loc7_);
            }
         }
         else if(var_484 != null)
         {
            _loc7_ = var_484;
         }
         else
         {
            _loc3_ = getTextureIdentifier(param1.scale);
            _loc7_ = var_365.getValue(_loc3_) as PlaneBitmapData;
         }
         if(_loc7_ != null)
         {
            var_484 = _loc7_;
            return _loc7_.bitmap;
         }
         return null;
      }
      
      private function resolveMasks(param1:IRoomGeometry) : PlaneDrawingData
      {
         var _loc8_:int = 0;
         if(!var_1702)
         {
            return null;
         }
         var _loc7_:RoomPlaneBitmapMask = null;
         var _loc6_:PlaneDrawingData = new PlaneDrawingData();
         _loc8_ = 0;
         while(_loc8_ < var_330.length)
         {
            _loc7_ = var_330[_loc8_] as RoomPlaneBitmapMask;
            if(_loc7_ != null)
            {
               var _loc10_:PlaneMask = var_1391.getMask(_loc7_.type);
               if(_loc10_ != null)
               {
                  var _loc5_:String = null.getAssetName(param1.scale);
                  if(_loc5_ != null)
                  {
                     var _loc4_:IVector3d = param1.getCoordinatePosition(_normal);
                     var _loc11_:IGraphicAsset = null.getGraphicAsset(param1.scale,null);
                     if(_loc11_ != null)
                     {
                        var _loc2_:int = var_105.width * (1 - _loc7_.leftSideLoc / var_428.length);
                        var _loc3_:int = var_105.height * (1 - _loc7_.rightSideLoc / var_535.length);
                        var _loc9_:Point = new Point(0 + null.offsetX,0 + null.offsetY);
                        _loc6_.addMask(null,null,null.flipH,null.flipV);
                     }
                  }
               }
            }
            _loc8_++;
         }
         return _loc6_;
      }
      
      private function screenWidth(param1:IRoomGeometry) : int
      {
         var _loc2_:Point = param1.getScreenPoint(new Vector3d(0,0,0));
         var _loc3_:Point = param1.getScreenPoint(new Vector3d(0,1,0));
         return Math.round(var_428.length * Math.abs(_loc2_.x - _loc3_.x));
      }
      
      public function getDrawingDatas(param1:IRoomGeometry) : Array
      {
         var _loc5_:PlaneDrawingData = null;
         var _loc4_:PlaneDrawingData = null;
         var _loc11_:Array = null;
         var _loc10_:PlaneVisualizationLayer = null;
         var _loc7_:int = 0;
         var _loc2_:IVector3d = null;
         var _loc8_:PlaneMaterialCellMatrix = null;
         var _loc3_:Array = null;
         var _loc12_:String = null;
         var _loc13_:Array = [];
         if(var_1213)
         {
            _loc5_ = null;
            try
            {
               _loc5_ = resolveMasks(param1);
               _loc11_ = var_1375.getLayers(var_197);
               _loc7_ = 0;
               while(_loc7_ < _loc11_.length)
               {
                  _loc10_ = _loc11_[_loc7_] as PlaneVisualizationLayer;
                  if(_loc10_ != null)
                  {
                     if(var_3016 && _loc10_.getMaterial() != null)
                     {
                        _loc2_ = param1.getCoordinatePosition(_normal);
                        _loc8_ = _loc10_.getMaterial().getMaterialCellMatrix(_loc2_);
                        _loc4_ = new PlaneDrawingData(_loc5_,blend(_color,_loc10_.getColor()),_loc8_.isBottomAligned());
                        Randomizer.setSeed(var_3683);
                        for each(var _loc6_ in _loc8_.getColumns(screenWidth(param1)))
                        {
                           _loc3_ = [];
                           for each(var _loc9_ in _loc6_.getCells())
                           {
                              _loc12_ = _loc9_.getAssetName(_loc2_);
                              if(_loc12_ != null)
                              {
                                 _loc3_.push(_loc12_);
                              }
                           }
                           if(_loc3_.length > 0)
                           {
                              if(!_loc6_.isRepeated())
                              {
                                 _loc3_.push("");
                              }
                              _loc4_.addAssetColumn(_loc3_);
                           }
                        }
                        if(_loc4_.assetNameColumns.length > 0)
                        {
                           _loc13_.push(_loc4_);
                        }
                     }
                     else
                     {
                        _loc4_ = new PlaneDrawingData(_loc5_,blend(_color,_loc10_.getColor()));
                        _loc13_.push(_loc4_);
                     }
                  }
                  _loc7_++;
               }
            }
            catch(e:Error)
            {
               class_21.log("Error in getting RoomPlane drawing data.",e);
            }
            if(_loc13_.length == 0)
            {
               _loc13_.push(new PlaneDrawingData(_loc5_,_color));
            }
         }
         return _loc13_;
      }
      
      private function addOutlines(param1:PlaneBitmapData) : void
      {
      }
      
      public function update(param1:IRoomGeometry, param2:int) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BitmapData = null;
         if(param1 == null || _disposed)
         {
            return false;
         }
         var _loc9_:Boolean = false;
         if(var_2795 != param1.updateId)
         {
            _loc9_ = true;
         }
         if(!_loc9_ || !var_1697)
         {
            if(!visible)
            {
               return false;
            }
         }
         if(_loc9_)
         {
            var_484 = null;
            _loc3_ = 0;
            _loc3_ = Vector3d.cosAngle(param1.directionAxis,normal);
            if(_loc3_ > -0.001)
            {
               if(var_1213)
               {
                  var_1213 = false;
                  return true;
               }
               return false;
            }
            var _loc8_:int = 0;
            while(0 < _secondaryNormals.length)
            {
               _loc3_ = Vector3d.cosAngle(param1.directionAxis,_secondaryNormals[0]);
               if(_loc3_ > -0.001)
               {
                  if(var_1213)
                  {
                     var_1213 = false;
                     return true;
                  }
                  return false;
               }
               _loc8_++;
            }
            updateCorners(param1);
            var _loc4_:IVector3d = param1.getScreenPosition(_origin);
            _loc5_ = _loc4_.z;
            _loc6_ = Math.max(var_309.z,var_242.z,var_175.z,var_253.z) - _loc5_;
            if(var_230 == 2)
            {
               _loc6_ -= (var_190.z + Math.min(0,var_428.z,var_535.z)) * 8;
            }
            if(var_230 == 3)
            {
               _loc6_ += 0.02;
            }
            _relativeDepth = _loc6_;
            var_1213 = true;
            var_2795 = param1.updateId;
         }
         if(_loc9_ || needsNewTexture(param1,param2))
         {
            if(_bitmapData == null || _width != _bitmapData.width || var_385 != _bitmapData.height)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
                  _bitmapData = null;
                  if(_width < 1 || var_385 < 1)
                  {
                     return true;
                  }
               }
               else if(_width < 1 || var_385 < 1)
               {
                  return false;
               }
               try
               {
                  _bitmapData = new SharedBitmapData(_width,var_385,true,16777215,false);
               }
               catch(e:Error)
               {
                  _bitmapData = null;
                  dispose();
               }
               if(_bitmapData == null)
               {
                  return false;
               }
               _bitmapData.lock();
            }
            else
            {
               _bitmapData.lock();
               _bitmapData.fillRect(_bitmapData.rect,16777215);
            }
            Randomizer.setSeed(var_3683);
            _loc7_ = getTexture(param1,param2);
            if(_loc7_ != null)
            {
               renderTexture(param1,_loc7_);
               _bitmapData.unlock();
               return _loc7_ || _loc9_;
            }
            dispose();
            return false;
         }
         return false;
      }
      
      private function updateCorners(param1:IRoomGeometry) : void
      {
         var_309.assign(param1.getScreenPosition(var_190));
         var_242.assign(param1.getScreenPosition(Vector3d.sum(var_190,var_535)));
         var_175.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(var_190,var_428),var_535)));
         var_253.assign(param1.getScreenPosition(Vector3d.sum(var_190,var_428)));
         _offset = param1.getScreenPoint(_origin);
         var_309.x = Math.round(var_309.x);
         var_309.y = Math.round(var_309.y);
         var_242.x = Math.round(var_242.x);
         var_242.y = Math.round(var_242.y);
         var_175.x = Math.round(var_175.x);
         var_175.y = Math.round(var_175.y);
         var_253.x = Math.round(var_253.x);
         var_253.y = Math.round(var_253.y);
         _offset.x = Math.round(_offset.x);
         _offset.y = Math.round(_offset.y);
         var _loc3_:Number = Math.min(var_309.x,var_242.x,var_175.x,var_253.x);
         var _loc5_:Number = Math.max(var_309.x,var_242.x,var_175.x,var_253.x);
         var _loc2_:Number = Math.min(var_309.y,var_242.y,var_175.y,var_253.y);
         var _loc4_:Number = Math.max(var_309.y,var_242.y,var_175.y,var_253.y);
         _loc5_ -= _loc3_;
         _offset.x -= _loc3_;
         var_309.x -= _loc3_;
         var_242.x -= _loc3_;
         var_175.x -= _loc3_;
         var_253.x -= _loc3_;
         _loc4_ -= _loc2_;
         _offset.y -= _loc2_;
         var_309.y -= _loc2_;
         var_242.y -= _loc2_;
         var_175.y -= _loc2_;
         var_253.y -= _loc2_;
         _width = _loc5_;
         var_385 = _loc4_;
      }
      
      private function renderTexture(param1:IRoomGeometry, param2:BitmapData) : void
      {
         if(var_309 == null || var_242 == null || var_175 == null || var_253 == null || param2 == null || _bitmapData == null)
         {
            return;
         }
         var _loc8_:Number = var_253.x - var_175.x;
         var _loc10_:Number = var_253.y - var_175.y;
         var _loc4_:Number = var_242.x - var_175.x;
         var _loc3_:Number = var_242.y - var_175.y;
         if(var_230 == 1 || var_230 == 3)
         {
            if(Math.abs(_loc4_ - param2.width) <= 1)
            {
               _loc4_ = param2.width;
            }
            if(Math.abs(_loc3_ - param2.width) <= 1)
            {
               _loc3_ = param2.width;
            }
            if(Math.abs(_loc8_ - param2.height) <= 1)
            {
               _loc8_ = param2.height;
            }
            if(Math.abs(_loc10_ - param2.height) <= 1)
            {
               _loc10_ = param2.height;
            }
         }
         var _loc5_:Number = _loc4_ / param2.width;
         var _loc6_:Number = _loc3_ / param2.width;
         var _loc7_:Number = _loc8_ / param2.height;
         var _loc9_:Number = _loc10_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc5_;
         _loc11_.b = _loc6_;
         _loc11_.c = _loc7_;
         _loc11_.d = _loc9_;
         _loc11_.translate(var_175.x,var_175.y);
         draw(param2,_loc11_);
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc4_:int = 0;
         var _loc7_:* = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(_bitmapData != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (var_230 == 1 || var_230 == 3))
            {
               _loc4_ = 0;
               _loc7_ = 0;
               _loc3_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  param2.ty++;
               }
               _loc5_ = 0;
               while(_loc4_ < param1.width)
               {
                  _loc4_++;
                  _loc3_ += Math.abs(param2.b);
                  if(_loc3_ >= 1)
                  {
                     _bitmapData.copyPixels(param1,new Rectangle(_loc7_ + _loc6_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
                     _loc7_ = _loc4_;
                     if(param2.b > 0)
                     {
                        _loc5_++;
                     }
                     else
                     {
                        _loc5_--;
                     }
                     _loc3_ = 0;
                  }
               }
               if(_loc3_ > 0)
               {
                  _bitmapData.copyPixels(param1,new Rectangle(_loc7_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
               }
               return;
            }
            _bitmapData.draw(param1,param2,null,null,null,false);
         }
      }
      
      public function resetBitmapMasks() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_1702)
         {
            if(var_330.length == 0)
            {
               return;
            }
            var_328 = true;
            var_330 = [];
         }
      }
      
      public function addBitmapMask(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:RoomPlaneBitmapMask = null;
         var _loc4_:int = 0;
         if(var_1702)
         {
            _loc5_ = null;
            _loc4_ = 0;
            while(_loc4_ < var_330.length)
            {
               _loc5_ = var_330[_loc4_] as RoomPlaneBitmapMask;
               if(_loc5_ != null)
               {
                  if(_loc5_.type == param1 && _loc5_.leftSideLoc == param2 && _loc5_.rightSideLoc == param3)
                  {
                     return false;
                  }
               }
               _loc4_++;
            }
            _loc5_ = new RoomPlaneBitmapMask(param1,param2,param3);
            var_330.push(_loc5_);
            var_328 = true;
            return true;
         }
         return false;
      }
      
      public function resetRectangleMasks() : void
      {
         if(var_1702)
         {
            if(var_566.length == 0)
            {
               return;
            }
            var_328 = true;
            var_566 = [];
         }
      }
      
      public function addRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc6_:RoomPlaneRectangleMask = null;
         var _loc5_:int = 0;
         if(var_1702)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < var_566.length)
            {
               _loc6_ = var_566[_loc5_] as RoomPlaneRectangleMask;
               if(_loc6_ != null)
               {
                  if(_loc6_.leftSideLoc == param1 && _loc6_.rightSideLoc == param2 && _loc6_.leftSideLength == param3 && _loc6_.rightSideLength == param4)
                  {
                     return false;
                  }
               }
               _loc5_++;
            }
            _loc6_ = new RoomPlaneRectangleMask(param1,param2,param3,param4);
            var_566.push(_loc6_);
            var_328 = true;
            return true;
         }
         return false;
      }
      
      private function updateMaskChangeStatus() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:RoomPlaneBitmapMask = null;
         if(!var_328)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = true;
         var _loc7_:RoomPlaneBitmapMask = null;
         if(var_330.length == var_1746.length)
         {
            _loc4_;
            while(_loc4_ < var_330.length)
            {
               _loc7_ = var_330[_loc4_] as RoomPlaneBitmapMask;
               if(_loc7_ != null)
               {
                  _loc2_ = false;
                  _loc6_;
                  while(_loc6_ < var_1746.length)
                  {
                     _loc3_ = var_1746[_loc6_] as RoomPlaneBitmapMask;
                     if(_loc3_ != null)
                     {
                        if(_loc3_.type == _loc7_.type && _loc3_.leftSideLoc == _loc7_.leftSideLoc && _loc3_.rightSideLoc == _loc7_.rightSideLoc)
                        {
                           _loc2_ = true;
                           break;
                        }
                     }
                     _loc6_++;
                  }
                  if(!_loc2_)
                  {
                     _loc5_ = false;
                     break;
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            _loc5_ = false;
         }
         if(var_566.length > var_2225.length)
         {
            _loc5_ = false;
         }
         if(_loc5_)
         {
            var_328 = false;
         }
      }
      
      private function updateMask(param1:BitmapData, param2:IRoomGeometry) : void
      {
         if(!var_1702 || var_330.length == 0 && var_566.length == 0 && !var_328 || var_1391 == null)
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         updateMaskChangeStatus();
         var _loc12_:Number = param1.width;
         var _loc14_:Number = param1.height;
         if(var_105 == null || var_105.width != _loc12_ || var_105.height != _loc14_)
         {
            if(var_105 != null)
            {
               var_105.dispose();
               var_105 = null;
            }
            try
            {
               var_105 = new BitmapData(_loc12_,_loc14_,true,16777215);
            }
            catch(e:Error)
            {
               var_105 = null;
               return;
            }
            var_328 = true;
         }
         if(var_328)
         {
            var_1746 = [];
            var_2225 = [];
            if(var_105 != null)
            {
               var_105.fillRect(var_105.rect,16777215);
            }
            resetTextureCache(param1);
            var _loc3_:IVector3d = param2.getCoordinatePosition(_normal);
            var _loc10_:int = 0;
            var _loc11_:int = 0;
            var _loc5_:int = 0;
            while(0 < var_330.length)
            {
               var _loc13_:RoomPlaneBitmapMask = var_330[0] as RoomPlaneBitmapMask;
               if(_loc13_ != null)
               {
                  _loc10_ = var_105.width - var_105.width * null.leftSideLoc / var_428.length;
                  _loc11_ = var_105.height - var_105.height * null.rightSideLoc / var_535.length;
                  var _loc7_:String = null.type;
                  var_1391.updateMask(var_105,null,param2.scale,null,0,0);
                  var_1746.push(new RoomPlaneBitmapMask(null,null.leftSideLoc,null.rightSideLoc));
               }
               _loc5_++;
            }
            var _loc6_:int = 0;
            while(0 < var_566.length)
            {
               var _loc4_:RoomPlaneRectangleMask = var_566[0] as RoomPlaneRectangleMask;
               if(_loc4_ != null)
               {
                  _loc10_ = var_105.width - var_105.width * null.leftSideLoc / var_428.length;
                  _loc11_ = var_105.height - var_105.height * null.rightSideLoc / var_535.length;
                  var _loc9_:int = var_105.width * null.leftSideLength / var_428.length;
                  var _loc8_:int = var_105.height * null.rightSideLength / var_535.length;
                  var_105.fillRect(new Rectangle(0 - 0,0 - 0,0,0),4278190080);
                  var_2225.push(new RoomPlaneRectangleMask(null.leftSideLength,null.rightSideLoc,null.leftSideLength,null.rightSideLength));
               }
               _loc6_++;
            }
            var_328 = false;
         }
         combineTextureMask(param1,var_105);
      }
      
      private function combineTextureMask(param1:BitmapData, param2:BitmapData) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(var_241 != null && (var_241.width != param1.width || var_241.height != param1.height))
         {
            var_241.dispose();
            var_241 = null;
         }
         if(var_241 == null)
         {
            try
            {
               var_241 = new BitmapData(param1.width,param1.height,true,4294967295);
            }
            catch(e:Error)
            {
               if(var_241)
               {
                  var_241.dispose();
               }
               var_241 = null;
               return;
            }
         }
         var_241.copyChannel(param1,param1.rect,ZERO_POINT,8,1);
         var_241.draw(param2,null,null,"darken");
         param1.copyChannel(var_241,var_241.rect,ZERO_POINT,1,8);
      }
      
      public function get isHighlighter() : Boolean
      {
         return var_3901;
      }
      
      public function set isHighlighter(param1:Boolean) : void
      {
         var_3901 = param1;
      }
   }
}


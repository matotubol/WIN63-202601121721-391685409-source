package com.sulake.room.renderer
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.renderer.cache.class_3733;
   import com.sulake.room.renderer.cache.class_3810;
   import com.sulake.room.renderer.cache.class_3817;
   import com.sulake.room.renderer.cache.class_4024;
   import com.sulake.room.renderer.cache.class_4063;
   import com.sulake.room.renderer.utils.class_3782;
   import com.sulake.room.renderer.utils.class_3811;
   import com.sulake.room.renderer.utils.class_3842;
   import com.sulake.room.renderer.utils.class_4036;
   import com.sulake.room.utils.*;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [SecureSWF(rename="true")]
   public class class_3523 implements IRoomRenderingCanvas
   {
      
      private static const SKIP_FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
      
      private static const FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
      
      private static const SLOW_FRAME_UPDATE_INTERVAL:Number = 60;
      
      private static const FAST_FRAME_UPDATE_INTERVAL:Number = 50;
      
      private static const MAXIMUM_VALID_FRAME_UPDATE_INTERVAL:int = 1000;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var _container:class_2018;
      
      private var _geometry:RoomGeometry;
      
      private var _bgColor:int = 0;
      
      private var var_192:Sprite;
      
      private var var_238:Sprite;
      
      private var _display:Sprite;
      
      private var var_1149:class_55 = new class_55();
      
      private var var_1175:Point = new Point();
      
      private var _bitmapDataCache:class_4024;
      
      private var _roomObjectCache:class_4063;
      
      private var var_701:Array = [];
      
      private var var_1141:Array = [];
      
      private var var_2543:IRoomRenderingCanvasMouseListener = null;
      
      private var var_197:int;
      
      private var _eventCache:class_55 = null;
      
      private var var_3500:int = 0;
      
      private var var_1187:int;
      
      private var var_1126:int;
      
      private var var_492:int;
      
      private var var_523:int;
      
      private var var_5023:int;
      
      private var var_4425:int;
      
      private var var_2371:int = -1;
      
      private var var_5048:Number = -10000000;
      
      private var var_4581:Number = -10000000;
      
      private var var_1915:int = 0;
      
      private var var_3731:Boolean = false;
      
      private var var_1702:Boolean = false;
      
      private var var_859:ColorTransform;
      
      private var var_1131:Matrix;
      
      private var var_826:Number = 0;
      
      private var var_1371:int = 0;
      
      private var _runningSlow:Boolean = false;
      
      private var _skipObjectUpdate:Boolean = false;
      
      private var var_1984:int = 0;
      
      private var var_5347:Boolean = false;
      
      private var var_4901:Array = [];
      
      private var var_1777:int = 0;
      
      private var var_1972:Number = 0;
      
      private var var_5277:int = 0;
      
      private var var_2487:int = 0;
      
      private var var_337:Number = 1;
      
      private var var_1383:Boolean;
      
      private var var_4524:Boolean;
      
      private var var_478:TextField = new TextField();
      
      private var var_381:TextField = new TextField();
      
      public function class_3523(param1:class_2018, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         _container = param1;
         var_197 = param2;
         var_192 = new Sprite();
         var_192.mouseEnabled = false;
         _display = new Sprite();
         _display.name = "canvas";
         _display.mouseEnabled = false;
         var_192.addChild(_display);
         _display.mouseEnabled = true;
         _display.doubleClickEnabled = true;
         _display.addEventListener("click",clickHandler);
         _display.addEventListener("doubleClick",clickHandler);
         var _loc7_:TextFormat = new TextFormat();
         _loc7_.color = 16733440;
         _loc7_.font = "Verdana";
         _loc7_.size = 9;
         _loc7_.align = "right";
         var_478.defaultTextFormat = _loc7_;
         var_478.background = true;
         var_478.backgroundColor = 0;
         var_478.multiline = true;
         var_478.width = 100;
         var_478.height = 60;
         var_381.defaultTextFormat = _loc7_;
         var_381.background = false;
         var_381.backgroundColor = 0;
         var_381.multiline = true;
         var_381.width = 100;
         var_381.height = 60;
         if(!var_1702)
         {
            var_192.addChild(var_381);
         }
         _geometry = new RoomGeometry(param5,new Vector3d(-135,30,0),new Vector3d(11,11,5),new Vector3d(-135,0.5,0));
         _bitmapDataCache = new class_4024(16,32,1);
         var _loc6_:String = null;
         if(_container != null)
         {
            _loc6_ = _container.roomObjectVariableAccurateZ;
         }
         _eventCache = new class_55();
         _roomObjectCache = new class_4063(_loc6_);
         var_859 = new ColorTransform();
         var_1131 = new Matrix();
         initialize(param3,param4);
      }
      
      protected function get container() : class_2018
      {
         return _container;
      }
      
      protected function get activeSpriteCount() : int
      {
         return var_1777;
      }
      
      public function get width() : int
      {
         return var_1187 * var_337;
      }
      
      public function get height() : int
      {
         return var_1126 * var_337;
      }
      
      public function set screenOffsetX(param1:int) : void
      {
         var_1175.x -= param1 - var_492;
         var_492 = param1;
      }
      
      public function set screenOffsetY(param1:int) : void
      {
         var_1175.y -= param1 - var_523;
         var_523 = param1;
      }
      
      public function get screenOffsetX() : int
      {
         return var_492;
      }
      
      public function get screenOffsetY() : int
      {
         return var_523;
      }
      
      public function get displayObject() : DisplayObject
      {
         return var_192;
      }
      
      public function get geometry() : IRoomGeometry
      {
         return _geometry;
      }
      
      public function set mouseListener(param1:IRoomRenderingCanvasMouseListener) : void
      {
         var_2543 = param1;
      }
      
      public function set useMask(param1:Boolean) : void
      {
         if(param1 && !var_1702)
         {
            var_1702 = true;
            if(var_238 != null && !var_192.contains(var_238))
            {
               var_192.addChild(var_238);
               _display.mask = var_238;
            }
            if(var_192.contains(var_478))
            {
               var_192.removeChild(var_478);
            }
            if(var_192.contains(var_381))
            {
               var_192.removeChild(var_381);
            }
         }
         else if(!param1 && var_1702)
         {
            var_1702 = false;
            if(var_238 != null && var_192.contains(var_238))
            {
               var_192.removeChild(var_238);
               _display.mask = null;
            }
         }
      }
      
      public function getSortableSpriteList() : Vector.<RoomObjectSpriteData>
      {
         return _roomObjectCache.getSortableSpriteList();
      }
      
      public function getPlaneSortableSprites() : Array
      {
         return _roomObjectCache.getPlaneSortableSprites();
      }
      
      public function setScale(param1:Number, param2:Point = null, param3:Point = null, param4:Boolean = false) : void
      {
         if(!var_192 || !var_192.stage || !_display)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = new Point(var_192.stage.stageWidth / 2,var_192.stage.stageHeight / 2);
         }
         if(param3 == null)
         {
            param3 = param2;
         }
         param2 = _display.globalToLocal(param2);
         var_337 = param1;
         screenOffsetX = param3.x - param2.x * param1;
         screenOffsetY = param3.y - param2.y * param1;
      }
      
      public function get scale() : Number
      {
         return var_337;
      }
      
      public function takeScreenShot() : BitmapData
      {
         var_1383 = true;
         var _loc5_:Number = var_337;
         var _loc2_:int = var_492;
         var _loc1_:int = var_523;
         var _loc6_:String = _display.stage.quality;
         setScale(1);
         var_492 = 0;
         var_523 = 0;
         _display.stage.quality = "low";
         render(-1,true);
         var _loc3_:BitmapData = new BitmapData(_display.width,_display.height,true,0);
         var _loc4_:Rectangle = _display.getBounds(_display);
         _loc3_.draw(_display,new Matrix(1,0,0,1,-_loc4_.x,-_loc4_.y));
         var_1383 = false;
         setScale(_loc5_);
         var_492 = _loc2_;
         var_523 = _loc1_;
         _display.stage.quality = _loc6_;
         return _loc3_;
      }
      
      public function skipSpriteVisibilityChecking() : void
      {
         var_1383 = true;
         render(-1,true);
      }
      
      public function set fpsCounterEnabled(param1:Boolean) : void
      {
         var_4524 = param1;
         if(!param1)
         {
            var_478.text = "";
            var_381.text = "";
         }
      }
      
      public function resumeSpriteVisibilityChecking() : void
      {
         var_1383 = false;
      }
      
      public function dispose() : void
      {
         cleanSprites(0,true);
         if(_geometry != null)
         {
            _geometry.dispose();
            _geometry = null;
         }
         if(var_238 != null)
         {
            var_238 = null;
         }
         if(_bitmapDataCache != null)
         {
            _bitmapDataCache.dispose();
            _bitmapDataCache = null;
         }
         if(_roomObjectCache != null)
         {
            _roomObjectCache.dispose();
            _roomObjectCache = null;
         }
         _container = null;
         if(var_192 != null)
         {
            while(var_192.numChildren > 0)
            {
               var_192.removeChildAt(0);
            }
            var_192 = null;
         }
         _display = null;
         var_238 = null;
         var_701 = [];
         if(var_1149 != null)
         {
            var_1149.dispose();
            var_1149 = null;
         }
         var _loc1_:int = 0;
         if(var_1141 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_1141.length)
            {
               cleanSprite(var_1141[_loc1_] as class_3842,true);
               _loc1_++;
            }
            var_1141 = [];
         }
         if(_eventCache != null)
         {
            _eventCache.dispose();
            _eventCache = null;
         }
         var_2543 = null;
         var_859 = null;
         var_1131 = null;
      }
      
      public function initialize(param1:int, param2:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(var_238 != null)
         {
            var_238.graphics.clear();
         }
         else
         {
            var_238 = new Sprite();
            var_238.name = "mask";
            if(var_1702)
            {
               var_192.addChild(var_238);
               _display.mask = var_238;
            }
         }
         var_238.graphics.beginFill(0);
         var_238.graphics.drawRect(0,0,param1,param2);
         var_1187 = param1;
         var_1126 = param2;
         var_478.x = param1 - (var_478.width + 10);
         var_478.y = 220;
         var_381.x = param1 - (var_381.width + 120);
         var_381.y = param2 - (var_381.height + 40);
      }
      
      public function roomObjectRemoved(param1:String) : void
      {
         _roomObjectCache.removeObjectCache(param1);
      }
      
      public function render(param1:int, param2:Boolean = false) : void
      {
         if(param1 == -1)
         {
            param1 == var_2371 + 1;
         }
         _skipObjectUpdate = !_skipObjectUpdate;
         var _loc6_:int = 0;
         if(_container == null || _geometry == null)
         {
            return;
         }
         if(param1 == var_2371)
         {
            return;
         }
         calculateUpdateInterval(param1);
         if(_bitmapDataCache.memUsage > _bitmapDataCache.memLimit)
         {
            _bitmapDataCache.compress();
         }
         var _loc7_:int = _container.getRoomObjectCount();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:String = "";
         var _loc9_:IRoomObject = null;
         if(var_1187 != var_5023 || var_1126 != var_4425)
         {
            param2 = true;
         }
         if(_display.x != var_492 || _display.y != var_523 || _display.scaleX != var_337)
         {
            _display.x = var_492;
            _display.y = var_523;
            _display.scaleX = var_337;
            _display.scaleY = var_337;
            param2 = true;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc9_ = _container.getRoomObjectWithIndex(_loc4_);
            if(_loc9_ != null)
            {
               _loc8_ = _container.getRoomObjectIdWithIndex(_loc4_);
               _loc5_ += renderObject(_loc9_,_loc8_,param1,param2,_loc5_);
            }
            _loc4_++;
         }
         if(var_701.length > 1)
         {
            var_701.sortOn("z",16);
            var_701.reverse();
         }
         if(_loc5_ < var_701.length)
         {
            var_701.splice(_loc5_);
         }
         var _loc3_:class_3782 = null;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = var_701[_loc4_] as class_3782;
            if(_loc3_ != null)
            {
               updateSprite(_loc4_,_loc3_);
            }
            _loc4_++;
         }
         cleanSprites(_loc5_);
         var_2371 = param1;
         var_5023 = var_1187;
         var_4425 = var_1126;
      }
      
      private function calculateUpdateInterval(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         if(var_2371 > 0)
         {
            _loc5_ = param1 - var_2371;
            if(_loc5_ > 60 * 3)
            {
               class_21.log("Really slow frame update " + _loc5_ + "ms");
               var_2487 = _loc5_;
            }
            if(_loc5_ <= 1000)
            {
               var_1371 = var_1371 + 1;
               if(var_1371 == 50 + 1)
               {
                  var_826 = _loc5_;
                  var_1972 = var_5277;
               }
               else if(var_1371 > 50 + 1)
               {
                  _loc4_ = var_1371 - 50;
                  var_826 = var_826 * (_loc4_ - 1) / _loc4_ + _loc5_ / _loc4_;
                  var_1972 = var_1972 * (_loc4_ - 1) / _loc4_ + var_5277 / _loc4_;
                  if(var_1371 > 50 + 50)
                  {
                     var_1371 = 50;
                     if(!_runningSlow && var_826 > 60)
                     {
                        _runningSlow = true;
                        class_21.log("Room canvas updating really slow - now entering frame skipping mode...");
                     }
                     else if(_runningSlow && var_826 < 50)
                     {
                        _runningSlow = false;
                        class_21.log("Room canvas updating fast again - now entering normal frame mode...");
                     }
                     if(var_4524)
                     {
                        var _loc2_:String = (1000 / var_826).toFixed(1);
                        var _loc6_:String = var_1972.toFixed(1);
                        var _loc3_:uint = System.totalMemory / 1000000;
                        if(var_1972 < 1)
                        {
                           _loc6_ = "<1.0";
                        }
                        var _loc7_:String = null + " fps" + "\n" + "render " + null + "ms" + "\n" + "mem " + 0 + " MB";
                        if(var_2487 > 0)
                        {
                           _loc7_ = null + ("\nhalted " + var_2487 + "ms");
                        }
                        var_478.text = null;
                        var_381.text = null;
                     }
                     var_2487 = 0;
                  }
               }
            }
         }
      }
      
      protected function getRoomObjectCacheItem(param1:String) : class_3817
      {
         return _roomObjectCache.getObjectCache(param1);
      }
      
      private function renderObject(param1:IRoomObject, param2:String, param3:int, param4:Boolean, param5:int) : int
      {
         var _loc8_:IRoomObjectSpriteVisualization = param1.getVisualization() as IRoomObjectSpriteVisualization;
         if(_loc8_ == null)
         {
            _roomObjectCache.removeObjectCache(param2);
            return 0;
         }
         var _loc9_:class_3817 = getRoomObjectCacheItem(param2);
         _loc9_.objectId = param1.getId();
         var _loc21_:class_3733 = _loc9_.location;
         var _loc7_:class_3810 = _loc9_.sprites;
         var _loc10_:IVector3d = _loc21_.getScreenLocation(param1,_geometry);
         if(_loc10_ == null)
         {
            _roomObjectCache.removeObjectCache(param2);
            return 0;
         }
         _loc8_.update(_geometry,param3,!_loc7_.isEmpty || param4,_skipObjectUpdate && _runningSlow);
         var _loc17_:Boolean = _loc21_.locationChanged;
         if(_loc17_)
         {
            param4 = true;
         }
         if(!_loc7_.needsUpdate(_loc8_.getInstanceId(),_loc8_.getUpdateID()) && !param4)
         {
            return _loc7_.spriteCount;
         }
         var _loc12_:int = _loc8_.spriteCount;
         var _loc16_:int = _loc10_.x;
         var _loc15_:int = _loc10_.y;
         var _loc13_:Number = _loc10_.z;
         if(_loc16_ > 0)
         {
            _loc13_ += _loc16_ * 1.2e-7;
         }
         else
         {
            _loc13_ += -_loc16_ * 1.2e-7;
         }
         _loc16_ += int(var_1187 / 2);
         _loc15_ += int(var_1126 / 2);
         var _loc19_:int = 0;
         var _loc18_:class_3782 = null;
         var _loc6_:IRoomObjectSprite = null;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = _loc16_ + var_492;
         var _loc20_:int = _loc15_ + var_523;
         var _loc14_:int = 0;
         while(0 < _loc12_)
         {
            _loc6_ = _loc8_.getSprite(0);
            if(_loc6_ != null && _loc6_.visible)
            {
               var _loc11_:BitmapData = _loc6_.asset;
               if(_loc11_ != null)
               {
                  _loc22_ = _loc24_ + _loc6_.offsetX;
                  _loc23_ = _loc20_ + _loc6_.offsetY;
                  if(rectangleVisible(_loc22_,_loc23_,null.width,null.height))
                  {
                     _loc18_ = _loc7_.getSprite(_loc19_);
                     if(_loc18_ == null)
                     {
                        _loc18_ = new class_3782();
                        _loc7_.addSprite(_loc18_);
                        var_701.push(_loc18_);
                        _loc18_.name = param2;
                     }
                     _loc18_.sprite = _loc6_;
                     if(_loc6_.spriteType == RoomObjectSpriteType.AVATAR || _loc6_.spriteType == RoomObjectSpriteType.var_4695)
                     {
                        _loc18_.sprite.libraryAssetName = param1.getAvatarLibraryAssetName();
                     }
                     _loc18_.x = _loc16_ + _loc6_.offsetX;
                     _loc18_.y = _loc15_ + _loc6_.offsetY;
                     _loc18_.z = _loc13_ + _loc6_.relativeDepth + 3.7e-11 * param5;
                     _loc19_++;
                     param5++;
                  }
               }
            }
            _loc14_++;
         }
         _loc7_.setSpriteCount(_loc19_);
         return _loc19_;
      }
      
      private function rectangleVisible(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         if(var_1383)
         {
            return true;
         }
         if(var_337 != 1)
         {
            param1 = (param1 - var_492) * var_337 + var_492;
            param2 = (param2 - var_523) * var_337 + var_523;
            param3 *= var_337;
            param4 *= var_337;
         }
         if(param1 < var_1187 && param1 + param3 >= 0 && (param2 < var_1126 && param2 + param4 >= 0))
         {
            if(!var_5347)
            {
               return true;
            }
            return rectangleVisibleWithExclusion(param1,param2,param3,param4);
         }
         return false;
      }
      
      private function rectangleVisibleWithExclusion(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         if(param1 < 0)
         {
            param3 += param1;
            param1 = 0;
         }
         if(param2 < 0)
         {
            param4 += param2;
            param2 = 0;
         }
         if(param1 + param3 >= var_1187)
         {
            param3 -= var_1187 + 1 - (param1 + param3);
         }
         if(param2 + param4 >= var_1126)
         {
            param4 -= var_1126 + 1 - (param2 + param4);
         }
         for each(var _loc5_ in var_4901)
         {
            if(param1 >= _loc5_.left && param1 + param3 < _loc5_.right && param2 >= _loc5_.top && param2 + param4 < _loc5_.bottom)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function getSprite(param1:int) : class_3842
      {
         if(param1 < 0 || param1 >= var_1984)
         {
            return null;
         }
         return _display.getChildAt(param1) as class_3842;
      }
      
      private function createSprite(param1:class_3782, param2:int = -1) : void
      {
         var _loc4_:class_3842 = null;
         var _loc3_:IRoomObjectSprite = param1.sprite;
         if(var_1141.length > 0)
         {
            _loc4_ = var_1141.pop() as class_3842;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new class_3842();
         }
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.offsetRefX = _loc3_.offsetX;
         _loc4_.offsetRefY = _loc3_.offsetY;
         _loc4_.identifier = param1.name;
         _loc4_.alpha = _loc3_.alpha / 255;
         _loc4_.tag = _loc3_.tag;
         _loc4_.blendMode = _loc3_.blendMode;
         _loc4_.filters = _loc3_.filters;
         _loc4_.varyingDepth = _loc3_.varyingDepth;
         _loc4_.clickHandling = _loc3_.clickHandling;
         _loc4_.skipMouseHandling = _loc3_.skipMouseHandling;
         _loc4_.smoothing = false;
         _loc4_.pixelSnapping = "always";
         _loc4_.bitmapData = getBitmapData(_loc3_.asset,_loc3_.assetName,_loc3_.flipH,_loc3_.flipV,_loc3_.color);
         updateEnterRoomEffect(_loc4_,_loc3_,RoomEnterEffect.isVisualizationOn());
         _loc4_.alphaTolerance = _loc3_.alphaTolerance;
         if(param2 < 0 || param2 >= var_1984)
         {
            _display.addChild(_loc4_);
            var_1984 = var_1984 + 1;
         }
         else
         {
            _display.addChildAt(_loc4_,param2);
         }
         var_1777 = var_1777 + 1;
      }
      
      private function updateSprite(param1:int, param2:class_3782) : Boolean
      {
         var _loc5_:Number = NaN;
         if(param1 >= var_1984)
         {
            createSprite(param2);
            return true;
         }
         var _loc3_:IRoomObjectSprite = param2.sprite;
         var _loc6_:class_3842 = getSprite(param1);
         if(_loc6_ != null)
         {
            if(_loc6_.varyingDepth != _loc3_.varyingDepth)
            {
               if(_loc6_.varyingDepth && !_loc3_.varyingDepth)
               {
                  _display.removeChildAt(param1);
                  var_1141.push(_loc6_);
                  return updateSprite(param1,param2);
               }
               createSprite(param2,param1);
               return true;
            }
            var _loc7_:Boolean = RoomEnterEffect.isVisualizationOn();
            if(_loc6_.needsUpdate(_loc3_.instanceId,_loc3_.updateId))
            {
               if(_loc6_.alphaTolerance != _loc3_.alphaTolerance)
               {
                  _loc6_.alphaTolerance = _loc3_.alphaTolerance;
               }
               _loc5_ = _loc3_.alpha / 255;
               if(_loc6_.alpha != _loc5_)
               {
                  _loc6_.alpha = _loc5_;
               }
               if(_loc6_.identifier != param2.name)
               {
                  _loc6_.identifier = param2.name;
               }
               if(_loc6_.tag != _loc3_.tag)
               {
                  _loc6_.tag = _loc3_.tag;
               }
               if(_loc6_.varyingDepth != _loc3_.varyingDepth)
               {
                  _loc6_.varyingDepth = _loc3_.varyingDepth;
               }
               if(_loc6_.blendMode != _loc3_.blendMode)
               {
                  _loc6_.blendMode = _loc3_.blendMode;
               }
               if(_loc6_.clickHandling != _loc3_.clickHandling)
               {
                  _loc6_.clickHandling = _loc3_.clickHandling;
               }
               if(_loc6_.skipMouseHandling != _loc3_.skipMouseHandling)
               {
                  _loc6_.skipMouseHandling = _loc3_.skipMouseHandling;
               }
               _loc6_.filters = _loc3_.filters;
               var _loc4_:BitmapData = getBitmapData(_loc3_.asset,_loc3_.assetName,_loc3_.flipH,_loc3_.flipV,_loc3_.color);
               if(_loc6_.bitmapData != null)
               {
                  _loc6_.bitmapData = null;
               }
               updateEnterRoomEffect(_loc6_,_loc3_,false);
            }
            if(_loc6_.x != param2.x)
            {
               _loc6_.x = param2.x;
            }
            if(_loc6_.y != param2.y)
            {
               _loc6_.y = param2.y;
            }
            if(_loc6_.offsetRefX != _loc3_.offsetX)
            {
               _loc6_.offsetRefX = _loc3_.offsetX;
            }
            if(_loc6_.offsetRefY != _loc3_.offsetY)
            {
               _loc6_.offsetRefY = _loc3_.offsetY;
            }
            return true;
         }
         return false;
      }
      
      private function updateEnterRoomEffect(param1:class_3842, param2:IRoomObjectSprite, param3:Boolean) : void
      {
         if(!param3 || param1.bitmapData == null || param2 == null)
         {
            return;
         }
         switch(param2.spriteType)
         {
            default:
               param1.alpha = RoomEnterEffect.getDelta(0.1);
               break;
            case RoomObjectSpriteType.ROOM_PLANE:
               param1.alpha = RoomEnterEffect.getDelta(0.9);
               break;
            case RoomObjectSpriteType.AVATAR:
               param1.alpha = RoomEnterEffect.getDelta(0.5);
               break;
            case RoomObjectSpriteType.var_4695:
         }
      }
      
      private function cleanSprites(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         if(_display == null)
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc3_:class_3842 = null;
         if(param1 < var_1777 || var_1777 == 0)
         {
            _loc4_ = var_1984 - 1;
            while(_loc4_ >= param1)
            {
               _loc3_ = getSprite(_loc4_);
               cleanSprite(_loc3_,param2);
               _loc4_--;
            }
         }
         var_1777 = param1;
      }
      
      private function cleanSprite(param1:class_3842, param2:Boolean) : void
      {
         if(param1 != null)
         {
            if(!param2)
            {
               param1.bitmapData = null;
            }
            else
            {
               param1.dispose();
            }
         }
      }
      
      private function getSortableSprite(param1:int) : class_3782
      {
         if(param1 < 0 || param1 >= var_701.length)
         {
            return null;
         }
         return var_701[param1] as class_3782;
      }
      
      private function getBitmapData(param1:BitmapData, param2:String, param3:Boolean, param4:Boolean, param5:int) : BitmapData
      {
         param5 &= 16777215;
         if(!param3 && !param4 && param5 == 16777215)
         {
            return param1;
         }
         var _loc7_:class_4036 = null;
         var _loc6_:String = "";
         if((param3 || param4) && param5 != 16777215)
         {
            _loc6_ = param2 + " " + param5 + (param3 ? " FH" : "") + (param4 ? " FV" : "");
            if(param2.length > 0)
            {
               _loc7_ = _bitmapDataCache.getBitmapData(_loc6_);
            }
            if(_loc7_ == null)
            {
               _loc7_ = getColoredBitmapData(param1,param2,param5);
               if(_loc7_ != null)
               {
                  _loc7_ = getFlippedBitmapData(_loc7_,param2,true,param3,param4);
                  if(param2.length > 0)
                  {
                     _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
                  }
                  return _loc7_;
               }
               _loc7_ = getFlippedBitmapData(param1,param2,true,param3,param4);
               if(_loc7_ != null)
               {
                  _loc7_ = getColoredBitmapData(_loc7_,"",param5,true);
                  if(param2.length > 0)
                  {
                     _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
                  }
                  return _loc7_;
               }
               _loc7_ = getColoredBitmapData(param1,param2,param5,true);
               _loc7_ = getFlippedBitmapData(_loc7_,param2,true,param3,param4);
               if(param2.length > 0)
               {
                  _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
               }
            }
         }
         else if(param3 || param4)
         {
            _loc7_ = getFlippedBitmapData(param1,param2,true,param3,param4);
         }
         else
         {
            if(param5 == 16777215)
            {
               return param1;
            }
            _loc7_ = getColoredBitmapData(param1,param2,param5,true);
         }
         return _loc7_;
      }
      
      private function getFlippedBitmapData(param1:BitmapData, param2:String, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false) : class_4036
      {
         var _loc6_:String = param2 + (param4 ? " FH" : "") + (param5 ? " FV" : "");
         var _loc7_:class_4036 = null;
         if(param2.length > 0)
         {
            _loc7_ = _bitmapDataCache.getBitmapData(_loc6_);
            if(!param3)
            {
               return _loc7_;
            }
         }
         if(_loc7_ == null)
         {
            try
            {
               _loc7_ = new class_4036(param1.width,param1.height,true,16777215);
            }
            catch(e:Error)
            {
               _loc7_ = new class_4036(1,1,true,16777215);
            }
            var_1131.identity();
            if(param4)
            {
               var_1131.scale(-1,1);
               var_1131.translate(param1.width,0);
            }
            if(param5)
            {
               var_1131.scale(1,-1);
               var_1131.translate(0,param1.height);
            }
            _loc7_.draw(param1,var_1131);
            if(param2.length > 0)
            {
               _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
            }
         }
         return _loc7_;
      }
      
      private function getColoredBitmapData(param1:BitmapData, param2:String, param3:int, param4:Boolean = false) : class_4036
      {
         var _loc5_:* = 0;
         var _loc10_:* = 0;
         var _loc6_:* = 0;
         var _loc11_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc7_:String = param2 + " " + param3;
         var _loc9_:class_4036 = null;
         if(param2.length > 0)
         {
            _loc9_ = _bitmapDataCache.getBitmapData(_loc7_);
            if(!param4)
            {
               return _loc9_;
            }
         }
         if(_loc9_ == null)
         {
            _loc5_ = param3 >> 16 & 0xFF;
            _loc10_ = param3 >> 8 & 0xFF;
            _loc6_ = param3 & 0xFF;
            _loc11_ = _loc5_ / 255;
            _loc8_ = _loc10_ / 255;
            _loc12_ = _loc6_ / 255;
            try
            {
               _loc9_ = new class_4036(param1.width,param1.height,true,16777215);
               _loc9_.copyPixels(param1,param1.rect,ZERO_POINT);
            }
            catch(e:Error)
            {
               _loc9_ = new class_4036(1,1,true,16777215);
            }
            var_859.redMultiplier = _loc11_;
            var_859.greenMultiplier = _loc8_;
            var_859.blueMultiplier = _loc12_;
            _loc9_.colorTransform(_loc9_.rect,var_859);
            if(param2.length > 0)
            {
               _bitmapDataCache.addBitmapData(_loc7_,_loc9_);
            }
         }
         return _loc9_;
      }
      
      protected function getObjectId(param1:class_3842) : String
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            return param1.identifier;
         }
         return "";
      }
      
      public function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         param1 -= var_492;
         param2 -= var_523;
         var_1175.x = param1 / var_337;
         var_1175.y = param2 / var_337;
         if(var_1915 > 0 && param3 == "mouseMove")
         {
            return var_3731;
         }
         var_3731 = checkMouseHits(param1 / var_337,param2 / var_337,param3,param4,param5,param6,param7);
         var_1915 = var_1915 + 1;
         return var_3731;
      }
      
      protected function createMouseEvent(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : RoomSpriteMouseEvent
      {
         var _loc13_:Number = param1 - var_1187 / 2;
         var _loc14_:Number = param2 - var_1126 / 2;
         var _loc11_:String = "canvas_" + var_197;
         var _loc12_:RoomSpriteMouseEvent = null;
         return new RoomSpriteMouseEvent(param5,_loc11_ + "_" + var_3500,_loc11_,param6,_loc13_,_loc14_,param3,param4,param8,param7,param9,param10);
      }
      
      private function checkMouseClickHits(param1:Number, param2:Number, param3:Boolean, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         var _loc15_:String = "";
         var _loc12_:class_3842 = null;
         var _loc14_:RoomSpriteMouseEvent = null;
         var _loc9_:String = "click";
         if(param3)
         {
            _loc9_ = "doubleClick";
         }
         var _loc13_:Array = [];
         var _loc8_:int = 0;
         _loc8_ = activeSpriteCount - 1;
         while(_loc8_ >= 0)
         {
            _loc12_ = getSprite(_loc8_);
            if(_loc12_ != null && _loc12_.clickHandling)
            {
               if(_loc12_.hitTest(param1 - _loc12_.x,param2 - _loc12_.y))
               {
                  _loc15_ = getObjectId(_loc12_);
                  if(_loc13_.indexOf(_loc15_) < 0)
                  {
                     _loc10_ = _loc12_.tag;
                     _loc14_ = createMouseEvent(param1,param2,param1 - _loc12_.x,param2 - _loc12_.y,_loc9_,_loc10_,param4,param5,param6,param7);
                     bufferMouseEvent(_loc14_,_loc15_);
                     _loc13_.push(_loc15_);
                  }
               }
               _loc11_ = true;
            }
            _loc8_--;
         }
         processMouseEvents();
         return _loc11_;
      }
      
      private function checkMouseHits(param1:int, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc12_:String = null;
         var _loc16_:String = null;
         var _loc11_:int = 0;
         var _loc13_:Boolean = false;
         var _loc18_:String = "";
         var _loc14_:class_3842 = null;
         var _loc17_:RoomSpriteMouseEvent = null;
         var _loc15_:Array = [];
         var _loc8_:class_3811 = null;
         var _loc10_:int = 0;
         _loc10_ = activeSpriteCount - 1;
         while(_loc10_ >= 0)
         {
            _loc14_ = getSprite(_loc10_) as class_3842;
            if(_loc14_ != null && _loc14_.hitTestPoint(param1 - _loc14_.x,param2 - _loc14_.y))
            {
               if(!_loc14_.skipMouseHandling)
               {
                  if(!(_loc14_.clickHandling && (param3 == "click" || param3 == "doubleClick")))
                  {
                     _loc18_ = getObjectId(_loc14_);
                     if(_loc15_.indexOf(_loc18_) < 0)
                     {
                        _loc12_ = _loc14_.tag;
                        _loc8_ = var_1149.getValue(_loc18_) as class_3811;
                        if(_loc8_ != null)
                        {
                           if(_loc8_.spriteTag != _loc12_)
                           {
                              _loc17_ = createMouseEvent(0,0,0,0,"rollOut",_loc8_.spriteTag,param4,param5,param6,param7);
                              bufferMouseEvent(_loc17_,_loc18_);
                           }
                        }
                        if(param3 == "mouseMove" && (_loc8_ == null || _loc8_.spriteTag != _loc12_))
                        {
                           _loc17_ = createMouseEvent(param1,param2,param1 - _loc14_.x,param2 - _loc14_.y,"rollOver",_loc12_,param4,param5,param6,param7);
                        }
                        else
                        {
                           _loc17_ = createMouseEvent(param1,param2,param1 - _loc14_.x,param2 - _loc14_.y,param3,_loc12_,param4,param5,param6,param7);
                           _loc17_.spriteOffsetX = _loc14_.offsetRefX;
                           _loc17_.spriteOffsetY = _loc14_.offsetRefY;
                        }
                        if(_loc8_ == null)
                        {
                           _loc8_ = new class_3811();
                           _loc8_.objectId = _loc18_;
                           var_1149.add(_loc18_,_loc8_);
                        }
                        _loc8_.spriteTag = _loc12_;
                        if(param3 != "mouseMove" || param1 != var_5048 || param2 != var_4581)
                        {
                           bufferMouseEvent(_loc17_,_loc18_);
                        }
                        _loc15_.push(_loc18_);
                     }
                     _loc13_ = true;
                  }
               }
            }
            _loc10_--;
         }
         var _loc9_:Array = var_1149.getKeys();
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc16_ = _loc9_[_loc10_] as String;
            _loc11_ = int(_loc15_.indexOf(_loc16_));
            if(_loc11_ >= 0)
            {
               _loc9_[_loc10_] = null;
            }
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc18_ = _loc9_[_loc10_] as String;
            if(_loc18_ != null)
            {
               _loc8_ = var_1149.remove(_loc18_) as class_3811;
               if(_loc8_ != null)
               {
                  _loc17_ = createMouseEvent(0,0,0,0,"rollOut",_loc8_.spriteTag,param4,param5,param6,param7);
                  bufferMouseEvent(_loc17_,_loc18_);
               }
            }
            _loc10_++;
         }
         processMouseEvents();
         var_5048 = param1;
         var_4581 = param2;
         return _loc13_;
      }
      
      protected function bufferMouseEvent(param1:RoomSpriteMouseEvent, param2:String) : void
      {
         if(_eventCache != null && param1 != null)
         {
            _eventCache.remove(param2);
            _eventCache.add(param2,param1);
         }
      }
      
      protected function processMouseEvents() : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:RoomSpriteMouseEvent = null;
         var _loc6_:IRoomObject = null;
         var _loc1_:IRoomObjectMouseHandler = null;
         if(_container == null || _eventCache == null)
         {
            return;
         }
         var _loc2_:int = int(_eventCache.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_eventCache == null)
            {
               return;
            }
            _loc5_ = _eventCache.getKey(_loc3_);
            _loc4_ = _eventCache.getWithIndex(_loc3_);
            if(_loc5_ != null && _loc4_ != null)
            {
               _loc6_ = _container.getRoomObject(_loc5_);
               if(_loc6_ != null)
               {
                  if(var_2543 != null)
                  {
                     var_2543.processRoomCanvasMouseEvent(_loc4_,_loc6_,geometry);
                  }
                  else
                  {
                     _loc1_ = _loc6_.getMouseHandler();
                     if(_loc1_ != null)
                     {
                        _loc1_.mouseEvent(_loc4_,_geometry);
                     }
                  }
               }
            }
            _loc3_++;
         }
         if(_eventCache)
         {
            _eventCache.reset();
         }
      }
      
      public function update() : void
      {
         if(var_1915 == 0)
         {
            checkMouseHits(var_1175.x,var_1175.y,"mouseMove");
         }
         var_1915 = 0;
         var_3500 = var_3500 + 1;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = false;
         if(param1.type == "click" || param1.type == "doubleClick")
         {
            _loc2_ = param1.type == "doubleClick";
            checkMouseClickHits(param1.localX,param1.localY,_loc2_,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
         }
      }
      
      public function getId() : int
      {
         return var_197;
      }
   }
}


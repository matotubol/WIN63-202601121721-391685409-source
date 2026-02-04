package com.sulake.habbo.window.utils.floorplaneditor
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.room.utils.class_3675;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class HeightMapEditor
   {
      
      public static const LEVELS:int = 30;
      
      public static var floor_editor_tile_base:Class = class_4069;
      
      public static var floor_editor_tile_entry:Class = floor_editor_tile_entry_png$e5a37fbe078924e3820df4c4479fb8c51602710886;
      
      public static var floor_editor_tile_base_large:Class = floor_editor_tile_base_large_png$a1bae19a7c53ecd7a633ac3514013613856600807;
      
      public static var floor_editor_tile_entry_large:Class = floor_editor_tile_entry_large_png$3003d167d7869e06425601ed0069482f584956522;
      
      private var _bcFloorPlanEditor:BCFloorPlanEditor;
      
      private var _drawing:Boolean = false;
      
      private var _drawingHeight:int = 0;
      
      private var _tileImageBase:BitmapData;
      
      private var _tileImageEntry:BitmapData;
      
      private var _tileImageBaseLarge:BitmapData;
      
      private var _tileImageEntryLarge:BitmapData;
      
      private var _heigthColorMap:Vector.<Array>;
      
      private var _occupiedHeigthColorMap:Vector.<Array>;
      
      private var _bitmapElement:class_2251;
      
      private var _lastDrawAddress:Point;
      
      private var _floorPlan:FloorPlanCache;
      
      private var _colorPickMode:Boolean = false;
      
      private var _zoomLevel:int = 1;
      
      private var _coloredTiles:Dictionary;
      
      private var _coloredOccupiedTiles:Dictionary;
      
      private var _coloredTilesLarge:Dictionary;
      
      private var _coloredOccupiedTilesLarge:Dictionary;
      
      private var _selectionStartPoint:Point;
      
      private var _isRectSelect:Boolean = false;
      
      public function HeightMapEditor(param1:BCFloorPlanEditor)
      {
         var _loc3_:Number = NaN;
         _lastDrawAddress = new Point(-1000,-1000);
         _selectionStartPoint = new Point(-1000,-1000);
         super();
         _bcFloorPlanEditor = param1;
         _bcFloorPlanEditor.heightMapBitmapElement.procedure = editorWindowProcedure;
         _floorPlan = param1.floorPlanCache;
         _tileImageBase = Bitmap(new floor_editor_tile_base()).bitmapData;
         _tileImageEntry = Bitmap(new floor_editor_tile_entry()).bitmapData;
         _tileImageBaseLarge = Bitmap(new floor_editor_tile_base_large()).bitmapData;
         _tileImageEntryLarge = Bitmap(new floor_editor_tile_entry_large()).bitmapData;
         _heigthColorMap = new Vector.<Array>();
         _occupiedHeigthColorMap = new Vector.<Array>();
         _coloredOccupiedTiles = new Dictionary();
         _coloredTiles = new Dictionary();
         _coloredTilesLarge = new Dictionary();
         _coloredOccupiedTilesLarge = new Dictionary();
         var _loc2_:int = 0;
         while(true)
         {
            _loc3_ = 0.6 - 0 / 30 * 0.85;
            if(_loc3_ < 0)
            {
               _loc3_ = 1 + _loc3_;
            }
            _heigthColorMap.push(hslToRgb(_loc3_,1,0.5));
            _occupiedHeigthColorMap.push(hslToRgb(_loc3_,0.33,0.4));
            _loc2_++;
         }
      }
      
      public static function hslToRgb(param1:Number, param2:Number, param3:Number) : Array
      {
         var g:Number;
         var b:Number;
         var r:Number;
         var hue2rgb:*;
         var q:Number;
         var p:Number;
         var h:Number = param1;
         var s:Number = param2;
         var l:Number = param3;
         if(s == 0)
         {
            r = g = b = l;
         }
         else
         {
            hue2rgb = function(param1:Number, param2:Number, param3:Number):Number
            {
               if(param3 < 0)
               {
                  param3 += 1;
               }
               if(param3 > 1)
               {
                  param3 -= 1;
               }
               if(param3 < 0.16666666666666666)
               {
                  return param1 + (param2 - param1) * 6 * param3;
               }
               if(param3 < 0.5)
               {
                  return param2;
               }
               if(param3 < 0.6666666666666666)
               {
                  return param1 + (param2 - param1) * (0.6666666666666666 - param3) * 6;
               }
               return param1;
            };
            q = l < 0.5 ? l * (1 + s) : l + s - l * s;
            p = 2 * l - q;
            r = hue2rgb(p,q,h + 0.3333333333333333);
            g = hue2rgb(p,q,h);
            b = hue2rgb(p,q,h - 0.3333333333333333);
         }
         return [r,g,b];
      }
      
      public function get heigthColorMap() : Vector.<Array>
      {
         return _heigthColorMap;
      }
      
      public function set drawingHeight(param1:int) : void
      {
         _drawingHeight = Math.min(30,Math.max(0,param1));
      }
      
      public function get drawingHeight() : int
      {
         return _drawingHeight;
      }
      
      public function set drawing(param1:Boolean) : void
      {
         _drawing = param1;
      }
      
      public function refreshFromCache() : void
      {
         _bitmapElement = _bcFloorPlanEditor.heightMapBitmapElement;
         _lastDrawAddress = new Point(-1000,-1000);
         updateView();
      }
      
      private function editorWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:Point = null;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:Object = null;
         if(_colorPickMode)
         {
            if(param1.type == "WME_CLICK")
            {
               _loc10_ = _bcFloorPlanEditor.heightMapBitmapElement.width / 2 - _bcFloorPlanEditor.heightMapBitmapElement.bitmap.width / 2;
               _loc9_ = _bcFloorPlanEditor.heightMapBitmapElement.height / 2 - _bcFloorPlanEditor.heightMapBitmapElement.bitmap.height / 2;
               _loc3_ = transformFromScreenSpace(WindowMouseEvent(param1).localX - _loc10_,WindowMouseEvent(param1).localY - _loc9_);
               _drawingHeight = _bcFloorPlanEditor.floorPlanCache.getHeightAt(_loc3_.x,_loc3_.y);
               _bcFloorPlanEditor.updateColorSliderTrack(_drawingHeight);
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE" || param1.type == "WME_DOWN" || _drawing && param1.type == "WME_MOVE")
         {
            _loc10_ = _bcFloorPlanEditor.heightMapBitmapElement.width / 2 - _bcFloorPlanEditor.heightMapBitmapElement.bitmap.width / 2;
            _loc9_ = _bcFloorPlanEditor.heightMapBitmapElement.height / 2 - _bcFloorPlanEditor.heightMapBitmapElement.bitmap.height / 2;
            _loc3_ = transformFromScreenSpace(WindowMouseEvent(param1).localX - _loc10_,WindowMouseEvent(param1).localY - _loc9_);
            if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
            {
               _drawing = false;
               if(_isRectSelect)
               {
                  _isRectSelect = false;
                  _bcFloorPlanEditor.floorPlanCache.submitTemporaryCache();
               }
            }
            if(param1.type == "WME_DOWN")
            {
               _drawing = true;
               _lastDrawAddress = new Point(-1000,-1000);
               if(WindowMouseEvent(param1).shiftKey)
               {
                  _isRectSelect = true;
                  _selectionStartPoint = _loc3_;
                  _bcFloorPlanEditor.floorPlanCache.initTemporaryCache();
               }
               applyDraw(_loc3_.x,_loc3_.y);
               updateView();
               _lastDrawAddress = _loc3_;
            }
            if(_drawing && param1.type == "WME_MOVE")
            {
               if(_isRectSelect)
               {
                  _loc14_ = Math.min(_selectionStartPoint.x,_loc3_.x);
                  _loc8_ = Math.max(_selectionStartPoint.x,_loc3_.x);
                  _loc13_ = Math.min(_selectionStartPoint.y,_loc3_.y);
                  _loc7_ = Math.max(_selectionStartPoint.y,_loc3_.y);
                  _loc6_ = _bcFloorPlanEditor.floorPlanCache.attemptExpandColumns(_loc8_);
                  _loc4_ = _bcFloorPlanEditor.floorPlanCache.attemptExpandRows(_loc7_);
                  if(!_loc6_ && !_loc4_)
                  {
                     return;
                  }
                  while(_loc7_ >= _loc13_ && !_loc4_)
                  {
                     _loc7_ -= 1;
                     _loc4_ = _bcFloorPlanEditor.floorPlanCache.attemptExpandRows(_loc7_);
                  }
                  while(_loc8_ >= _loc14_ && !_loc6_)
                  {
                     _loc8_ -= 1;
                     _loc6_ = _bcFloorPlanEditor.floorPlanCache.attemptExpandColumns(_loc8_);
                  }
                  if(!_loc6_ || !_loc4_)
                  {
                     return;
                  }
                  _bcFloorPlanEditor.floorPlanCache.clearTemporaryCache();
                  _bcFloorPlanEditor.floorPlanCache.attemptExpandRows(_loc7_);
                  _bcFloorPlanEditor.floorPlanCache.attemptExpandColumns(_loc8_);
                  _loc11_ = _loc14_;
                  while(_loc11_ <= _loc8_)
                  {
                     _loc12_ = _loc13_;
                     while(_loc12_ <= _loc7_)
                     {
                        applyDraw(_loc11_,_loc12_);
                        _loc12_++;
                     }
                     _loc11_++;
                  }
                  updateView();
               }
               else if(param1.type == "WME_MOVE")
               {
                  if(_lastDrawAddress.x != _loc3_.x || _lastDrawAddress.y != _loc3_.y)
                  {
                     applyDraw(_loc3_.x,_loc3_.y);
                  }
                  _loc5_ = interpolateBetweenLastPointAndDrawPoint(_loc3_);
                  if(Math.abs(_loc5_.x) > 0 || Math.abs(_loc5_.y) > 0)
                  {
                     updateView();
                  }
               }
               _lastDrawAddress = _loc3_;
            }
         }
      }
      
      private function interpolateBetweenLastPointAndDrawPoint(param1:Point) : Object
      {
         if(_lastDrawAddress.x == -1000 && _lastDrawAddress.y == -1000)
         {
            _lastDrawAddress.x = param1.x;
            _lastDrawAddress.y = param1.y;
         }
         var _loc3_:int = param1.x - _lastDrawAddress.x;
         var _loc4_:int = param1.y - _lastDrawAddress.y;
         var _loc2_:Array = class_3675.interpolationPoints(_lastDrawAddress.x,_lastDrawAddress.y,param1.x,param1.y);
         for each(var _loc5_ in _loc2_)
         {
            if(!(_lastDrawAddress.x == _loc5_.x && _lastDrawAddress.y == _loc5_.y || param1.x == _loc5_.x && param1.y == _loc5_.y))
            {
               applyDraw(_loc5_.x,_loc5_.y);
            }
         }
         return {
            "x":_loc3_,
            "y":_loc4_
         };
      }
      
      private function applyDraw(param1:int, param2:int) : void
      {
         switch(_bcFloorPlanEditor.drawMode)
         {
            case _bcFloorPlanEditor.drawModes[0]:
               _bcFloorPlanEditor.floorPlanCache.setHeightAt(param1,param2,_drawingHeight);
               break;
            case _bcFloorPlanEditor.drawModes[1]:
               _bcFloorPlanEditor.floorPlanCache.setHeightAt(param1,param2,-1);
               break;
            case _bcFloorPlanEditor.drawModes[2]:
               var _loc3_:int = _bcFloorPlanEditor.floorPlanCache.getHeightAt(param1,param2);
               _bcFloorPlanEditor.floorPlanCache.setHeightAt(param1,param2,Math.min(30 - 1,0 + 1));
               break;
            case _bcFloorPlanEditor.drawModes[3]:
               _loc3_ = _bcFloorPlanEditor.floorPlanCache.getHeightAt(param1,param2);
               _bcFloorPlanEditor.floorPlanCache.setHeightAt(param1,param2,Math.max(0,0 - 1));
               break;
            case _bcFloorPlanEditor.drawModes[4]:
               _loc3_ = _bcFloorPlanEditor.floorPlanCache.getHeightAt(param1,param2);
               _bcFloorPlanEditor.floorPlanCache.entryPoint = new Point(param1,param2);
         }
      }
      
      private function updateView() : void
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:BitmapData = null;
         var _loc6_:Point = null;
         var _loc13_:int = 0;
         var _loc7_:Array = [];
         var _loc9_:int = 2147483647;
         var _loc8_:int = 2147483647;
         var _loc2_:int = -2147483648;
         var _loc1_:int = -2147483648;
         _loc12_ = 0;
         while(_loc12_ < _floorPlan.floorHeight)
         {
            _loc11_ = 0;
            while(_loc11_ < _floorPlan.floorWidth)
            {
               _loc6_ = transformToScreenSpace(_loc11_,_loc12_);
               _loc9_ = Math.min(_loc9_,_loc6_.x);
               _loc8_ = Math.min(_loc8_,_loc6_.y);
               _loc2_ = Math.max(_loc2_,_loc6_.x);
               _loc1_ = Math.max(_loc1_,_loc6_.y);
               if(_floorPlan.isEntryPoint(_loc11_,_loc12_))
               {
                  _loc5_ = getEntryTile();
                  _loc7_.push({
                     "point":_loc6_,
                     "image":_loc5_
                  });
               }
               else
               {
                  _loc13_ = Math.min(_floorPlan.getHeightAt(_loc11_,_loc12_),30 - 1);
                  if(_loc13_ >= 0)
                  {
                     _loc5_ = getColoredTile(_loc13_,_floorPlan.isTileReserved(_loc11_,_loc12_));
                     _loc7_.push({
                        "point":_loc6_,
                        "image":_loc5_
                     });
                  }
               }
               _loc11_++;
            }
            _loc12_++;
         }
         var _loc10_:BitmapData = new BitmapData(_loc2_ - _loc9_ + 18,_loc1_ - _loc8_ + 27,false,0);
         var _loc3_:Point = new Point(-_loc9_,-_loc8_);
         for each(var _loc4_ in _loc7_)
         {
            _loc10_.copyPixels(_loc4_.image,_loc4_.image.rect,_loc4_.point.add(_loc3_));
         }
         _bcFloorPlanEditor.heightMapBitmapElement.bitmap = _loc10_;
      }
      
      private function getColoredTile(param1:int, param2:Boolean) : BitmapData
      {
         var _loc4_:Dictionary = param2 ? (_zoomLevel == 1 ? _coloredOccupiedTiles : _coloredOccupiedTilesLarge) : (_zoomLevel == 1 ? _coloredTiles : _coloredTilesLarge);
         if(_loc4_[param1] != null)
         {
            return _loc4_[param1];
         }
         var _loc5_:Array = param2 ? _occupiedHeigthColorMap[param1] : _heigthColorMap[param1];
         var _loc3_:BitmapData = (_zoomLevel == 1 ? _tileImageBase : _tileImageBaseLarge).clone();
         _loc3_.colorTransform(_loc3_.rect,new ColorTransform(_loc5_[0],_loc5_[1],_loc5_[2]));
         _loc4_[param1] = _loc3_;
         return _loc3_;
      }
      
      private function getEntryTile() : BitmapData
      {
         return _zoomLevel == 1 ? _tileImageEntry : _tileImageEntryLarge;
      }
      
      private function transformFromScreenSpace(param1:int, param2:int) : Point
      {
         var _loc3_:Number = param1 / 16 / _zoomLevel;
         var _loc5_:Number = param2 / 8 / _zoomLevel;
         var _loc7_:Number = _floorPlan.floorHeight;
         var _loc4_:int = _loc5_ + (_loc3_ - _loc7_ / 2);
         var _loc6_:int = _loc5_ - (_loc3_ - _loc7_ / 2);
         return new Point(_loc4_,_loc6_);
      }
      
      private function transformToScreenSpace(param1:int, param2:int) : Point
      {
         return new Point(_zoomLevel * 8 * (param1 - param2),_zoomLevel * 4 * (param1 + param2));
      }
      
      public function get colorPickMode() : Boolean
      {
         return _colorPickMode;
      }
      
      public function set colorPickMode(param1:Boolean) : void
      {
         _colorPickMode = param1;
      }
      
      public function get zoomLevel() : int
      {
         return _zoomLevel;
      }
      
      public function set zoomLevel(param1:int) : void
      {
         if(param1 < 1 || param1 > 2)
         {
            return;
         }
         _zoomLevel = param1;
      }
   }
}


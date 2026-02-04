package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.NeighborhoodFloor;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.SpiralUtils;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.room.utils.class_3675;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class class_3792 extends DefaultSelectorType implements class_31
   {
      
      public static var floor_editor_tile_base:Class = class_4102;
      
      public static var floor_editor_tile_entry:Class = floor_editor_tile_entry_png$038c432f492d67bb3ee6d359a8edffec1415775302;
      
      public static var floor_editor_border_N:Class = fp_border_N_png$3741c8d9c5dc5d81bc3cc08dff5e8e42261949270;
      
      public static var floor_editor_border_NE:Class = class_4103;
      
      public static var floor_editor_border_E:Class = fp_border_E_png$fca4ca04d4eb3ecfad21ff3053c625791880778973;
      
      public static var floor_editor_border_SE:Class = class_4105;
      
      public static var floor_editor_border_S:Class = fp_border_S_png$e9476ff94390b786da2e04df290391aa254259667;
      
      public static var floor_editor_border_SW:Class = class_4106;
      
      public static var floor_editor_border_W:Class = fp_border_W_png$55458a484b99bb2622ada3504ccbd43e253744111;
      
      public static var floor_editor_border_NW:Class = class_4104;
      
      private static var FLOOR_EDITOR_BORDERS:Array = [Bitmap(new floor_editor_border_N()).bitmapData,Bitmap(new floor_editor_border_NE()).bitmapData,Bitmap(new floor_editor_border_E()).bitmapData,Bitmap(new floor_editor_border_SE()).bitmapData,Bitmap(new floor_editor_border_S()).bitmapData,Bitmap(new floor_editor_border_SW()).bitmapData,Bitmap(new floor_editor_border_W()).bitmapData,Bitmap(new floor_editor_border_NW()).bitmapData];
      
      private static var TAKEN_TILE_RGB:Array = [0,0.4,0.8];
      
      private static var UNTAKEN_TILE_RGB:Array = [0.2,0.2,0.2];
      
      private static var _drawModes:Array = ["add_tile","remove_tile","set_root_tile"];
      
      private var _drawMode:String = "add_tile";
      
      private var _tileImageBase:BitmapData = Bitmap(new floor_editor_tile_base()).bitmapData;
      
      private var _tileImageEntry:BitmapData = Bitmap(new floor_editor_tile_entry()).bitmapData;
      
      private var _tileTaken:BitmapData;
      
      private var _tileUntaken:BitmapData;
      
      private var _drawing:Boolean = false;
      
      private var _lastDrawAddress:Point = new Point(-1000,-1000);
      
      private var var_443:Point;
      
      private var _floor:NeighborhoodFloor;
      
      private var _selectionStartPoint:Point = new Point(-1000,-1000);
      
      private var _isRectSelect:Boolean;
      
      private var var_2419:Boolean;
      
      private var _cont:class_1812;
      
      private var var_3220:String = "";
      
      private var var_3186:String = "";
      
      public function class_3792()
      {
         super();
      }
      
      private static function transformFromScreenSpace(param1:int, param2:int) : Point
      {
         var _loc3_:Number = param1 / 16;
         var _loc5_:Number = param2 / 8;
         var _loc4_:int = _loc5_ + _loc3_ - 2;
         var _loc6_:int = _loc5_ - _loc3_ - 1;
         return new Point(_loc4_,_loc6_);
      }
      
      private static function allowDraw(param1:int, param2:int) : Boolean
      {
         return param1 >= 0 && param2 >= 0 && param1 < NeighborhoodFloor.var_379 && param2 < NeighborhoodFloor.var_379;
      }
      
      private static function transformToScreenSpace(param1:int, param2:int) : Point
      {
         return new Point(8 * (param1 - param2 + 1),4 * (param1 + param2 + 1));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         floorBitmap.procedure = editorWindowProcedure;
         neighborhoodCont.procedure = selectionProcedure;
         setRootTile(0,0);
         var _loc4_:Array = SpiralUtils.parseSpiralVector([],NeighborhoodFloor.RADIUS);
         _floor = new NeighborhoodFloor(_loc4_);
         param3.context.registerUpdateReceiver(this,0);
         _tileTaken = _tileImageBase.clone();
         _tileTaken.colorTransform(_tileImageBase.rect,new ColorTransform(TAKEN_TILE_RGB[0],TAKEN_TILE_RGB[1],TAKEN_TILE_RGB[2]));
         _tileUntaken = _tileImageBase.clone();
         _tileUntaken.colorTransform(_tileImageBase.rect,new ColorTransform(UNTAKEN_TILE_RGB[0],UNTAKEN_TILE_RGB[1],UNTAKEN_TILE_RGB[2]));
         getRootXInput().addEventListener("WE_CHANGE",onRootInputChange);
         getRootYInput().addEventListener("WE_CHANGE",onRootInputChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         _drawing = false;
         _lastDrawAddress = new Point(1000,1000);
         var_2419 = param1.getBoolean(0);
         setRootTile(param1.intParams[1],param1.intParams[2]);
         setMode("add_tile");
         var _loc2_:Array = SpiralUtils.parseSpiralVector(param1.intParams.slice(3),NeighborhoodFloor.RADIUS);
         _floor = new NeighborhoodFloor(_loc2_);
         updateView();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2419 ? 1 : 0);
         _loc1_.push(var_443.x);
         _loc1_.push(var_443.y);
         return _loc1_.concat(SpiralUtils.createSpiralVector(_floor.floorPlanCache,NeighborhoodFloor.RADIUS));
      }
      
      private function selectionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_drawModes.indexOf(param2.name) != -1)
            {
               setMode(param2.name);
            }
         }
      }
      
      private function setMode(param1:String) : void
      {
         _drawMode = param1;
         for each(var _loc3_ in _drawModes)
         {
            var _loc2_:InteractiveController = InteractiveController(_cont.findChildByName(_loc3_));
            if(_drawMode != _loc3_)
            {
               null.state &= ~4;
            }
         }
      }
      
      private function editorWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:Object = null;
         if(param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE" && param1.type != "WME_DOWN" && !(_drawing && param1.type == "WME_MOVE"))
         {
            return;
         }
         var _loc7_:int = floorBitmap.width / 2;
         var _loc6_:int = floorBitmap.height / 2 - floorBitmap.bitmap.height / 2;
         var _loc3_:Point = transformFromScreenSpace(WindowMouseEvent(param1).localX - _loc7_,WindowMouseEvent(param1).localY - _loc6_);
         if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            _drawing = false;
            if(_isRectSelect)
            {
               _isRectSelect = false;
               _floor.submitTemporaryCache();
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
               _floor.initTemporaryCache();
            }
            applyDraw(_loc3_.x,_loc3_.y);
            updateView();
            _lastDrawAddress = _loc3_;
         }
         if(_drawing && param1.type == "WME_MOVE")
         {
            if(_isRectSelect && _drawMode != _drawModes[2])
            {
               _loc12_ = Math.min(_selectionStartPoint.x,_loc3_.x);
               _loc5_ = Math.max(_selectionStartPoint.x,_loc3_.x);
               _loc11_ = Math.min(_selectionStartPoint.y,_loc3_.y);
               _loc4_ = Math.max(_selectionStartPoint.y,_loc3_.y);
               _floor.clearTemporaryCache();
               _loc8_ = _loc12_;
               while(_loc8_ <= _loc5_)
               {
                  _loc10_ = _loc11_;
                  while(_loc10_ <= _loc4_)
                  {
                     applyDraw(_loc8_,_loc10_);
                     _loc10_++;
                  }
                  _loc8_++;
               }
               updateView();
            }
            else if(param1.type == "WME_MOVE")
            {
               if(_lastDrawAddress.x != _loc3_.x || _lastDrawAddress.y != _loc3_.y)
               {
                  applyDraw(_loc3_.x,_loc3_.y);
               }
               _loc9_ = interpolateBetweenLastPointAndDrawPoint(_loc3_);
               if(Math.abs(_loc9_.x) > 0 || Math.abs(_loc9_.y) > 0)
               {
                  updateView();
               }
            }
            _lastDrawAddress = _loc3_;
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
      
      private function applyDraw(param1:int, param2:int) : Boolean
      {
         if(!allowDraw(param1,param2))
         {
            return false;
         }
         switch(_drawMode)
         {
            case _drawModes[0]:
               _floor.setOccupied(param1,param2,true);
               break;
            case _drawModes[1]:
               _floor.setOccupied(param1,param2,false);
               break;
            case _drawModes[2]:
               setRootTile(param1 - NeighborhoodFloor.RADIUS,param2 - NeighborhoodFloor.RADIUS);
         }
         return true;
      }
      
      private function get floorBitmap() : class_2251
      {
         return _cont.findChildByName("heightmap_bitmap") as class_2251;
      }
      
      private function get neighborhoodCont() : class_1812
      {
         return _cont.findChildByName("neighborhood_selection") as class_1812;
      }
      
      private function updateView() : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:BitmapData = null;
         var _loc12_:Point = null;
         var _loc1_:Array = [];
         var _loc3_:int = -8 * (NeighborhoodFloor.var_379 - 1) - 16;
         var _loc5_:int = 8 * (NeighborhoodFloor.var_379 - 1) + 16;
         var _loc4_:int = 8 * (NeighborhoodFloor.var_379 - 1) + 8;
         _loc9_ = 0;
         while(_loc9_ < NeighborhoodFloor.var_379)
         {
            _loc8_ = 0;
            while(_loc8_ < NeighborhoodFloor.var_379)
            {
               _loc12_ = transformToScreenSpace(_loc8_,_loc9_);
               _loc11_ = _floor.isOccupied(_loc8_,_loc9_) ? _tileTaken : _tileUntaken;
               _loc1_.push({
                  "point":_loc12_,
                  "image":_loc11_
               });
               _loc8_++;
            }
            _loc9_++;
         }
         if(var_443.x >= -NeighborhoodFloor.RADIUS && var_443.x <= NeighborhoodFloor.RADIUS && var_443.y >= -NeighborhoodFloor.RADIUS && var_443.y <= NeighborhoodFloor.RADIUS)
         {
            _loc1_.push({
               "point":transformToScreenSpace(var_443.x + NeighborhoodFloor.RADIUS,var_443.y + NeighborhoodFloor.RADIUS),
               "image":_tileImageEntry
            });
         }
         _loc8_ = 0;
         while(_loc8_ < NeighborhoodFloor.var_379)
         {
            _loc1_.push({
               "point":transformToScreenSpace(_loc8_,-1),
               "image":FLOOR_EDITOR_BORDERS[0]
            });
            _loc1_.push({
               "point":transformToScreenSpace(_loc8_,NeighborhoodFloor.var_379),
               "image":FLOOR_EDITOR_BORDERS[4]
            });
            _loc8_++;
         }
         _loc9_ = 0;
         while(_loc9_ < NeighborhoodFloor.var_379)
         {
            _loc1_.push({
               "point":transformToScreenSpace(-1,_loc9_),
               "image":FLOOR_EDITOR_BORDERS[6]
            });
            _loc1_.push({
               "point":transformToScreenSpace(NeighborhoodFloor.var_379,_loc9_),
               "image":FLOOR_EDITOR_BORDERS[2]
            });
            _loc9_++;
         }
         _loc1_.push({
            "point":transformToScreenSpace(-1,-1),
            "image":FLOOR_EDITOR_BORDERS[7]
         });
         _loc1_.push({
            "point":transformToScreenSpace(NeighborhoodFloor.var_379,-1),
            "image":FLOOR_EDITOR_BORDERS[1]
         });
         _loc1_.push({
            "point":transformToScreenSpace(NeighborhoodFloor.var_379,NeighborhoodFloor.var_379),
            "image":FLOOR_EDITOR_BORDERS[3]
         });
         _loc1_.push({
            "point":transformToScreenSpace(-1,NeighborhoodFloor.var_379),
            "image":FLOOR_EDITOR_BORDERS[5]
         });
         var _loc6_:BitmapData = new BitmapData(_loc5_ - _loc3_ + 18,_loc4_ - -8 + 9,false,4013373);
         var _loc7_:Point = new Point(-_loc3_,--8);
         for each(var _loc10_ in _loc1_)
         {
            _loc6_.copyPixels(_loc10_.image,_loc10_.image.rect,_loc10_.point.add(_loc7_));
         }
         floorBitmap.bitmap = _loc6_;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:InteractiveController = null;
         if(_cont)
         {
            for each(var _loc3_ in _drawModes)
            {
               _loc2_ = InteractiveController(_cont.findChildByName(_loc3_));
               if(_drawMode == _loc3_ && (_loc2_.state & 0x10) == 0)
               {
                  _loc2_.state |= 4;
               }
            }
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.neighborhood";
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         var_2419 = param2 == WiredInputSourcePicker.USER_SOURCE;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return var_2419 ? WiredInputSourcePicker.USER_SOURCE : WiredInputSourcePicker.var_128;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      private function getRootXInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("x_input"));
      }
      
      private function getRootYInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("y_input"));
      }
      
      private function updateRootInputText() : void
      {
         getRootXInput().text = "" + var_443.x;
         getRootYInput().text = "" + var_443.y;
      }
      
      private function setRootTile(param1:int, param2:int) : void
      {
         var_443 = new Point(param1,param2);
         var_3220 = "" + var_443.x;
         var_3186 = "" + var_443.y;
         updateRootInputText();
      }
      
      private function onRootInputChange(param1:class_1758) : void
      {
         var _loc2_:ITextFieldWindow = param1.window as ITextFieldWindow;
         var _loc3_:String = _loc2_.text;
         var _loc4_:* = _loc2_ == getRootXInput();
         if(/^-?\d+$/.test(_loc3_) && !isNaN(Number(_loc3_)))
         {
            if(_loc4_)
            {
               var_443.x = int(Number(_loc3_));
            }
            else
            {
               var_443.y = int(Number(_loc3_));
            }
            updateView();
         }
         else if(_loc3_ != "-" && _loc3_ != "")
         {
            _loc2_.text = _loc4_ ? var_3220 : var_3186;
            return;
         }
         if(_loc4_)
         {
            var_3220 = _loc3_;
         }
         else
         {
            var_3186 = _loc3_;
         }
      }
   }
}


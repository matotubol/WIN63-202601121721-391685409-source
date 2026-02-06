package com.sulake.habbo.window.utils.floorplaneditor
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.class_2478;
   import flash.display.BitmapData;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.layout.RoomOccupiedTilesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.layout.RoomEntryTileMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.layout.GetRoomEntryTileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.layout.GetOccupiedTilesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.layout.UpdateFloorPropertiesMessageComposer;
   import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.layout.RoomEntryTileMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsEventParser;
   import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   
   public class BCFloorPlanEditor implements class_31
   {
      
      private static const PREVIEW_UPDATE_MS:uint = 2000;
      
      private static const WALL_HEIGHT_LIMIT:int = 16;
      
      public static var floor_plan_editor_layout:Class = floor_plan_editor_bc_xml$062c717775d2a3b3243c0af41d3309951861357089;
      
      public static var floor_plan_editor_export_import:Class = floor_plan_export_import_xml$1874800ec017f0c7a5e3579d1963b3b41492987884;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _floorHeightMapMessageEvent:FloorHeightMapMessageEvent;
      
      private var _entryTileDataMessageEvent:RoomEntryTileMessageEvent;
      
      private var _occupiedTilesMessageEvent:RoomOccupiedTilesMessageEvent;
      
      private var _roomVisualizationSettingsMessageEvent:RoomVisualizationSettingsEvent;
      
      private var _buildersClubSubscriptionStatusMessageEvent:BuildersClubSubscriptionStatusMessageEvent;
      
      private var _perkAllowancesMessageEvent:PerkAllowancesMessageEvent;
      
      private var _floorPlanCache:FloorPlanCache;
      
      private var _floorPlanPreviewer:FloorPlanPreviewer;
      
      private var _heightMapEditor:HeightMapEditor;
      
      private var _importExportDialog:ImportExportDialog;
      
      private var _lastReceivedMapEvent:FloorHeightMapMessageEvent;
      
      private var _editorWindow:class_2250;
      
      private var _drawModes:Array = ["add_tile","remove_tile","increase_height","decrease_height","set_enter_tile"];
      
      private var _drawMode:String = _drawModes[0];
      
      private var _floorThickness:int;
      
      private var _wallThickness:int;
      
      private var _msSinceLastPreviewUpdate:uint;
      
      private var _bcSecondsLeft:int = 0;
      
      private var _bcSecondsCountdownTimer:Timer;
      
      private var _largeFloorPlansAllowed:Boolean = false;
      
      private var _fixedWallsHeight:int;
      
      private var _colorMapMouseDown:Boolean = false;
      
      private var _wallHeightSliderMouseDown:Boolean = false;
      
      public function BCFloorPlanEditor(param1:HabboWindowManagerComponent)
      {
         super();
         _floorPlanCache = new FloorPlanCache(this);
         _windowManager = param1;
         if(_windowManager.communication != null)
         {
            _floorHeightMapMessageEvent = new FloorHeightMapMessageEvent(onFloorHeightMap);
            _entryTileDataMessageEvent = new RoomEntryTileMessageEvent(onEntryTileData);
            _occupiedTilesMessageEvent = new RoomOccupiedTilesMessageEvent(onOccupiedTiles);
            _roomVisualizationSettingsMessageEvent = new RoomVisualizationSettingsEvent(onRoomVisualizationSettings);
            _buildersClubSubscriptionStatusMessageEvent = new BuildersClubSubscriptionStatusMessageEvent(onBcStatus);
            _perkAllowancesMessageEvent = new PerkAllowancesMessageEvent(onPerkAllowances);
            _windowManager.communication.addHabboConnectionMessageEvent(_floorHeightMapMessageEvent);
            _windowManager.communication.addHabboConnectionMessageEvent(_buildersClubSubscriptionStatusMessageEvent);
            _windowManager.communication.addHabboConnectionMessageEvent(_entryTileDataMessageEvent);
            _windowManager.communication.addHabboConnectionMessageEvent(_occupiedTilesMessageEvent);
            _windowManager.communication.addHabboConnectionMessageEvent(_roomVisualizationSettingsMessageEvent);
            _windowManager.communication.addHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
         }
         if(param1.roomEngine)
         {
            param1.roomEngine.events.addEventListener("REE_DISPOSED",onRoomDisposed);
         }
         param1.registerUpdateReceiver(this,0);
      }
      
      public static function getThicknessSettingBySelectionIndex(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return -2;
            case 1:
               return -1;
            case 3:
               return 1;
            default:
               return 0;
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_floorHeightMapMessageEvent != null)
         {
            _windowManager.communication.removeHabboConnectionMessageEvent(_floorHeightMapMessageEvent);
            _windowManager.communication.removeHabboConnectionMessageEvent(_entryTileDataMessageEvent);
            _windowManager.communication.removeHabboConnectionMessageEvent(_occupiedTilesMessageEvent);
            _windowManager.communication.removeHabboConnectionMessageEvent(_roomVisualizationSettingsMessageEvent);
            _windowManager.communication.removeHabboConnectionMessageEvent(_buildersClubSubscriptionStatusMessageEvent);
            _windowManager.communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
            _floorHeightMapMessageEvent = null;
            _entryTileDataMessageEvent = null;
            _occupiedTilesMessageEvent = null;
            _roomVisualizationSettingsMessageEvent = null;
         }
         if(windowManager.roomEngine && !windowManager.roomEngine.disposed)
         {
            windowManager.roomEngine.events.removeEventListener("REE_DISPOSED",onRoomDisposed);
         }
         _windowManager.removeUpdateReceiver(this);
         _windowManager = null;
      }
      
      public function get disposed() : Boolean
      {
         return _windowManager == null;
      }
      
      private function onBcStatus(param1:BuildersClubSubscriptionStatusMessageEvent) : void
      {
         var _loc2_:BuildersClubSubscriptionStatusMessageEventParser = param1.getParser();
         _bcSecondsLeft = _loc2_.secondsLeft;
         if(!_bcSecondsCountdownTimer)
         {
            _bcSecondsCountdownTimer = new Timer(10000);
            _bcSecondsCountdownTimer.addEventListener("timer",onBcCountdownTimerEvent);
            _bcSecondsCountdownTimer.start();
         }
      }
      
      private function onBcCountdownTimerEvent(param1:TimerEvent) : void
      {
         _bcSecondsLeft -= 10;
         if(_editorWindow && _editorWindow.visible)
         {
            if(_bcSecondsLeft > 0 || _windowManager.sessionDataManager.hasSecurity(4))
            {
               _editorWindow.findChildByName("save").enable();
            }
            else
            {
               _editorWindow.findChildByName("save").disable();
            }
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_editorWindow == null || Boolean(_editorWindow.disposed))
         {
            if(!param1)
            {
               return;
            }
            createEditorWindow();
         }
         _editorWindow.visible = param1;
         if(param1)
         {
            _windowManager.communication.connection.send(new GetRoomEntryTileMessageComposer());
            _windowManager.communication.connection.send(new GetOccupiedTilesMessageComposer());
            updateThicknessSelection();
            centerScrollableViews();
            updateWallHeight(_fixedWallsHeight);
         }
         else
         {
            _heightMapEditor.colorPickMode = false;
         }
      }
      
      public function get visible() : Boolean
      {
         return _editorWindow != null && Boolean(_editorWindow.visible);
      }
      
      private function createEditorWindow() : void
      {
         var _loc1_:ByteArray = new floor_plan_editor_layout() as ByteArray;
         var _loc2_:XML = new XML(_loc1_.readUTFBytes(_loc1_.length));
         _editorWindow = _windowManager.buildFromXML(_loc2_,1) as class_2250;
         _editorWindow.procedure = editorWindowProcedure;
         _editorWindow.findChildByName("tile_height_colormap").procedure = colorMapWindowProcedure;
         _editorWindow.findChildByName("wall_height_slider").procedure = wallHeightSliderProcedure;
         _editorWindow.center();
         _floorPlanPreviewer = new FloorPlanPreviewer(this);
         _heightMapEditor = new HeightMapEditor(this);
         _loc1_ = new floor_plan_editor_export_import() as ByteArray;
         _importExportDialog = new ImportExportDialog(this,new XML(_loc1_.readUTFBytes(_loc1_.length)));
         _floorPlanPreviewer.updatePreview();
         _heightMapEditor.refreshFromCache();
         createTileHeightColorMap(_heightMapEditor.heigthColorMap);
         setDrawMode("add_tile");
         IItemListWindow(_editorWindow.findChildByName("heightmap_wrapper")).disableAutodrag = true;
         IItemListWindow(_editorWindow.findChildByName("preview_wrapper")).disableAutodrag = true;
         if(!_windowManager.sessionDataManager.hasSecurity(4) && _bcSecondsLeft <= 0)
         {
            _editorWindow.findChildByName("save").disable();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(_drawMode != "" && _editorWindow)
         {
            for each(var _loc2_ in _drawModes)
            {
               if(_drawMode == _loc2_)
               {
                  InteractiveController(_editorWindow.findChildByName(_loc2_)).state = InteractiveController(_editorWindow.findChildByName(_loc2_)).state | 0x10;
               }
               else
               {
                  InteractiveController(_editorWindow.findChildByName(_loc2_)).state = InteractiveController(_editorWindow.findChildByName(_loc2_)).state & ~0x10;
               }
            }
         }
         _msSinceLastPreviewUpdate += param1;
         if(_msSinceLastPreviewUpdate > 2000 && _floorPlanPreviewer)
         {
            _floorPlanPreviewer.updatePreview();
            _msSinceLastPreviewUpdate = 0;
         }
      }
      
      private function get isWallHeightSettingSelected() : Boolean
      {
         return class_1885(_editorWindow.findChildByName("walls_fixed_height_enabled_checkbox")).isSelected;
      }
      
      private function editorWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "cancel":
                  visible = false;
                  break;
               case "refresh":
                  _floorPlanPreviewer.updatePreview();
                  break;
               case "save":
                  _floorThickness = class_2261(_editorWindow.findChildByName("floor_thickness_drop")).selection;
                  _wallThickness = class_2261(_editorWindow.findChildByName("wall_thickness_drop")).selection;
                  _windowManager.communication.connection.send(new UpdateFloorPropertiesMessageComposer(_floorPlanCache.getData(),_floorPlanCache.entryPoint.x,_floorPlanCache.entryPoint.y,_floorPlanCache.entryPointDir,getThicknessSettingBySelectionIndex(_wallThickness),getThicknessSettingBySelectionIndex(_floorThickness),isWallHeightSettingSelected ? _fixedWallsHeight : -1));
                  break;
               case "reload":
                  _floorPlanCache.onFloorHeightMap(_lastReceivedMapEvent);
                  if(_floorPlanPreviewer)
                  {
                     _floorPlanPreviewer.updatePreview();
                  }
                  if(_heightMapEditor)
                  {
                     _heightMapEditor.refreshFromCache();
                  }
                  _windowManager.communication.connection.send(new GetOccupiedTilesMessageComposer());
                  _windowManager.communication.connection.send(new GetRoomEntryTileMessageComposer());
                  break;
               case "import_export":
                  _importExportDialog.visible = !_importExportDialog.visible;
                  break;
               case "enterdirection_left":
                  _floorPlanCache.entryPointDir++;
                  updateEntryDirectionAvatar();
                  break;
               case "enterdirection_right":
                  _floorPlanCache.entryPointDir--;
                  updateEntryDirectionAvatar();
                  break;
               case "zoom":
                  if(_heightMapEditor.zoomLevel == 1)
                  {
                     _heightMapEditor.zoomLevel = 2;
                  }
                  else
                  {
                     _heightMapEditor.zoomLevel = 1;
                  }
                  _heightMapEditor.refreshFromCache();
                  break;
               case "walls_fixed_height_enabled_checkbox":
                  enableWallHeightControls(isWallHeightSettingSelected);
                  if(isWallHeightSettingSelected && _fixedWallsHeight == -1)
                  {
                     _fixedWallsHeight = parseInt(_editorWindow.findChildByName("wall_height_number").caption) - 1;
                  }
            }
            if(_drawModes.indexOf(param2.name) != -1)
            {
               setDrawMode(param2.name);
            }
         }
      }
      
      public function onKeyboardEvent(param1:KeyboardEvent) : void
      {
         if(param1.type == "keyDown")
         {
            switch(param1.keyCode)
            {
               case 107:
                  _heightMapEditor.drawingHeight++;
                  break;
               case 109:
                  _heightMapEditor.drawingHeight++;
                  break;
               case 16:
                  if(_heightMapEditor)
                  {
                     _heightMapEditor.colorPickMode = true;
                  }
            }
         }
         else if(param1.type == "keyUp")
         {
            if(param1.keyCode == 16)
            {
               if(_heightMapEditor)
               {
                  _heightMapEditor.colorPickMode = false;
               }
            }
         }
      }
      
      private function setDrawMode(param1:String) : void
      {
         _drawMode = param1;
      }
      
      private function colorMapWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:WindowMouseEvent = null;
         var _loc4_:* = 0;
         if(param1.type == "WME_DOWN")
         {
            _colorMapMouseDown = true;
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            _colorMapMouseDown = false;
         }
         else if(param1.type == "WME_CLICK" || _colorMapMouseDown && param1.type == "WME_MOVE")
         {
            _loc3_ = param1 as WindowMouseEvent;
            _loc4_ = _loc3_.localX / _editorWindow.findChildByName("tile_height_colormap").width * _heightMapEditor.heigthColorMap.length;
            updateColorSliderTrack(_loc4_);
            _heightMapEditor.drawingHeight = _loc4_;
         }
      }
      
      public function updateColorSliderTrack(param1:uint) : void
      {
         _editorWindow.findChildByName("tile_height_slider_track").x = param1 * (Number(_editorWindow.findChildByName("tile_height_colormap").width) / _heightMapEditor.heigthColorMap.length);
      }
      
      private function wallHeightSliderProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:WindowMouseEvent = null;
         var _loc4_:* = 0;
         if(param1.type == "WME_DOWN")
         {
            _wallHeightSliderMouseDown = true;
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            _wallHeightSliderMouseDown = false;
         }
         else if(param1.type == "WME_CLICK" || _wallHeightSliderMouseDown && param1.type == "WME_MOVE")
         {
            _loc3_ = param1 as WindowMouseEvent;
            _loc4_ = _loc3_.localX / _editorWindow.findChildByName("wall_height_slider").width * 16;
            updateWallHeight(_loc4_);
            _fixedWallsHeight = _loc4_;
         }
         param1.stopPropagation();
      }
      
      public function updateWallHeight(param1:int) : void
      {
         if(param1 == -1)
         {
            class_1885(_editorWindow.findChildByName("walls_fixed_height_enabled_checkbox")).unselect();
            enableWallHeightControls(false);
         }
         else
         {
            class_1885(_editorWindow.findChildByName("walls_fixed_height_enabled_checkbox")).select();
            enableWallHeightControls(true);
            _editorWindow.findChildByName("wall_height_number").caption = (param1 + 1).toString();
            _editorWindow.findChildByName("wall_height_slider_track").x = param1 * (Number(_editorWindow.findChildByName("wall_height_slider").width) / 16);
         }
      }
      
      private function enableWallHeightControls(param1:Boolean) : void
      {
         if(param1)
         {
            _editorWindow.findChildByName("wall_height_text").enable();
            _editorWindow.findChildByName("wall_height_number").enable();
            _editorWindow.findChildByName("wall_height_slider").enable();
            _editorWindow.findChildByName("wall_height_slider_track").enable();
            _editorWindow.findChildByName("wall_height_text").blend = 1;
            _editorWindow.findChildByName("wall_height_number").blend = 1;
            _editorWindow.findChildByName("wall_height_slider").blend = 1;
            _editorWindow.findChildByName("wall_height_slider_track").blend = 1;
         }
         else
         {
            _editorWindow.findChildByName("wall_height_text").disable();
            _editorWindow.findChildByName("wall_height_number").disable();
            _editorWindow.findChildByName("wall_height_slider").disable();
            _editorWindow.findChildByName("wall_height_slider_track").disable();
            _editorWindow.findChildByName("wall_height_text").blend = 0.6;
            _editorWindow.findChildByName("wall_height_number").blend = 0.6;
            _editorWindow.findChildByName("wall_height_slider").blend = 0.6;
            _editorWindow.findChildByName("wall_height_slider_track").blend = 0.6;
         }
      }
      
      private function onFloorHeightMap(param1:FloorHeightMapMessageEvent) : void
      {
         _lastReceivedMapEvent = param1;
         _floorPlanCache.onFloorHeightMap(param1);
         _fixedWallsHeight = param1.getParser().fixedWallsHeight;
         if(_floorPlanPreviewer)
         {
            _floorPlanPreviewer.updatePreview();
         }
         if(_heightMapEditor)
         {
            _heightMapEditor.refreshFromCache();
         }
         if(_editorWindow)
         {
            updateWallHeight(_fixedWallsHeight);
         }
      }
      
      private function onEntryTileData(param1:RoomEntryTileMessageEvent) : void
      {
         if(!_editorWindow)
         {
            return;
         }
         var _loc2_:RoomEntryTileMessageEventParser = param1.getParser();
         _floorPlanCache.entryPoint = new Point(_loc2_.x,_loc2_.y);
         _floorPlanCache.entryPointDir = _loc2_.dir;
         if(_heightMapEditor)
         {
            _heightMapEditor.refreshFromCache();
         }
         updateEntryDirectionAvatar();
      }
      
      private function onOccupiedTiles(param1:RoomOccupiedTilesMessageEvent) : void
      {
         _floorPlanCache.onOccupiedTiles(param1);
         if(_heightMapEditor)
         {
            _heightMapEditor.refreshFromCache();
         }
      }
      
      private function onRoomVisualizationSettings(param1:RoomVisualizationSettingsEvent) : void
      {
         var _loc2_:RoomVisualizationSettingsEventParser = param1.getParser();
         _floorThickness = getThicknessSelectionIndex(_loc2_.floorThicknessMultiplier);
         _wallThickness = getThicknessSelectionIndex(_loc2_.wallThicknessMultiplier);
         updateThicknessSelection();
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         var _loc2_:PerkAllowancesMessageEventParser = param1.getParser();
         _largeFloorPlansAllowed = _loc2_.isPerkAllowed("BUILDER_AT_WORK");
      }
      
      public function updatePreviewBitmap(param1:BitmapData) : void
      {
         var _loc2_:class_2251 = class_2251(_editorWindow.findChildByName("preview_bitmap"));
         _loc2_.bitmap = param1;
      }
      
      private function createTileHeightColorMap(param1:Vector.<Array>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = 0;
         var _loc6_:class_2251 = _editorWindow.findChildByName("tile_height_colormap") as class_2251;
         _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,false,0);
         var _loc3_:Rectangle = new Rectangle(0,0,1,_loc6_.height);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.width)
         {
            _loc5_ = _loc4_ / _loc6_.width * param1.length;
            _loc2_ = (uint(255 * param1[_loc5_][0]) << 16) + (uint(255 * param1[_loc5_][1]) << 8) + uint(255 * param1[_loc5_][2]);
            _loc3_.x = _loc4_;
            _loc6_.bitmap.fillRect(_loc3_,_loc2_);
            _loc4_++;
         }
      }
      
      private function updateEntryDirectionAvatar() : void
      {
         var _loc1_:class_2478 = class_2010(_editorWindow.findChildByName("enterdirection_ghost_avatar")).widget as class_2478;
         _loc1_.direction = _floorPlanCache.entryPointDir;
      }
      
      private function getThicknessSelectionIndex(param1:Number) : int
      {
         switch(param1)
         {
            case 0.25:
               return 0;
            case 0.5:
               return 1;
            case 2:
               return 3;
            default:
               return 2;
         }
      }
      
      private function updateThicknessSelection() : void
      {
         if(_editorWindow)
         {
            class_2261(_editorWindow.findChildByName("wall_thickness_drop")).selection = _wallThickness;
            class_2261(_editorWindow.findChildByName("floor_thickness_drop")).selection = _floorThickness;
         }
      }
      
      private function centerScrollableViews() : void
      {
         var _loc1_:IScrollbarWindow = _editorWindow.findChildByName("heightmap_scroll_horizontal") as IScrollbarWindow;
         var _loc2_:IScrollbarWindow = _editorWindow.findChildByName("heightmap_scroll_vertical") as IScrollbarWindow;
         var _loc4_:IScrollbarWindow = _editorWindow.findChildByName("preview_scroll_horizontal") as IScrollbarWindow;
         var _loc3_:IScrollbarWindow = _editorWindow.findChildByName("preview_scroll_vertical") as IScrollbarWindow;
         _loc1_.scrollH = 0.5;
         _loc2_.scrollV = 0.5;
         _loc4_.scrollH = 0.5;
         _loc3_.scrollV = 0.5;
      }
      
      private function onRoomDisposed(param1:RoomEngineEvent) : void
      {
         visible = false;
      }
      
      public function get windowManager() : HabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get heightMapBitmapElement() : class_2251
      {
         return _editorWindow.findChildByName("heightmap_bitmap") as class_2251;
      }
      
      public function get floorPlanCache() : FloorPlanCache
      {
         return _floorPlanCache;
      }
      
      public function get drawModes() : Array
      {
         return _drawModes;
      }
      
      public function get drawMode() : String
      {
         return _drawMode;
      }
      
      public function get heightMapEditor() : HeightMapEditor
      {
         return _heightMapEditor;
      }
      
      public function get largeFloorPlansAllowed() : Boolean
      {
         return _largeFloorPlansAllowed;
      }
      
      public function get lastReceivedFloorPlan() : String
      {
         if(_lastReceivedMapEvent)
         {
            return _lastReceivedMapEvent.getParser().text;
         }
         return "";
      }
      
      public function get floorThickness() : int
      {
         return _floorThickness;
      }
      
      public function get wallThickness() : int
      {
         return _wallThickness;
      }
      
      public function get bcSecondsLeft() : int
      {
         return _bcSecondsLeft;
      }
   }
}


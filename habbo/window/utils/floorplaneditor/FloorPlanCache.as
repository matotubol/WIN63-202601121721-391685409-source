package com.sulake.habbo.window.utils.floorplaneditor
{
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.room.layout.RoomOccupiedTilesMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.layout.RoomOccupiedTilesMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
   
   public class FloorPlanCache
   {
      
      private const MAX_AREA:uint = 3025;
      
      private const MAX_AXIS_LENGTH:uint = 64;
      
      private var _bcFloorPlanEditor:BCFloorPlanEditor;
      
      private var _floorWidth:int;
      
      private var _floorHeight:int;
      
      private var _floorPlanCache:Array;
      
      private var _floorPlanCacheBuffer:Array = null;
      
      private var _reservedTiles:Array;
      
      private var _entryPoint:Point;
      
      private var _entryPointDir:uint;
      
      private var _showedPopup:Boolean;
      
      public function FloorPlanCache(param1:BCFloorPlanEditor)
      {
         super();
         _bcFloorPlanEditor = param1;
      }
      
      public function onFloorHeightMap(param1:FloorHeightMapMessageEvent) : void
      {
         updateFloorPlanCache(param1.getParser().text);
         _showedPopup = false;
      }
      
      public function onOccupiedTiles(param1:RoomOccupiedTilesMessageEvent) : void
      {
         var _loc2_:RoomOccupiedTilesMessageEventParser = null;
         if(_floorPlanCache)
         {
            _loc2_ = param1.getParser();
            resetReservedTiles();
            for each(var _loc3_ in _loc2_.occupiedTiles)
            {
               _reservedTiles[_loc3_.y][_loc3_.x] = true;
            }
         }
      }
      
      private function resetReservedTiles() : void
      {
         _reservedTiles = [];
         var _loc2_:int = 0;
         while(0 < floorHeight)
         {
            _reservedTiles.push([]);
            var _loc1_:int = 0;
            while(0 < floorWidth)
            {
               _reservedTiles[0].push(false);
               _loc1_++;
            }
            _loc2_++;
         }
      }
      
      private function updateFloorPlanCache(param1:String = "") : void
      {
         var _loc2_:Array = param1.split("\r");
         _floorPlanCache = [];
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.length > 0)
            {
               _floorPlanCache.push(_loc3_);
            }
         }
         checkDimensions();
      }
      
      private function checkDimensions() : Boolean
      {
         _floorWidth = -1;
         _floorHeight = -1;
         if(_floorPlanCache.length == 0)
         {
            return false;
         }
         var _loc1_:int = String(_floorPlanCache[0]).length;
         var _loc3_:int = 0;
         for each(var _loc2_ in _floorPlanCache)
         {
            if(_loc2_.length == 0)
            {
               break;
            }
            _loc3_++;
         }
         _floorWidth = _loc1_;
         _floorHeight = _loc3_;
         return true;
      }
      
      private function allowDrawAt(param1:int, param2:int) : Boolean
      {
         if(_floorPlanCache == null || param1 < 0 || param1 > _floorWidth || param2 < 0 || param2 > _floorHeight)
         {
            return false;
         }
         if(param1 == 0 || param2 == 0)
         {
            return isDoorTileAllowedAt(param1,param2);
         }
         return true;
      }
      
      private function isDoorTileAllowedAt(param1:int, param2:int) : Boolean
      {
         return isFirstColumnZeroOrHasDoorAt(param1,param2) && isFirstRowZeroOrHasDoorAt(param1,param2);
      }
      
      private function isFirstColumnZeroOrHasDoorAt(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _floorHeight)
         {
            if(_loc3_ != param2 && _floorPlanCache[_loc3_].substr(0,1) != "x")
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function isFirstRowZeroOrHasDoorAt(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _floorWidth)
         {
            if(_loc3_ != param1 && _floorPlanCache[0].substr(_loc3_,1) != "x")
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function setHeightAt(param1:int, param2:int, param3:int) : Boolean
      {
         if(!allowDrawAt(param1,param2))
         {
            return false;
         }
         if(param1 >= _floorWidth)
         {
            if(!addColumn())
            {
               return false;
            }
         }
         if(param2 >= _floorHeight)
         {
            if(!addRow())
            {
               return false;
            }
         }
         if(isTileReserved(param1,param2))
         {
            return false;
         }
         _floorPlanCache[param2] = setCharAt(String(_floorPlanCache[param2]),param3 < 0 ? "x" : param3.toString(33),param1);
         return true;
      }
      
      public function getHeightAt(param1:int, param2:int) : int
      {
         if(_floorPlanCache == null || param1 < 0 || param1 >= _floorWidth || param2 < 0 || param2 >= _floorHeight)
         {
            return -1;
         }
         var _loc3_:String = String(_floorPlanCache[param2]).charAt(param1);
         return _loc3_ == "x" ? -1 : parseInt(_loc3_,33);
      }
      
      private function setCharAt(param1:String, param2:String, param3:int) : String
      {
         return param1.substr(0,param3) + param2 + param1.substr(param3 + 1);
      }
      
      public function get floorWidth() : int
      {
         return _floorWidth;
      }
      
      public function get floorHeight() : int
      {
         return _floorHeight;
      }
      
      public function getData() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = "";
         _loc1_ = 0;
         while(_loc1_ < _floorPlanCache.length)
         {
            _loc2_ = _loc2_ + _floorPlanCache[_loc1_] + "\r";
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function isTileReserved(param1:int, param2:int) : Boolean
      {
         if(!_reservedTiles)
         {
            return false;
         }
         if(_reservedTiles.length < param2 + 1)
         {
            return false;
         }
         if(_reservedTiles[param2].length < param1 + 1)
         {
            return false;
         }
         return _reservedTiles[param2][param1];
      }
      
      public function isEntryPoint(param1:int, param2:int) : Boolean
      {
         if(!_entryPoint)
         {
            return false;
         }
         return _entryPoint.x == param1 && _entryPoint.y == param2;
      }
      
      public function get entryPoint() : Point
      {
         return _entryPoint;
      }
      
      public function set entryPoint(param1:Point) : void
      {
         _entryPoint = param1;
      }
      
      public function get entryPointDir() : int
      {
         return _entryPointDir;
      }
      
      public function set entryPointDir(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 7;
         }
         if(param1 > 7)
         {
            param1 = 0;
         }
         _entryPointDir = param1;
      }
      
      private function addColumn(param1:Boolean = false) : Boolean
      {
         var _loc2_:int = 0;
         if(!checkSizeLimits(_floorWidth + 1,_floorHeight))
         {
            if(!_showedPopup && !param1)
            {
               _bcFloorPlanEditor.windowManager.simpleAlert("${floor.plan.editor.alert}",null,"${floor.plan.editor.size.limit.exceeded}");
               _bcFloorPlanEditor.heightMapEditor.drawing = false;
               _showedPopup = true;
            }
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < _floorHeight)
         {
            if(String(_floorPlanCache[_loc2_]).length > 0)
            {
               _floorPlanCache[_loc2_] += "x";
               _reservedTiles[_loc2_].push(false);
            }
            _loc2_++;
         }
         _floorWidth += 1;
         return true;
      }
      
      private function addRow(param1:Boolean = false) : Boolean
      {
         var _loc3_:int = 0;
         if(!checkSizeLimits(_floorWidth,_floorHeight + 1))
         {
            if(!_showedPopup && !param1)
            {
               _bcFloorPlanEditor.windowManager.simpleAlert("${floor.plan.editor.alert}",null,"${floor.plan.editor.size.limit.exceeded}");
               _bcFloorPlanEditor.heightMapEditor.drawing = false;
               _showedPopup = true;
            }
            return false;
         }
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _floorWidth)
         {
            _loc2_ += "x";
            _loc3_++;
         }
         _floorPlanCache.push(_loc2_);
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _floorWidth)
         {
            _loc4_.push(false);
            _loc3_++;
         }
         _reservedTiles.push(_loc4_);
         _floorHeight += 1;
         return true;
      }
      
      public function attemptExpandColumns(param1:int) : Boolean
      {
         while(param1 >= floorWidth)
         {
            if(!addColumn(true))
            {
               return false;
            }
         }
         return true;
      }
      
      public function attemptExpandRows(param1:int) : Boolean
      {
         while(param1 >= floorHeight)
         {
            if(!addRow(true))
            {
               return false;
            }
         }
         return true;
      }
      
      private function checkSizeLimits(param1:uint, param2:uint) : Boolean
      {
         return !(!_bcFloorPlanEditor.largeFloorPlansAllowed && (param1 - 1) * (param2 - 1) > 3025 || param1 > 64 || param2 > 64);
      }
      
      public function initTemporaryCache() : void
      {
         _floorPlanCacheBuffer = _floorPlanCache;
         clearTemporaryCache();
      }
      
      public function clearTemporaryCache() : void
      {
         if(_floorPlanCacheBuffer != null)
         {
            _floorPlanCache = [];
            var _loc1_:int = 0;
            while(0 < _floorPlanCacheBuffer.length)
            {
               _floorPlanCache.push(_floorPlanCacheBuffer[0]);
               _loc1_++;
            }
            checkDimensions();
         }
      }
      
      public function submitTemporaryCache() : void
      {
         _floorPlanCacheBuffer = null;
      }
   }
}


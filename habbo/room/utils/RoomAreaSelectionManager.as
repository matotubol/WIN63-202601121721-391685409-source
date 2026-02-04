package com.sulake.habbo.room.utils
{
   import com.sulake.habbo.room.IRoomAreaSelectionManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
   import com.sulake.habbo.room.object.visualization.room.RoomVisualization;
   import com.sulake.room.object.IRoomObject;
   import flash.filters.ColorMatrixFilter;
   
   public class RoomAreaSelectionManager implements IRoomAreaSelectionManager
   {
      
      public static var NOT_ACTIVE:int = 0;
      
      public static var NOT_SELECTING_AREA:int = 1;
      
      public static var AWAITING_MOUSE_DOWN:int = 2;
      
      public static var SELECTING:int = 3;
      
      private static const HIGHLIGHT_FILTERS:Object = createHighlightFilters();
      
      private var _roomEngine:IRoomEngine;
      
      private var var_177:int = NOT_ACTIVE;
      
      private var var_2029:int = 0;
      
      private var var_1961:int = 0;
      
      private var var_1440:int = 0;
      
      private var var_1401:int = 0;
      
      private var _highlightRootX:int = 0;
      
      private var _highlightRootY:int = 0;
      
      private var _highlightWidth:int = 0;
      
      private var _highlightHeight:int = 0;
      
      private var _callback:Function;
      
      private var _highlightType:String = "highlight_brighten";
      
      public function RoomAreaSelectionManager(param1:IRoomEngine)
      {
         super();
         _roomEngine = param1;
         _roomEngine.events.addEventListener("REOE_ADDED",onRoomObjectAdded);
      }
      
      private static function createHighlightFilters() : Object
      {
         var _loc3_:Object = {};
         var _loc4_:Array = [1.5,0,0,0,0,0,1.5,0,0,20,0,0,1.5,0,20,0,0,0,1,0];
         var _loc2_:Array = [1.05,0,0,0,0,0,1.3,0,0,8,0,0,1.8,0,20,0,0,0,1,0];
         var _loc1_:Array = [0.55,0,0,0,-10,0,0.55,0,0,-10,0,0,0.55,0,-10,0,0,0,1,0];
         _loc3_["highlight_brighten"] = [new ColorMatrixFilter(_loc4_)];
         _loc3_["highlight_blue"] = [new ColorMatrixFilter(_loc2_)];
         _loc3_["highlight_darken"] = [new ColorMatrixFilter(_loc1_)];
         return _loc3_;
      }
      
      private function getAllFurnis() : Array
      {
         return _roomEngine.getObjectsByCategory(20).concat(_roomEngine.getObjectsByCategory(10));
      }
      
      public function startSelecting() : void
      {
         if(var_177 == NOT_SELECTING_AREA)
         {
            clearHighlightSilent();
            var_177 = AWAITING_MOUSE_DOWN;
            _roomEngine.setMoveBlocked(true);
         }
      }
      
      public function handleTileMouseEvent(param1:RoomObjectTileMouseEvent) : void
      {
         var _loc3_:Boolean = var_177 == AWAITING_MOUSE_DOWN && param1.type == "ROE_MOUSE_DOWN";
         if(param1.shiftKey && var_177 == NOT_SELECTING_AREA && param1.type == "ROE_MOUSE_DOWN")
         {
            startSelecting();
            _loc3_ = true;
         }
         if(_loc3_)
         {
            var_177 = SELECTING;
            var_2029 = param1.tileXAsInt;
            var_1961 = param1.tileYAsInt;
            var_1440 = param1.tileXAsInt;
            var_1401 = param1.tileYAsInt;
            setHighlight(var_2029,var_1961,1,1);
         }
         else if(var_177 == SELECTING && param1.type == "ROE_MOUSE_MOVE")
         {
            if(param1.tileXAsInt != var_1440 || param1.tileYAsInt != var_1401)
            {
               var_1440 = param1.tileXAsInt;
               var_1401 = param1.tileYAsInt;
               if(var_1440 > var_2029)
               {
                  var _loc4_:int = var_2029;
                  var _loc2_:int = var_1440 - var_2029 + 1;
               }
               else
               {
                  _loc4_ = var_1440;
                  _loc2_ = var_2029 - var_1440 + 1;
               }
               if(var_1401 > var_1961)
               {
                  var _loc5_:int = var_1961;
                  var _loc6_:int = var_1401 - var_1961 + 1;
               }
               else
               {
                  _loc5_ = var_1401;
                  _loc6_ = var_1961 - var_1401 + 1;
               }
               setHighlight(0,0,0,0);
            }
         }
      }
      
      public function finishSelecting() : Boolean
      {
         if(var_177 == SELECTING)
         {
            var_177 = NOT_SELECTING_AREA;
            _roomEngine.setMoveBlocked(false);
            if(_callback != null)
            {
               _callback(_highlightRootX,_highlightRootY,_highlightWidth,_highlightHeight);
            }
            return true;
         }
         return false;
      }
      
      private function clearHighlightSilent() : void
      {
         var _loc1_:RoomVisualization = null;
         var _loc2_:IRoomObject = _roomEngine.getRoomObject(_roomEngine.activeRoomId,-1,0);
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.getVisualization() as RoomVisualization;
            _loc1_.clearHighlightArea();
         }
      }
      
      public function clearHighlight() : void
      {
         if(var_177 == NOT_ACTIVE)
         {
            return;
         }
         clearHighlightSilent();
         var_177 = NOT_SELECTING_AREA;
         _roomEngine.setMoveBlocked(false);
         if(_callback != null)
         {
            _callback(0,0,0,0);
         }
      }
      
      public function setHighlight(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(var_177 == NOT_ACTIVE)
         {
            return;
         }
         _highlightRootX = param1;
         _highlightRootY = param2;
         _highlightWidth = param3;
         _highlightHeight = param4;
         var _loc6_:IRoomObject = _roomEngine.getRoomObject(_roomEngine.activeRoomId,-1,0);
         if(_loc6_ != null)
         {
            var _loc5_:RoomVisualization = _loc6_.getVisualization() as RoomVisualization;
            _loc5_.initializeHighlightArea(param1,param2,param3,param4,HIGHLIGHT_FILTERS[_highlightType]);
         }
      }
      
      public function activate(param1:Function, param2:String) : Boolean
      {
         if(var_177 != NOT_ACTIVE)
         {
            return false;
         }
         _callback = param1;
         _highlightType = param2;
         for each(var _loc4_ in getAllFurnis())
         {
            var _loc3_:FurnitureVisualization = _loc4_.getVisualization() as FurnitureVisualization;
         }
         var_177 = NOT_SELECTING_AREA;
         return true;
      }
      
      public function deactivate() : void
      {
         if(var_177 == NOT_ACTIVE)
         {
            return;
         }
         _callback = null;
         for each(var _loc2_ in getAllFurnis())
         {
            var _loc1_:FurnitureVisualization = _loc2_.getVisualization() as FurnitureVisualization;
         }
         clearHighlight();
         var_177 = NOT_ACTIVE;
      }
      
      private function onRoomObjectAdded(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:FurnitureVisualization = null;
         if(var_177 == NOT_ACTIVE)
         {
            return;
         }
         if(param1.type != "REOE_ADDED")
         {
            return;
         }
         if(param1.roomId != _roomEngine.activeRoomId)
         {
            return;
         }
         if(param1.category != 10 && param1.category != 20)
         {
            return;
         }
         var _loc3_:IRoomObject = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
         if(_loc3_)
         {
            _loc2_ = _loc3_.getVisualization() as FurnitureVisualization;
            if(_loc2_ != null)
            {
               _loc2_.lookThrough = true;
            }
         }
      }
      
      public function get areaSelectionState() : int
      {
         return var_177;
      }
      
      public function dispose() : void
      {
         deactivate();
         _roomEngine.events.removeEventListener("REOE_ADDED",onRoomObjectAdded);
      }
   }
}


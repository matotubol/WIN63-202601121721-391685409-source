package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.room.object.IRoomObject;
   import flash.display.Shader;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.filters.ShaderFilter;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class RoomObjectHighLighter
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _filterBW:Array;
      
      private var _filterBWWall:Array;
      
      private var var_3402:Array;
      
      private var _dualPicking1Filter:Array;
      
      private var _dualPicking2Filter:Array;
      
      public function RoomObjectHighLighter(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         var _loc5_:Number = 154;
         var _loc12_:Number = 0.75;
         var _loc9_:Number = 25.5;
         var _loc13_:Number = 25.5;
         var _loc15_:Array = [1 - _loc12_,0,0,0,_loc12_ * _loc5_,0,1 - _loc12_,0,0,_loc12_ * _loc5_ + _loc9_,0,0,1 - _loc12_,0,_loc12_ * _loc5_ + _loc13_,0,0,0,1,0];
         var _loc6_:ColorMatrixFilter = new ColorMatrixFilter(_loc15_);
         var _loc11_:Class = furnitureFilter_pbj$5b51dd400f82d19cd3c27c61e8dd09011566352002;
         var _loc10_:Shader = new Shader(new _loc11_() as ByteArray);
         var _loc2_:ShaderFilter = new ShaderFilter(_loc10_);
         _filterBW = [_loc6_,_loc2_];
         var _loc3_:GlowFilter = new GlowFilter(16777215,1,5,5,3,1,true,false);
         _filterBWWall = [_loc6_,_loc2_,_loc3_];
         var _loc7_:Array = [0.9,0,0,0,0,0,1,0,0,40,0,0,1,0,80,0,0,0,0.8,0];
         var _loc8_:ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
         var_3402 = [_loc8_];
         var _loc14_:Array = [1.13,0,0,0,35,0,1.13,0,0,35,0,0,1,0,0,0,0,0,1,0];
         _dualPicking1Filter = [new ColorMatrixFilter(_loc14_)];
         var _loc4_:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1.15,0,40,0,0,0,1,0];
         _dualPicking2Filter = [new ColorMatrixFilter(_loc4_)];
      }
      
      public static function addFiltersToFurni(param1:IRoomObject, param2:Array, param3:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         if(hasFilters(param1,param2))
         {
            return;
         }
         var _loc4_:FurnitureVisualization = param1.getVisualization() as FurnitureVisualization;
         class_21.log("Furni visualization: " + _loc4_);
         var _loc5_:Array = _loc4_.filters == null ? [] : _loc4_.filters;
         _loc5_ = param3 ? param2.concat(_loc5_) : _loc5_.concat(param2);
         _loc4_.filters = _loc5_;
      }
      
      public static function removeFiltersFromFurni(param1:IRoomObject, param2:Array) : void
      {
         var _loc5_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc4_:FurnitureVisualization = param1.getVisualization() as FurnitureVisualization;
         class_21.log("Furni visualization: " + _loc4_);
         if(_loc4_.filters == null)
         {
            return;
         }
         var _loc6_:Array = _loc4_.filters.slice();
         for each(var _loc3_ in param2)
         {
            _loc5_ = int(_loc6_.indexOf(_loc3_));
            if(_loc5_ != -1)
            {
               _loc6_.removeAt(_loc5_);
            }
         }
         _loc4_.filters = _loc6_;
      }
      
      public static function hasFilters(param1:IRoomObject, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         if(!param1)
         {
            return false;
         }
         var _loc4_:FurnitureVisualization = param1.getVisualization() as FurnitureVisualization;
         if(_loc4_.filters == null)
         {
            return false;
         }
         var _loc6_:Array = _loc4_.filters.slice();
         for each(var _loc3_ in param2)
         {
            _loc5_ = int(_loc6_.indexOf(_loc3_));
            if(_loc5_ != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hide(param1:int, param2:Boolean, param3:int) : void
      {
         inactivateFurni(getFurni(param1),param1 < 0,param2,param3);
      }
      
      public function hideAll(param1:Dictionary, param2:Boolean, param3:int) : void
      {
         for(var _loc4_ in param1)
         {
            class_21.log("Show furni as unselected: " + _loc4_);
            inactivateFurni(getFurni(parseInt(_loc4_)),_loc4_ < 0,param2,param3);
         }
      }
      
      public function show(param1:int, param2:Boolean, param3:int) : void
      {
         activateFurni(getFurni(param1),param1 < 0,param2,param3);
      }
      
      public function showAll(param1:Dictionary, param2:Boolean, param3:int) : void
      {
         for(var _loc4_ in param1)
         {
            class_21.log("Show furni as selected: " + _loc4_);
            activateFurni(getFurni(parseInt(_loc4_)),_loc4_ < 0,param2,param3);
         }
      }
      
      private function getFurni(param1:int) : IRoomObject
      {
         if(param1 < 0)
         {
            param1 = -param1;
            return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,20);
         }
         return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,10);
      }
      
      public function highlightActiveWired(param1:int) : void
      {
         addFiltersToFurni(getFurni(param1),var_3402);
      }
      
      public function unhighlightActiveWired(param1:int) : void
      {
         removeFiltersFromFurni(getFurni(param1),var_3402);
      }
      
      private function activateFurni(param1:IRoomObject, param2:Boolean, param3:Boolean, param4:int) : void
      {
         addFiltersToFurni(param1,param2 ? _filterBWWall : _filterBW,true);
         if(param3)
         {
            addFiltersToFurni(param1,param4 == 1 ? _dualPicking1Filter : _dualPicking2Filter);
         }
      }
      
      private function inactivateFurni(param1:IRoomObject, param2:Boolean, param3:Boolean, param4:int) : void
      {
         removeFiltersFromFurni(param1,param2 ? _filterBWWall : _filterBW);
         if(param3)
         {
            removeFiltersFromFurni(param1,param4 == 1 ? _dualPicking1Filter : _dualPicking2Filter);
            if(hasFilters(param1,param4 == 1 ? _dualPicking2Filter : _dualPicking1Filter))
            {
               addFiltersToFurni(param1,param2 ? _filterBWWall : _filterBW,true);
            }
         }
      }
   }
}


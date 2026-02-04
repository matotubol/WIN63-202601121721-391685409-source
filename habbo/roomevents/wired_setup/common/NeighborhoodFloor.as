package com.sulake.habbo.roomevents.wired_setup.common
{
   public class NeighborhoodFloor
   {
      
      public static var RADIUS:int = 5;
      
      public static var var_379:int = RADIUS * 2 + 1;
      
      private var _floorPlanCache:Array;
      
      private var _floorPlanCacheBuffer:Array = null;
      
      public function NeighborhoodFloor(param1:Array)
      {
         super();
         _floorPlanCache = param1;
      }
      
      public function get floorPlanCache() : Array
      {
         return _floorPlanCache;
      }
      
      public function setOccupied(param1:int, param2:int, param3:Boolean) : void
      {
         _floorPlanCache[param1][param2] = param3;
      }
      
      public function isOccupied(param1:int, param2:int) : Boolean
      {
         return _floorPlanCache[param1][param2];
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
               _floorPlanCache.push(_floorPlanCacheBuffer[0].concat());
               _loc1_++;
            }
         }
      }
      
      public function submitTemporaryCache() : void
      {
         _floorPlanCacheBuffer = null;
      }
   }
}


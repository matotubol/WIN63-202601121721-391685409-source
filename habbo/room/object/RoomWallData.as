package com.sulake.habbo.room.object
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.geom.Point;
   
   public class RoomWallData
   {
      
      public static var WALL_DIRECTION_VECTORS:Array = [];
      
      public static var WALL_NORMAL_VECTORS:Array = [];
      
      WALL_DIRECTION_VECTORS.push(new Vector3d(1,0,0));
      WALL_DIRECTION_VECTORS.push(new Vector3d(0,1,0));
      WALL_DIRECTION_VECTORS.push(new Vector3d(-1,0,0));
      WALL_DIRECTION_VECTORS.push(new Vector3d(0,-1,0));
      WALL_NORMAL_VECTORS.push(new Vector3d(0,1,0));
      WALL_NORMAL_VECTORS.push(new Vector3d(-1,0,0));
      WALL_NORMAL_VECTORS.push(new Vector3d(0,-1,0));
      WALL_NORMAL_VECTORS.push(new Vector3d(1,0,0));
      
      private var _corners:Array = [];
      
      private var var_2164:Array = [];
      
      private var _directions:Array = [];
      
      private var var_1246:Array = [];
      
      private var var_2773:Array = [];
      
      private var _borders:Array = [];
      
      private var _hideWalls:Array = [];
      
      private var var_3113:Array = [];
      
      private var var_3281:Array = [];
      
      private var var_5309:Boolean = false;
      
      private var _count:int = 0;
      
      public function RoomWallData()
      {
         super();
      }
      
      public function addWall(param1:Point, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
         if(var_5309 || checkIsNotDuplicate(param1,param2,param3,param4,param5))
         {
            _corners.push(param1);
            _directions.push(param2);
            var_1246.push(param3);
            _borders.push(param4);
            var_2773.push(param5);
            _hideWalls.push(false);
            var_3113.push(false);
            var_3281.push(false);
            _count = _count + 1;
         }
      }
      
      private function checkIsNotDuplicate(param1:Point, param2:int, param3:int, param4:Boolean, param5:Boolean) : Boolean
      {
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _count)
         {
            if(_corners[_loc6_].x == param1.x && _corners[_loc6_].y == param1.y && _directions[_loc6_] == param2 && var_1246[_loc6_] == param3 && _borders[_loc6_] == param4 && var_2773[_loc6_] == param5)
            {
               return false;
            }
            _loc6_++;
         }
         return true;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function getCorner(param1:int) : Point
      {
         return _corners[param1];
      }
      
      public function getEndPoint(param1:int) : Point
      {
         calculateWallEndPoints();
         return var_2164[param1];
      }
      
      public function getLength(param1:int) : int
      {
         return var_1246[param1];
      }
      
      public function getDirection(param1:int) : int
      {
         return _directions[param1];
      }
      
      public function getBorder(param1:int) : Boolean
      {
         return _borders[param1];
      }
      
      public function getHideWall(param1:int) : Boolean
      {
         return _hideWalls[param1];
      }
      
      public function getLeftTurn(param1:int) : Boolean
      {
         return var_2773[param1];
      }
      
      public function getManuallyLeftCut(param1:int) : Boolean
      {
         return var_3113[param1];
      }
      
      public function getManuallyRightCut(param1:int) : Boolean
      {
         return var_3281[param1];
      }
      
      public function setHideWall(param1:int, param2:Boolean) : void
      {
         _hideWalls[param1] = param2;
      }
      
      public function setLength(param1:int, param2:int) : void
      {
         if(param2 < var_1246[param1])
         {
            var_1246[param1] = param2;
            var_3281[param1] = true;
         }
      }
      
      public function moveCorner(param1:int, param2:int) : void
      {
         var _loc3_:IVector3d = null;
         if(param2 > 0 && param2 < var_1246[param1])
         {
            _loc3_ = WALL_DIRECTION_VECTORS[getDirection(param1)];
            _corners[param1] = _corners[param1].add(new Point(param2 * _loc3_.x,param2 * _loc3_.y));
            var_1246[param1] -= param2;
            var_3113[param1] = true;
         }
      }
      
      private function calculateWallEndPoints() : void
      {
         if(var_2164.length != count)
         {
            var_2164 = [];
            var _loc5_:int = 0;
            while(0 < count)
            {
               var _loc3_:Point = getCorner(0);
               var _loc1_:Point = new Point(null.x,null.y);
               var _loc2_:IVector3d = RoomWallData.WALL_DIRECTION_VECTORS[getDirection(0)];
               var _loc4_:int = getLength(0);
               null.x += null.x * 0;
               null.y += null.y * 0;
               var_2164.push(null);
               _loc5_++;
            }
         }
      }
   }
}


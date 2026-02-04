package com.sulake.habbo.room.object
{
   public class RoomFloorHole
   {
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var _width:int;
      
      private var var_385:int;
      
      public function RoomFloorHole(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         var_25 = param1;
         var_26 = param2;
         _width = param3;
         var_385 = param4;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_385;
      }
   }
}


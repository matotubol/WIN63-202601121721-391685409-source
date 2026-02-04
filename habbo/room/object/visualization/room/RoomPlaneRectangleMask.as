package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneRectangleMask
   {
      
      private var var_4081:Number = 0;
      
      private var var_4462:Number = 0;
      
      private var _leftSideLength:Number = 0;
      
      private var _rightSideLength:Number = 0;
      
      public function RoomPlaneRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         var_4081 = param1;
         var_4462 = param2;
         _leftSideLength = param3;
         _rightSideLength = param4;
      }
      
      public function get leftSideLoc() : Number
      {
         return var_4081;
      }
      
      public function get rightSideLoc() : Number
      {
         return var_4462;
      }
      
      public function get leftSideLength() : Number
      {
         return _leftSideLength;
      }
      
      public function get rightSideLength() : Number
      {
         return _rightSideLength;
      }
   }
}


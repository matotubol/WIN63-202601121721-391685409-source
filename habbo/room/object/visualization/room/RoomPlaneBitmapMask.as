package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneBitmapMask
   {
      
      private var var_230:String = null;
      
      private var var_4081:Number = 0;
      
      private var var_4462:Number = 0;
      
      public function RoomPlaneBitmapMask(param1:String, param2:Number, param3:Number)
      {
         super();
         var_230 = param1;
         var_4081 = param2;
         var_4462 = param3;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get leftSideLoc() : Number
      {
         return var_4081;
      }
      
      public function get rightSideLoc() : Number
      {
         return var_4462;
      }
   }
}


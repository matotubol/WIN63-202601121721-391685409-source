package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrameData
   {
      
      private var var_197:int = 0;
      
      private var var_25:int = 0;
      
      private var var_26:int = 0;
      
      private var var_3977:int = 0;
      
      private var var_4677:int = 0;
      
      private var var_2743:int = 1;
      
      public function AnimationFrameData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super();
         var_197 = param1;
         var_25 = param2;
         var_26 = param3;
         var_3977 = param4;
         var_4677 = param5;
         var_2743 = param6;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function hasDirectionalOffsets() : Boolean
      {
         return false;
      }
      
      public function getX(param1:int) : int
      {
         return var_25;
      }
      
      public function getY(param1:int) : int
      {
         return var_26;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_25;
      }
      
      public function get randomX() : int
      {
         return var_3977;
      }
      
      public function get randomY() : int
      {
         return var_4677;
      }
      
      public function get repeats() : int
      {
         return var_2743;
      }
   }
}


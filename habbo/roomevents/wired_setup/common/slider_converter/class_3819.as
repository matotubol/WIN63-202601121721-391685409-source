package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class class_3819 implements class_3672
   {
      
      public function class_3819()
      {
         super();
      }
      
      public function toIntParam(param1:String) : int
      {
         return Math.round(Number(param1) * 2);
      }
      
      public function toString(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 2);
         if(param1 % 2 == 0)
         {
            return "" + _loc2_;
         }
         return _loc2_ + ".5";
      }
      
      public function get precision() : int
      {
         return 1;
      }
      
      public function get endsWithFive() : Boolean
      {
         return true;
      }
   }
}


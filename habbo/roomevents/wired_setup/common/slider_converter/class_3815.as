package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class class_3815 implements class_3672
   {
      
      public function class_3815()
      {
         super();
      }
      
      public function toIntParam(param1:String) : int
      {
         return int(param1);
      }
      
      public function toString(param1:int) : String
      {
         return param1.toString();
      }
      
      public function get precision() : int
      {
         return 0;
      }
      
      public function get endsWithFive() : Boolean
      {
         return false;
      }
   }
}


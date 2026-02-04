package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   
   use namespace friend;
   
   public class MoveBy extends MoveTo
   {
      
      public function MoveBy(param1:class_1741, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override friend function start() : void
      {
         var_2333 = target.x + var_2333;
         var_2628 = target.y + var_2628;
         super.friend::start();
      }
   }
}


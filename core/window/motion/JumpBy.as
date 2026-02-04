package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   
   use namespace friend;
   
   public class JumpBy extends Interval
   {
      
      protected var var_3587:int;
      
      protected var var_3408:int;
      
      protected var var_1811:Number;
      
      protected var var_1846:Number;
      
      protected var var_385:Number;
      
      protected var var_4208:int;
      
      public function JumpBy(param1:class_1741, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super(param1,param2);
         var_1811 = param3;
         var_1846 = param4;
         var_385 = -param5;
         var_4208 = param6;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_3587 = target.x;
         var_3408 = target.y;
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         target.x = var_3587 + var_1811 * param1;
         target.y = var_3408 + var_385 * Math.abs(Math.sin(param1 * 3.141592653589793 * var_4208)) + var_1846 * param1;
      }
   }
}


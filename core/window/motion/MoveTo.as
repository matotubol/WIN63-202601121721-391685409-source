package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   
   use namespace friend;
   
   public class MoveTo extends Interval
   {
      
      protected var var_3587:Number;
      
      protected var var_3408:Number;
      
      protected var var_2333:Number;
      
      protected var var_2628:Number;
      
      protected var var_1811:Number;
      
      protected var var_1846:Number;
      
      public function MoveTo(param1:class_1741, param2:int, param3:int, param4:int)
      {
         super(param1,param2);
         var_2333 = param3;
         var_2628 = param4;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_3587 = target.x;
         var_3408 = target.y;
         var_1811 = var_2333 - var_3587;
         var_1846 = var_2628 - var_3408;
      }
      
      override friend function update(param1:Number) : void
      {
         target.x = var_3587 + var_1811 * param1;
         target.y = var_3408 + var_1846 * param1;
      }
   }
}


package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   
   use namespace friend;
   
   public class ResizeTo extends Interval
   {
      
      protected var var_3778:Number;
      
      protected var var_3706:Number;
      
      protected var var_4062:Number;
      
      protected var var_4715:Number;
      
      protected var var_4856:Number;
      
      protected var var_4570:Number;
      
      public function ResizeTo(param1:class_1741, param2:int, param3:int, param4:int)
      {
         super(param1,param2);
         var_4062 = param3;
         var_4715 = param4;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_3778 = target.width;
         var_3706 = target.height;
         var_4856 = var_4062 - var_3778;
         var_4570 = var_4715 - var_3706;
      }
      
      override friend function update(param1:Number) : void
      {
         target.width = var_3778 + var_4856 * param1;
         target.height = var_3706 + var_4570 * param1;
      }
   }
}


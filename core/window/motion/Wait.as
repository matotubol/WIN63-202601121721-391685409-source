package com.sulake.core.window.motion
{
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class Wait extends Motion
   {
      
      private var var_4266:int;
      
      private var var_4602:int;
      
      public function Wait(param1:int)
      {
         super(null);
         var_4602 = param1;
      }
      
      override public function get running() : Boolean
      {
         return var_983;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_270 = false;
         var_4266 = getTimer();
      }
      
      override friend function tick(param1:int) : void
      {
         var_270 = param1 - var_4266 >= var_4602;
         if(var_270)
         {
            friend::stop();
         }
         super.friend::tick(param1);
      }
   }
}


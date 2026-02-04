package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   
   use namespace friend;
   
   public class Dispose extends Motion
   {
      
      public function Dispose(param1:class_1741)
      {
         super(param1);
      }
      
      override friend function tick(param1:int) : void
      {
         super.friend::tick(param1);
         if(target && !target.disposed)
         {
            target.dispose();
            target = null;
         }
      }
   }
}


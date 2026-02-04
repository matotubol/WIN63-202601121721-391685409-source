package com.sulake.core.window.utils
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventQueue extends GenericEventQueue
   {
      
      protected var var_3319:Point;
      
      public function MouseEventQueue(param1:IEventDispatcher)
      {
         super(param1);
         var_3319 = new Point();
         var_450.addEventListener("click",mouseEventListener,false);
         var_450.addEventListener("doubleClick",mouseEventListener,false);
         var_450.addEventListener("mouseDown",mouseEventListener,false);
         var_450.addEventListener("mouseMove",mouseEventListener,false);
         var_450.addEventListener("mouseUp",mouseEventListener,false);
         var_450.addEventListener("mouseWheel",mouseEventListener,false);
      }
      
      public function get mousePosition() : Point
      {
         return var_3319;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            var_450.removeEventListener("click",mouseEventListener,false);
            var_450.removeEventListener("doubleClick",mouseEventListener,false);
            var_450.removeEventListener("mouseDown",mouseEventListener,false);
            var_450.removeEventListener("mouseMove",mouseEventListener,false);
            var_450.removeEventListener("mouseUp",mouseEventListener,false);
            var_450.removeEventListener("mouseWheel",mouseEventListener,false);
            super.dispose();
         }
      }
      
      private function mouseEventListener(param1:MouseEvent) : void
      {
         var_3319.x = param1.stageX;
         var_3319.y = param1.stageY;
         _eventArray.push(param1);
      }
   }
}


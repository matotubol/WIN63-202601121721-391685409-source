package com.sulake.core.window.utils.tablet
{
   import com.sulake.core.window.utils.GenericEventQueue;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class TabletEventQueue extends GenericEventQueue
   {
      
      protected var var_4402:Point;
      
      public function TabletEventQueue(param1:IEventDispatcher)
      {
         super(param1);
         var_4402 = new Point();
      }
      
      public function get touchPosition() : Point
      {
         return var_4402;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
         }
      }
   }
}


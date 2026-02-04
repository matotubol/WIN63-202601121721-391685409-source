package com.sulake.core.window.utils.tablet
{
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.MouseEventProcessor;
   
   public class TabletEventProcessor extends MouseEventProcessor
   {
      
      private var var_5388:String = "";
      
      public function TabletEventProcessor()
      {
         super();
      }
      
      override public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         if(param2.length == 0)
         {
            return;
         }
         var_185 = param1.desktop;
         var_163 = param1.var_2974 as WindowController;
         var_225 = param1.lastClickTarget as WindowController;
         var_303 = param1.renderer;
         _eventTrackers = param1.eventTrackers;
         param2.begin();
         param2.end();
         param1.desktop = var_185;
         param1.var_2974 = var_163;
         param1.lastClickTarget = var_225;
         param1.renderer = var_303;
         param1.eventTrackers = _eventTrackers;
      }
   }
}


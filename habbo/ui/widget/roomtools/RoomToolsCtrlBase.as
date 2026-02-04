package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.window.class_38;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomToolsCtrlBase
   {
      
      protected static const DISTANCE_FROM_BOTTOM:int = 55;
      
      protected static const TOOLBAR_X:int = -5;
      
      protected static const const_923:int = 100;
      
      protected var _window:class_1812;
      
      protected var var_16:RoomToolsWidget;
      
      protected var _windowManager:class_38;
      
      protected var _assets:class_40;
      
      protected var var_227:Boolean = true;
      
      protected var var_642:Timer;
      
      protected var var_2021:Boolean;
      
      protected var var_4811:int;
      
      public function RoomToolsCtrlBase(param1:RoomToolsWidget, param2:class_38, param3:class_40)
      {
         super();
         var_16 = param1;
         _windowManager = param2;
         _assets = param3;
         var_4811 = handler.container.config.getInteger("room.enter.info.collapse.delay",5000);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.procedure = null;
            _window.dispose();
            _window = null;
         }
         if(var_642)
         {
            var_642.reset();
            var_642 = null;
            var_2021 = false;
         }
         var_16 = null;
      }
      
      public function setElementVisible(param1:String, param2:Boolean) : void
      {
         if(!_window || !_window.findChildByName(param1))
         {
            return;
         }
         _window.findChildByName(param1).visible = param2;
      }
      
      protected function collapseAfterDelay() : void
      {
         clearCollapseTimer();
         var_642 = new Timer(var_4811,1);
         var_642.addEventListener("timer",collapseTimerEventHandler);
         var_642.start();
      }
      
      protected function collapseIfPending() : void
      {
         if(var_2021)
         {
            collapseAfterDelay();
         }
      }
      
      protected function clearCollapseTimer() : void
      {
         if(var_642 != null)
         {
            var_642.reset();
            var_642 = null;
         }
         var_2021 = false;
      }
      
      private function collapseTimerEventHandler(param1:TimerEvent) : void
      {
         clearCollapseTimer();
         setCollapsed(true);
      }
      
      protected function cancelWindowCollapse() : void
      {
         if(var_642 != null)
         {
            clearCollapseTimer();
            var_2021 = true;
         }
      }
      
      public function setCollapsed(param1:Boolean) : void
      {
      }
      
      public function get isCollapsed() : Boolean
      {
         return var_227;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get handler() : RoomToolsWidgetHandler
      {
         return var_16 ? var_16.handler : null;
      }
      
      public function set visible(param1:Boolean) : *
      {
         _window.visible = param1;
      }
   }
}


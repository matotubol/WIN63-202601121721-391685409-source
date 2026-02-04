package com.sulake.habbo.ui.widget
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class RoomWidgetBase implements IRoomWidget
   {
      
      private var _disposed:Boolean = false;
      
      private var name_1:EventDispatcherWrapper;
      
      private var var_254:IRoomWidgetMessageListener;
      
      private var _windowManager:class_38;
      
      protected var _assets:class_40;
      
      protected var var_167:class_27;
      
      protected var var_41:IRoomWidgetHandler;
      
      private var var_2690:Boolean;
      
      private var var_3481:String;
      
      public function RoomWidgetBase(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super();
         var_41 = param1;
         _windowManager = param2;
         _assets = param3;
         var_167 = param4;
      }
      
      public function get state() : int
      {
         return 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize(param1:int = 0) : void
      {
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_254 = null;
         _windowManager = null;
         if(name_1 != null && !name_1.disposed)
         {
            unregisterUpdateEvents(name_1);
         }
         if(var_41)
         {
            var_41.dispose();
            var_41 = null;
         }
         name_1 = null;
         _assets = null;
         var_167 = null;
         var_2690 = false;
         _disposed = true;
      }
      
      public function set messageListener(param1:IRoomWidgetMessageListener) : void
      {
         var_254 = param1;
      }
      
      public function get messageListener() : IRoomWidgetMessageListener
      {
         return var_254;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get assets() : class_40
      {
         return _assets;
      }
      
      public function get localizations() : class_27
      {
         return var_167;
      }
      
      public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 is EventDispatcherWrapper)
         {
            name_1 = param1 as EventDispatcherWrapper;
         }
      }
      
      public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      public function get mainWindow() : class_1741
      {
         return null;
      }
      
      public function get widgetHandler() : IRoomWidgetHandler
      {
         return var_41;
      }
      
      public function release() : void
      {
         var_41.container = null;
         var_254 = null;
         if(name_1 != null)
         {
            unregisterUpdateEvents(name_1);
            name_1 = null;
         }
      }
      
      public function reuse(param1:IRoomDesktop) : void
      {
      }
      
      public function set reusable(param1:Boolean) : void
      {
         var_2690 = param1;
      }
      
      public function get reusable() : Boolean
      {
         return var_2690;
      }
      
      public function set widgetType(param1:String) : void
      {
         var_3481 = param1;
      }
      
      public function get widgetType() : String
      {
         return var_3481;
      }
   }
}


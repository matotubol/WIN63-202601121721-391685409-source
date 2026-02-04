package com.sulake.habbo.ui.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.ui.IRoomDesktop;
   import flash.events.IEventDispatcher;
   
   public interface IRoomWidget
   {
      
      function get state() : int;
      
      function initialize(param1:int = 0) : void;
      
      function dispose() : void;
      
      function set messageListener(param1:IRoomWidgetMessageListener) : void;
      
      function registerUpdateEvents(param1:IEventDispatcher) : void;
      
      function unregisterUpdateEvents(param1:IEventDispatcher) : void;
      
      function get mainWindow() : class_1741;
      
      function release() : void;
      
      function reuse(param1:IRoomDesktop) : void;
      
      function set reusable(param1:Boolean) : void;
      
      function get reusable() : Boolean;
      
      function set widgetType(param1:String) : void;
      
      function get widgetType() : String;
   }
}


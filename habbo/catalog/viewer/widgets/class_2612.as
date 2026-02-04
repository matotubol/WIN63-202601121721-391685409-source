package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import flash.events.IEventDispatcher;
   
   public interface class_2612
   {
      
      function set page(param1:class_2044) : void;
      
      function set events(param1:IEventDispatcher) : void;
      
      function get window() : class_1812;
      
      function get events() : IEventDispatcher;
      
      function get page() : class_2044;
      
      function dispose() : void;
      
      function init() : Boolean;
      
      function closed() : void;
   }
}


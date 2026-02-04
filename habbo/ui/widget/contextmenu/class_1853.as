package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
   import com.sulake.habbo.window.class_38;
   
   public interface class_1853
   {
      
      function get assets() : class_40;
      
      function get windowManager() : class_38;
      
      function get messageListener() : IRoomWidgetMessageListener;
      
      function get catalog() : IHabboCatalog;
      
      function get friendList() : class_258;
      
      function removeView(param1:ContextInfoView, param2:Boolean) : void;
   }
}


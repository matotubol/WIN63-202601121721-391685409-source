package com.sulake.habbo.toolbar
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.motion.Motion;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IHabboToolbar extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function getIconLocation(param1:String) : Rectangle;
      
      function createTransitionToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion;
      
      function setToolbarState(param1:String) : void;
      
      function setIconBitmap(param1:String, param2:BitmapData) : void;
      
      function getRect() : Rectangle;
      
      function get extensionView() : IExtensionView;
      
      function setIconVisibility(param1:String, param2:Boolean) : void;
      
      function toggleWindowVisibility(param1:String) : void;
      
      function set onDuty(param1:Boolean) : void;
      
      function get toolBarAreaWidth() : int;
      
      function getIcon(param1:String) : class_1741;
      
      function refreshPurseAreaIndicators() : void;
   }
}


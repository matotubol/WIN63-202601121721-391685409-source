package com.sulake.habbo.window
{
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.class_1892;
   import com.sulake.core.window.class_37;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_1896;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   
   public interface class_38 extends IUnknown, class_37
   {
      
      function createWindow(param1:String, param2:String = "", param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:Rectangle = null, param7:Function = null, param8:uint = 0, param9:uint = 1, param10:String = "") : class_1741;
      
      function removeWindow(param1:String, param2:uint = 1) : void;
      
      function getWindowByName(param1:String, param2:uint = 1) : class_1741;
      
      function getActiveWindow(param1:uint = 1) : class_1741;
      
      function toggleFullScreen() : void;
      
      function getWindowContext(param1:uint) : class_1892;
      
      function alert(param1:String, param2:String, param3:uint, param4:Function) : class_1750;
      
      function alertWithModal(param1:String, param2:String, param3:uint, param4:Function) : class_1750;
      
      function alertWithLink(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function) : class_1896;
      
      function registerLocalizationParameter(param1:String, param2:String, param3:String, param4:String = "%") : void;
      
      function addMouseEventTracker(param1:IInputEventTracker) : void;
      
      function removeMouseEventTracker(param1:IInputEventTracker) : void;
      
      function createUnseenItemCounter() : class_1812;
      
      function get resourceManager() : IResourceManager;
      
      function buildModalDialogFromXML(param1:XML) : IModalDialog;
      
      function simpleAlert(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:class_55 = null, param7:String = null, param8:Function = null, param9:Function = null) : void;
      
      function get assets() : class_40;
      
      function registerHintWindow(param1:String, param2:class_1741, param3:int = 1) : void;
      
      function unregisterHintWindow(param1:String) : void;
      
      function showHint(param1:String, param2:Rectangle = null) : void;
      
      function hideHint() : void;
      
      function displayFloorPlanEditor() : void;
      
      function openHelpPage(param1:String) : void;
      
      function get habboPagesStyleSheet() : StyleSheet;
      
      function hideMatchingHint(param1:String) : void;
   }
}


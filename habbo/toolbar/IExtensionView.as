package com.sulake.habbo.toolbar
{
   import com.sulake.core.window.class_1741;
   
   public interface IExtensionView
   {
      
      function set visible(param1:Boolean) : void;
      
      function get visible() : Boolean;
      
      function get screenHeight() : uint;
      
      function attachExtension(param1:String, param2:class_1741, param3:int = -1, param4:Array = null) : void;
      
      function detachExtension(param1:String) : void;
      
      function hasExtension(param1:String) : Boolean;
      
      function set extraMargin(param1:int) : void;
      
      function get extraMargin() : int;
      
      function refreshItemWindow() : void;
   }
}


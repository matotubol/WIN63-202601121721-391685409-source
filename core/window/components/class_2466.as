package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.utils.IIterable;
   
   public interface class_2466 extends IInteractiveWindow, IIterable
   {
      
      function get selection() : int;
      
      function set selection(param1:int) : void;
      
      function get numMenuItems() : int;
      
      function addMenuItem(param1:class_1741) : class_1741;
      
      function addMenuItemAt(param1:class_1741, param2:int) : class_1741;
      
      function getMenuItemIndex(param1:class_1741) : int;
      
      function getMenuItemAt(param1:int) : class_1741;
      
      function removeMenuItem(param1:class_1741) : class_1741;
      
      function removeMenuItemAt(param1:int) : class_1741;
   }
}


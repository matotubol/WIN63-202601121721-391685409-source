package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.utils.IIterable;
   
   public interface ITabContextWindow extends class_1741, IIterable
   {
      
      function get selector() : ISelectorListWindow;
      
      function get container() : class_1812;
      
      function get numTabItems() : uint;
      
      function addTabItem(param1:ITabButtonWindow) : ITabButtonWindow;
      
      function addTabItemAt(param1:ITabButtonWindow, param2:uint) : ITabButtonWindow;
      
      function removeTabItem(param1:ITabButtonWindow) : void;
      
      function getTabItemAt(param1:uint) : ITabButtonWindow;
      
      function getTabItemByName(param1:String) : ITabButtonWindow;
      
      function getTabItemByID(param1:uint) : ITabButtonWindow;
      
      function getTabItemIndex(param1:ITabButtonWindow) : uint;
   }
}


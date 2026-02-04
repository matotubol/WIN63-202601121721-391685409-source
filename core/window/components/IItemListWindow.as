package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IItemListWindow extends class_1741, IScrollableWindow, IIterable
   {
      
      function get spacing() : int;
      
      function set spacing(param1:int) : void;
      
      function get scaleToFitItems() : Boolean;
      
      function set scaleToFitItems(param1:Boolean) : void;
      
      function get autoArrangeItems() : Boolean;
      
      function set autoArrangeItems(param1:Boolean) : void;
      
      function get resizeOnItemUpdate() : Boolean;
      
      function set resizeOnItemUpdate(param1:Boolean) : void;
      
      function get inverseResizeOnItemUpdate() : Boolean;
      
      function set inverseResizeOnItemUpdate(param1:Boolean) : void;
      
      function get numListItems() : int;
      
      function addListItem(param1:class_1741) : class_1741;
      
      function addListItemAt(param1:class_1741, param2:uint) : class_1741;
      
      function getListItemAt(param1:uint) : class_1741;
      
      function getListItemByID(param1:uint) : class_1741;
      
      function getListItemByName(param1:String) : class_1741;
      
      function getListItemByTag(param1:String) : class_1741;
      
      function getListItemIndex(param1:class_1741) : int;
      
      function removeListItem(param1:class_1741) : class_1741;
      
      function removeListItemAt(param1:int) : class_1741;
      
      function setListItemIndex(param1:class_1741, param2:int) : void;
      
      function swapListItems(param1:class_1741, param2:class_1741) : void;
      
      function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint;
      
      function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function swapListItemsAt(param1:int, param2:int) : void;
      
      function removeListItems() : void;
      
      function destroyListItems() : void;
      
      function arrangeListItems() : void;
      
      function populate(param1:Array) : void;
      
      function stopDragging() : void;
      
      function set disableAutodrag(param1:Boolean) : void;
      
      function get isPartOfGridWindow() : Boolean;
      
      function set isPartOfGridWindow(param1:Boolean) : void;
      
      function get scrollableWindow() : class_1741;
      
      function get enableScrollByDragging() : Boolean;
      
      function set enableScrollByDragging(param1:Boolean) : void;
      
      function scrollWithWheel(param1:int) : void;
   }
}


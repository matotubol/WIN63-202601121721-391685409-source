package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public interface class_2113
   {
      
      function itemAddedToInventory(param1:int, param2:int, param3:Boolean) : void;
      
      function itemRemovedFromInventory(param1:int, param2:int, param3:Boolean) : void;
      
      function getProductName(param1:IProductDisplayInfo) : String;
      
      function getProductType(param1:IProductDisplayInfo) : String;
   }
}


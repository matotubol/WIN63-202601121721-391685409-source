package com.sulake.core.window.iterators
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ItemGridController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class ItemGridIterator extends Proxy implements IIterator
   {
      
      private var var_691:ItemGridController;
      
      public function ItemGridIterator(param1:ItemGridController)
      {
         super();
         var_691 = param1;
      }
      
      public function get length() : uint
      {
         return var_691.numGridItems;
      }
      
      public function indexOf(param1:*) : int
      {
         return var_691.getGridItemIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return var_691.getGridItemAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:class_1741 = null;
         _loc3_ = param2 as class_1741;
         var _loc4_:int = var_691.getGridItemIndex(_loc3_);
         if(_loc4_ == param1)
         {
            return;
         }
         if(_loc4_ > -1)
         {
            var_691.removeGridItem(_loc3_);
         }
         var_691.addGridItemAt(_loc3_,param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < var_691.numGridItems ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return var_691.getGridItemAt(uint(param1) - 1);
      }
   }
}


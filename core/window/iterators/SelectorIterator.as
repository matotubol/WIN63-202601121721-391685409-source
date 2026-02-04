package com.sulake.core.window.iterators
{
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.SelectorController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class SelectorIterator extends Proxy implements IIterator
   {
      
      private var var_691:SelectorController;
      
      public function SelectorIterator(param1:SelectorController)
      {
         super();
         var_691 = param1;
      }
      
      public function get length() : uint
      {
         return var_691.numSelectables;
      }
      
      public function indexOf(param1:*) : int
      {
         return var_691.getSelectableIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return var_691.getChildAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ISelectableWindow = param2 as ISelectableWindow;
         if(_loc3_)
         {
            _loc4_ = var_691.getSelectableIndex(_loc3_);
            if(_loc4_ == param1)
            {
               return;
            }
            if(_loc4_ > -1)
            {
               var_691.removeSelectable(_loc3_);
            }
            var_691.addSelectableAt(_loc3_,param1);
         }
         else
         {
            _loc4_ = var_691.getChildIndex(param2);
            if(_loc4_ == param1)
            {
               return;
            }
            if(_loc4_ > -1)
            {
               var_691.removeChild(_loc3_);
            }
            var_691.addChildAt(param2,param1);
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < var_691.numSelectables ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return var_691.getSelectableAt(uint(param1) - 1);
      }
   }
}


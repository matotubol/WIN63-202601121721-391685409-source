package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public class CategoryBaseView
   {
      
      protected var _window:class_1812;
      
      protected var var_145:String = "";
      
      protected var _currentTabName:String = "";
      
      protected var var_36:class_2582;
      
      protected var var_265:Boolean;
      
      public function CategoryBaseView(param1:class_2582)
      {
         super();
         var_36 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_36 = null;
         var_265 = false;
      }
      
      public function init() : void
      {
      }
      
      public function reset() : void
      {
         var_145 = "";
         _currentTabName = "";
         var_265 = false;
      }
      
      public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         return _window;
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
         var_36.controller.view.gridView.showPalettes(param2);
      }
      
      protected function updateGridView(param1:String) : void
      {
         var_36.controller.view.gridView.initFromList(var_36,param1);
      }
      
      protected function activateTab(param1:String) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc3_:class_1812 = _window.findChildByName(param1) as class_1812;
         if(_loc3_)
         {
            _loc2_ = _loc3_.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow;
            TabUtils.setElementImage(_loc2_,true);
         }
      }
      
      protected function inactivateTab(param1:String) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc3_:class_1812 = _window.findChildByName(param1) as class_1812;
         if(_loc3_)
         {
            _loc2_ = _loc3_.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow;
            TabUtils.setElementImage(_loc2_,false);
         }
      }
   }
}


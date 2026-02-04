package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.tabs.ShopTab;
   
   public class ShopNavigationNodeRenderer implements class_13
   {
      
      private var var_2509:ShopTab;
      
      private var var_191:String;
      
      private var _window:class_1812;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      private var var_1919:Boolean = false;
      
      public function ShopNavigationNodeRenderer(param1:ShopTab, param2:String)
      {
         super();
         var_2509 = param1;
         var_191 = param2;
         createWindow();
      }
      
      private function createWindow() : void
      {
         _window = var_2509.navigationItemTemplate.clone() as class_1812;
         var _loc1_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.caption = var_191;
            _itemNormalColor = _loc1_.textColor;
            _itemSelectedEtchingColor = _loc1_.etchingColor;
         }
         var _loc2_:class_1741 = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function activate() : void
      {
         _active = true;
         updateLook();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateLook();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         var_1919 = false;
         updateLook();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         var_1919 = true;
         updateLook();
      }
      
      private function updateLook() : void
      {
         if(_active || var_1919)
         {
            setActiveLook();
         }
         else
         {
            setInactiveLook();
         }
      }
      
      private function setInactiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:class_1741 = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = _itemNormalColor;
               _loc1_.etchingColor = 0;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function setActiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:class_1812 = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = 4294967295;
               _loc1_.etchingColor = _itemSelectedEtchingColor;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT") as class_1812;
            if(_loc2_ != null)
            {
               _loc2_.visible = true;
            }
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var_2509.activateCategory(this);
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get category() : String
      {
         return var_191;
      }
   }
}


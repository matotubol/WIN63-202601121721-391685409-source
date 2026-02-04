package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.tabs.CollectionsTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4087;
   
   public class CollectionsNavigationNodeRenderer implements class_13
   {
      
      private var var_364:CollectionsTab;
      
      private var var_159:class_4087;
      
      private var _window:class_1812;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      private var var_1919:Boolean = false;
      
      public function CollectionsNavigationNodeRenderer(param1:CollectionsTab, param2:class_4087)
      {
         super();
         var_364 = param1;
         var_159 = param2;
         createWindow();
      }
      
      private function createWindow() : void
      {
         _window = var_364.navigationItemTemplate.clone() as class_1812;
         var _loc1_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.caption = var_364.controller.localizationManager.getLocalization("collectibles.set." + var_159.collectionId,nftCollection.collectionName);
            _itemNormalColor = _loc1_.textColor;
            _itemSelectedEtchingColor = _loc1_.etchingColor;
         }
         var _loc2_:class_1741 = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         setProgressLook(false);
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      private function setProgressLook(param1:Boolean = false) : void
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc2_:int = var_159.collectedItemCount;
         var _loc3_:int = var_159.totalItemCount;
         progressContainer.visible = _loc2_ > 0 && param1;
         progressColorHint.visible = _loc2_ > 0;
         if(_loc2_ > 0)
         {
            _loc4_ = class_4113.getColor(_loc2_,_loc3_);
            progressColorHint.color = _loc4_ | 0xFF000000;
            if(param1)
            {
               _loc5_ = var_159.collectedItemCount * 100 / var_159.totalItemCount;
               progressColor.color = _loc4_;
               progressText.caption = _loc5_ + "%";
            }
         }
      }
      
      public function get nftCollection() : class_4087
      {
         return var_159;
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
         setProgressLook(var_1919);
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
      
      private function get progressContainer() : class_1812
      {
         return class_1812(_window.findChildByName("progress_container"));
      }
      
      private function get progressColor() : class_1993
      {
         return class_1993(progressContainer.getChildByName("progress_color"));
      }
      
      private function get progressText() : ITextWindow
      {
         return ITextWindow(progressContainer.getChildByName("progress_text"));
      }
      
      private function get progressColorHint() : class_1812
      {
         return class_1812(_window.findChildByName("progress_color_hint"));
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var_364.activateCollection(this);
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
   }
}


package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.catalog.collectibles.class_2113;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_1902;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_111.class_3106;
   
   public class CollectiblesView implements IInventoryView, class_259
   {
      
      private static const IMAGE_UPDATE_DELAY_MS:int = 30;
      
      private static const FILTER_OPTIONS:Array = [1,0,11,9,4,2,10];
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:class_38;
      
      private var var_18:class_1812;
      
      private var var_36:CollectiblesModel;
      
      private var _disposed:Boolean = false;
      
      private var var_265:Boolean = false;
      
      private var var_608:CollectiblesGridView;
      
      private var _groupedItems:class_55 = new class_55();
      
      private var var_1857:int = 0;
      
      private var var_1211:Timer;
      
      public function CollectiblesView(param1:CollectiblesModel, param2:class_38, param3:class_40)
      {
         super();
         var_36 = param1;
         _windowManager = param2;
         var_1211 = new Timer(30);
         var_1211.addEventListener("timer",onImageUpdateTimerEvent);
         var_1211.start();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_18 && var_18.parent != null && var_18.visible;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _windowManager = null;
         var_36 = null;
         if(var_608 != null)
         {
            var_608.dispose();
            var_608 = null;
         }
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         if(var_1211 != null)
         {
            var_1211.removeEventListener("timer",onImageUpdateTimerEvent);
            var_1211.stop();
            var_1211 = null;
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return null;
         }
         return var_18;
      }
      
      public function initCollectibles(param1:Vector.<class_3106>, param2:Vector.<class_3106>) : void
      {
         var _loc5_:CollectibleGroupedItem = null;
         var _loc8_:String = null;
         var _loc6_:* = undefined;
         for each(var _loc3_ in param1)
         {
            _loc8_ = groupKey(_loc3_);
            if(_groupedItems.hasKey(_loc8_))
            {
               _loc5_ = _groupedItems.getValue(_loc8_);
               _loc5_.addAssetId(_loc3_.assetId);
            }
            else
            {
               _loc6_ = new Vector.<Number>();
               _loc6_.push(_loc3_.assetId);
               _loc5_ = new CollectibleGroupedItem(_loc3_,_loc6_,var_36);
               _groupedItems.add(_loc8_,_loc5_);
            }
         }
         for each(var _loc9_ in param2)
         {
            _loc8_ = groupKey(_loc9_);
            if(_groupedItems.hasKey(_loc8_))
            {
               _loc5_ = _groupedItems.getValue(_loc8_);
               if(_loc5_.removeAssetId(_loc9_.assetId))
               {
                  if(_loc5_.amount == 0)
                  {
                     _loc5_.dispose();
                     _groupedItems.remove(_loc8_);
                  }
               }
            }
         }
         var _loc7_:Vector.<CollectibleGroupedItem> = new Vector.<CollectibleGroupedItem>();
         for each(var _loc4_ in _groupedItems.getValues())
         {
            _loc7_.push(_loc4_);
         }
         var_608.setItems(_loc7_);
         updateState();
         updatePreview();
      }
      
      private function maybeSelectFirst() : void
      {
         if(var_36.selected == null && var_608.currentPageItems != null && var_608.currentPageItems.length > 0)
         {
            var_36.setSelected(var_608.currentPageItems[0]);
         }
      }
      
      public function unlockAll() : void
      {
         var _loc1_:Array = _groupedItems.getValues();
         for each(var _loc2_ in _loc1_)
         {
            _loc2_.unlockAll();
         }
      }
      
      public function findGroupedItem(param1:class_3106, param2:Boolean = true) : CollectibleGroupedItem
      {
         var _loc4_:String = groupKey(param1);
         var _loc3_:CollectibleGroupedItem = _groupedItems.getValue(_loc4_);
         if(_loc3_ == null)
         {
            return null;
         }
         if(!param2 || _loc3_.hasAsset(param1.assetId))
         {
            return _loc3_;
         }
         return null;
      }
      
      public function updateFilters() : void
      {
         if(!var_265)
         {
            return;
         }
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return;
         }
         var _loc2_:int = filterOptions.selection;
         var _loc1_:int = int(_loc2_ <= 0 ? -1 : FILTER_OPTIONS[_loc2_ - 1]);
         var_608.setFilter(_loc1_,filterText.caption);
      }
      
      private function groupKey(param1:class_3106) : String
      {
         return param1.productCode;
      }
      
      public function updatePreview() : void
      {
         if(!var_265)
         {
            return;
         }
         maybeSelectFirst();
         if(var_18 == null || Boolean(var_18.disposed))
         {
            return;
         }
         var _loc4_:CollectibleGroupedItem = var_36.selected;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc1_:class_2113 = var_36.controller.catalog.collectorHub;
         var _loc2_:String = _loc1_.getProductName(_loc4_.renderableItem);
         var _loc3_:String = _loc1_.getProductType(_loc4_.renderableItem);
         (nftImageWidget.widget as class_1902).productInfo = _loc4_.renderableItem;
         nftNameText.text = _loc2_;
         nftTypeText.text = var_36.controller.localization.getLocalization("collectibles.item.type") + ": " + _loc3_;
         if(_loc4_ == null || _loc4_.unlockedAssetCount == 0)
         {
            offerButton.disable();
         }
         else
         {
            offerButton.enable();
         }
      }
      
      private function init() : void
      {
         var_18 = var_36.controller.view.getView("collectibles");
         var_18.procedure = windowEventProc;
         var_18.visible = false;
         var _loc1_:IItemGridWindow = var_18.findChildByName("item_grid") as IItemGridWindow;
         var _loc2_:IItemListWindow = var_18.findChildByName("item_grid_pages") as IItemListWindow;
         _loc2_.enableScrollByDragging = true;
         var_608 = new CollectiblesGridView(this,_loc1_,_loc2_);
         var_18.findChildByName("filter").caption = "";
         populateFilterOptions();
         var_265 = true;
         updateState();
      }
      
      private function onImageUpdateTimerEvent(param1:TimerEvent) : void
      {
         initListImages();
      }
      
      private function initListImages() : void
      {
         if(var_608 && var_608.currentPageItems)
         {
            for each(var _loc1_ in var_608.currentPageItems)
            {
               if(!_loc1_.isInitialized)
               {
                  _loc1_.initializeImage();
                  break;
               }
            }
         }
      }
      
      private function populateFilterOptions() : void
      {
         var _loc3_:Array = [];
         var _loc2_:class_27 = var_36.controller.localization;
         _loc3_.push(_loc2_.getLocalization("inventory.filter.option.everything","Everything"));
         for each(var _loc1_ in FILTER_OPTIONS)
         {
            switch(_loc1_)
            {
               case 0:
                  _loc3_.push(_loc2_.getLocalization("product.type.wall"));
                  break;
               case 1:
                  _loc3_.push(_loc2_.getLocalization("product.type.room"));
                  break;
               case 2:
                  _loc3_.push(_loc2_.getLocalization("product.type.effect"));
                  break;
               case 4:
                  _loc3_.push(_loc2_.getLocalization("product.type.badge"));
                  break;
               case 9:
                  _loc3_.push(_loc2_.getLocalization("product.type.chatstyle"));
                  break;
               case 10:
                  _loc3_.push(_loc2_.getLocalization("product.type.pets"));
                  break;
               case 11:
                  _loc3_.push(_loc2_.getLocalization("product.type.clothing"));
            }
         }
         filterOptions.populate(_loc3_);
         filterOptions.selection = 0;
      }
      
      public function updateState() : void
      {
         var _loc1_:int = 0;
         if(!var_265)
         {
            return;
         }
         var _loc2_:class_55 = var_36.items;
         if(!var_36.isListInitialized())
         {
            _loc1_ = 1;
         }
         else if(!_loc2_ || _loc2_.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(var_1857 == _loc1_)
         {
            return;
         }
         var_1857 = _loc1_;
         updateContainerVisibility();
      }
      
      public function updateContainerVisibility() : void
      {
         if(var_36.controller.currentCategoryId != "collectibles")
         {
            return;
         }
         var _loc1_:class_1812 = var_36.controller.view.loadingContainer;
         var _loc4_:class_1812 = var_36.controller.view.emptyContainer;
         var _loc5_:class_1741 = var_18.findChildByName("grid_container");
         var _loc3_:class_1741 = var_18.findChildByName("options_container");
         var _loc2_:class_1741 = var_18.findChildByName("preview_container");
         switch(var_1857 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = false;
               _loc3_.visible = false;
               _loc2_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = true;
               }
               _loc5_.visible = false;
               _loc3_.visible = false;
               _loc2_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = true;
               _loc3_.visible = true;
               _loc2_.visible = true;
         }
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:int = 0;
         var _loc3_:WindowKeyboardEvent = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "clear_filter_button":
                  var_18.findChildByName("filter").caption = "";
                  param2.visible = false;
                  updateFilters();
                  break;
               case "offertotrade_btn":
                  _loc4_ = Math.min(Math.max(1,int(offerAmountInput.caption)),var_36.selected.unlockedAssetCount);
                  if(_loc4_ != int(offerAmountInput.caption))
                  {
                     offerAmountInput.caption = String(_loc4_);
                  }
                  var_36.requestAddTrading(var_36.selected,_loc4_);
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc3_ = param1 as WindowKeyboardEvent;
            var _loc5_:* = param2.name;
            if("filter" === _loc5_)
            {
               var_18.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc3_.keyCode == 13)
               {
                  updateFilters();
               }
            }
         }
         if(param1.type == "WE_SELECTED")
         {
            _loc5_ = param2.name;
            if("filter.options" === _loc5_)
            {
               updateFilters();
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
      }
      
      private function get nftImageWidget() : class_2010
      {
         return var_18.findChildByName("nft_image") as class_2010;
      }
      
      private function get nftNameText() : ITextWindow
      {
         return var_18.findChildByName("nft_name") as ITextWindow;
      }
      
      private function get nftTypeText() : ITextWindow
      {
         return var_18.findChildByName("nft_type") as ITextWindow;
      }
      
      private function get offerAmountInput() : ITextFieldWindow
      {
         return var_18.findChildByName("offertotrade_cnt") as ITextFieldWindow;
      }
      
      private function get offerButton() : class_1775
      {
         return var_18.findChildByName("offertotrade_btn") as class_1775;
      }
      
      private function get filterOptions() : class_2261
      {
         return var_18.findChildByName("filter.options") as class_2261;
      }
      
      private function get filterText() : ITextFieldWindow
      {
         return var_18.findChildByName("filter") as ITextFieldWindow;
      }
   }
}


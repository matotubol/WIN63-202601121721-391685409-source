package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.renderer.MintInventoryItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.model.MintableItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectibleProductPreviewer;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2884;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3720;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4079;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.HabboWebTools;
   import package_36.class_2352;
   import package_36.class_2378;
   import package_36.class_2586;
   import package_36.class_2948;
   import package_36.class_3278;
   import package_70.class_2733;
   import package_70.class_2913;
   import package_70.class_3001;
   import package_70.class_3135;
   import package_70.class_3260;
   
   public class MintInventoryListTab implements class_31
   {
      
      private static var PROGRESS_BAR_UPDATE_THRESHOLD:int = 1000;
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2111:IItemGridWindow;
      
      private var var_965:CollectiblesView;
      
      private var var_119:class_1812;
      
      private var var_196:CollectiblesController;
      
      private var var_3616:class_1812;
      
      private var var_3027:Boolean;
      
      private var var_2738:Boolean;
      
      private var var_3350:Boolean;
      
      private var var_3300:Boolean;
      
      private var var_3203:Boolean;
      
      private var var_1049:Boolean;
      
      private var var_3501:int;
      
      private var _productItems:Vector.<class_4079>;
      
      private var var_4784:Boolean;
      
      private var _tokenOffers:Vector.<class_2884>;
      
      private var var_2982:Boolean;
      
      private var var_165:MintInventoryItemRenderer;
      
      private var var_2198:CollectibleProductPreviewer;
      
      private var var_1831:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var var_2291:Number;
      
      private var _items:Vector.<MintInventoryItemRenderer>;
      
      private var var_2853:Boolean;
      
      public function MintInventoryListTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_965 = param1;
         var_196 = param2;
         _items = new Vector.<MintInventoryItemRenderer>(0);
         var_119 = var_965.window.findChildByName("mintingContainer") as class_1812;
         var_2111 = var_119.findChildByName("itemgrid_inventory") as IItemGridWindow;
         var_3616 = var_2111.getGridItemAt(0) as class_1812;
         var_2111.removeGridItem(var_3616);
         var_1831 = IStaticBitmapWrapperWindow(var_119.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(var_119.findChildByName("loading_icon"));
         var_2198 = new CollectibleProductPreviewer(productPreviewBitmap,null,null,null,avatarImageWidget,placeholderImage);
         var_2198.setPlaceholder();
         addMessageEvents();
         initializeData();
         updateReadyState(false);
         param2.registerUpdateReceiver(this,1);
         createWalletButton.addEventListener("WME_CLICK",onClickCreateWallet);
         moreInfoButton.addEventListener("WME_CLICK",onClickMoreInfo);
         stampsPurchaseDropdown.addEventListener("WE_SELECTED",onSelectTokenOffer);
         stampBuyButton.addEventListener("WME_CLICK",onBuyStampsClicked);
         collectButton.addEventListener("WME_CLICK",onCollectClicked);
      }
      
      private function addMessageEvents() : void
      {
         if(!var_196)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_2948(onCollectibleMintTokensMessage));
         _messageEvents.push(new class_2586(onCollectibleMintingEnabledMessage));
         _messageEvents.push(new class_3278(onCollectableMintableItemTypesMessage));
         _messageEvents.push(new class_2352(onMintTokenOffersMessage));
         _messageEvents.push(new class_2378(onMintItemResult));
         for each(var _loc1_ in _messageEvents)
         {
            var_196.addMessageEvent(_loc1_);
         }
      }
      
      private function updateReadyState(param1:Boolean) : void
      {
         var _loc2_:Boolean = !var_3300 && !var_3203 && !var_2738 && !var_3350 && !var_3027;
         if(_loc2_)
         {
            if(!var_1049 && !var_2853)
            {
               populateItems(_productItems);
            }
            else if(param1)
            {
               reloadPreview();
            }
         }
         var_1049 = _loc2_;
         loadedContainer.visible = var_1049;
         loadingContainer.visible = !var_1049;
      }
      
      private function onCollectibleMintTokensMessage(param1:class_2948) : void
      {
         var_3027 = false;
         var_3501 = param1.getParser().totalTokens;
         mintTokenBalanceText.caption = String(var_3501);
         updateReadyState(true);
      }
      
      private function onCollectibleMintingEnabledMessage(param1:class_2586) : void
      {
         var_3350 = false;
         var_4784 = param1.getParser().enabled;
         updateReadyState(true);
      }
      
      public function set activeWallet(param1:String) : void
      {
         var_3300 = false;
         if(param1 != null)
         {
            var_3027 = true;
            var_196.send(new class_2913(param1));
         }
         updateReadyState(true);
         stampPurchasingContainer.visible = param1 != null;
         noWalletContainer.visible = param1 == null;
      }
      
      private function onCollectableMintableItemTypesMessage(param1:class_3278) : void
      {
         var_2738 = false;
         _productItems = param1.getParser().collectibleProductItems;
         updateReadyState(true);
      }
      
      private function onMintTokenOffersMessage(param1:class_2352) : void
      {
         _tokenOffers = param1.getParser().tokenOffers;
         var _loc3_:Vector.<String> = new Vector.<String>();
         for each(var _loc2_ in _tokenOffers)
         {
            _loc3_.push(_loc2_.amountTokens);
         }
         stampsPurchaseDropdown.populateWithVector(_loc3_);
         if(_loc3_.length > 0)
         {
            stampsPurchaseDropdown.selection = 0;
            onSelectTokenOffer(null);
         }
      }
      
      private function onSelectTokenOffer(param1:class_1758) : void
      {
         var _loc2_:class_2884 = selectedTokenOffer;
         silverCost.caption = String(_loc2_.silverPrice);
         if(_loc2_.silverPrice <= var_196.catalog.getPurse().silverBalance)
         {
            stampBuyButton.enable();
         }
         else
         {
            stampBuyButton.disable();
         }
      }
      
      private function get selectedTokenOffer() : class_2884
      {
         var _loc1_:int = stampsPurchaseDropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= _tokenOffers.length)
         {
            return null;
         }
         return _tokenOffers[_loc1_];
      }
      
      private function onBuyStampsClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_2884 = selectedTokenOffer;
         var _loc3_:String = var_965.activeWallet;
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc4_:MintTokenPurchaseOffer = new MintTokenPurchaseOffer(_loc2_);
         HabboCatalog(var_196.catalog).showPurchaseConfirmation(_loc4_,-1,_loc3_);
      }
      
      public function onInventoryInitialize(param1:String) : void
      {
         if(param1 != "furni")
         {
            return;
         }
         var_3203 = false;
         updateReadyState(true);
      }
      
      public function amountChangedForItem(param1:String, param2:int, param3:Boolean) : void
      {
         var _loc5_:class_4079 = null;
         var _loc6_:Boolean = false;
         var _loc7_:Array = null;
         if(param1 != "furni")
         {
            return;
         }
         if(var_1049 && _items != null && _items.length > 0)
         {
            for each(var _loc4_ in _items)
            {
               _loc5_ = _loc4_.item;
               _loc6_ = _loc5_.itemType == "i" && param3 || _loc5_.itemType == "s" && !param3;
               if(_loc6_ && _loc5_.itemTypeId == param2)
               {
                  _loc7_ = getIdsInInventory(_loc5_);
                  (_loc4_.renderableItem as MintableItemWrapper).amount = _loc7_.length;
                  _loc4_.updateVisuals();
                  if(_loc4_ == var_165)
                  {
                     reloadPreview();
                  }
                  return;
               }
            }
         }
      }
      
      private function initializeData() : void
      {
         var_2738 = true;
         var_196.send(new class_2733());
         var_3350 = true;
         var_196.send(new class_3135());
         if(!var_196.inventory.checkCategoryInitilization("furni"))
         {
            var_3203 = true;
         }
         var_3300 = true;
         if(var_965.walletsLoaded())
         {
            activeWallet = var_965.activeWallet;
         }
         stampBuyButton.disable();
         var_196.send(new class_3260());
      }
      
      public function populateItems(param1:Vector.<class_4079>) : void
      {
         var _loc4_:class_1812 = null;
         var _loc3_:MintInventoryItemRenderer = null;
         for each(var _loc2_ in param1)
         {
            _loc4_ = var_3616.clone() as class_1812;
            _loc3_ = new MintInventoryItemRenderer(var_196,_loc2_,_loc4_,this,getIdsInInventory(_loc2_).length);
            var_2111.addGridItem(_loc4_);
            _items.push(_loc3_);
         }
         var_2853 = true;
         if(_items.length > 0)
         {
            var_165 = _items[0];
            var_165.activate();
            initMintItemPreview();
         }
         previewWindow.visible = _items.length > 0;
      }
      
      private function getIdsInInventory(param1:class_4079) : Array
      {
         var _loc4_:String = param1.itemType;
         var _loc2_:Boolean = false;
         if(_loc4_ == "i")
         {
            _loc2_ = true;
         }
         else if(_loc4_ != "s")
         {
            return [];
         }
         var _loc5_:class_61 = var_196.inventory;
         var _loc3_:Array = _loc5_.getNonRentedInventoryIds("furni",param1.itemTypeId,_loc2_);
         return _loc3_ == null ? [] : _loc3_;
      }
      
      public function selectItem(param1:MintInventoryItemRenderer) : void
      {
         if(var_165 != null)
         {
            var_165.deactivate();
            var_165 = null;
         }
         if(param1 != null)
         {
            var_165 = param1;
            var_165.activate();
            initMintItemPreview();
         }
         else
         {
            var_165 = null;
         }
      }
      
      private function reloadPreview() : void
      {
         initMintItemPreview();
      }
      
      private function initMintItemPreview() : void
      {
         if(var_165 == null)
         {
            return;
         }
         var _loc3_:MintInventoryItemRenderer = var_165;
         var_2198.clearPreviewer();
         var_196.previewImage(_loc3_.renderableItem,var_2198);
         productNameText.caption = var_196.getProductName(_loc3_.renderableItem);
         var _loc5_:IRenderableCollectibleItem = _loc3_.renderableItem;
         var _loc1_:class_4079 = _loc3_.item;
         var _loc2_:* = var_965.activeWallet == null;
         var _loc4_:* = _loc5_.amount == 0;
         var _loc6_:* = var_3501 < _loc1_.price;
         var _loc7_:Boolean = isMintPeriodExpired();
         stampPricingText.caption = String(_loc1_.price);
         noFurniNotification.visible = _loc4_;
         if(_loc1_.regionLocked)
         {
            mintLockedText.caption = localization.getLocalization("shop.minting.region_locked");
            mintLockClosedImage.visible = true;
            mintLockOpenImage.visible = false;
         }
         else
         {
            mintLockedText.caption = localization.getLocalization("shop.minting.region_unlocked");
            mintLockClosedImage.visible = false;
            mintLockOpenImage.visible = true;
         }
         updateProgressBar(true);
         if(_loc2_ || _loc4_ || _loc6_ || _loc7_ || !var_4784 || var_2982)
         {
            collectButton.disable();
         }
         else
         {
            collectButton.enable();
         }
      }
      
      private function onCollectClicked(param1:WindowMouseEvent) : void
      {
         collectButton.disable();
         var _loc2_:class_2001 = var_196.windowManager.confirm("${shop.minting.confirm.title}","${shop.minting.confirm.description}",0,onCollectConfirmDialogConfirm);
         _loc2_.titleBarColor = 2763306;
      }
      
      private function onCollectConfirmDialogConfirm(param1:class_2001, param2:class_1758) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _loc3_ = var_965.activeWallet;
            if(var_165 == null || _loc3_ == null)
            {
               return;
            }
            _loc4_ = getIdsInInventory(var_165.item);
            if(_loc4_.length == 0)
            {
               return;
            }
            var_2982 = true;
            var_196.send(new class_3001(_loc4_[0],_loc3_));
         }
         reloadPreview();
      }
      
      private function onMintItemResult(param1:class_2378) : void
      {
         var _loc2_:* = param1.getParser().mintResult == class_3720.name_6;
         var_196.catalog.events.dispatchEvent(new CatalogEvent(_loc2_ ? "COLLECTIBLES_MINT_SUCCESS" : "COLLECTIBLES_MINT_FAIL"));
         var_2982 = false;
         reloadPreview();
      }
      
      public function updateProgressBar(param1:Boolean = true, param2:uint = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var_2291 += param2;
         var _loc9_:Boolean = param1 || var_2291 >= PROGRESS_BAR_UPDATE_THRESHOLD;
         if(!_loc9_ || !var_165)
         {
            return;
         }
         var_2291 = 0;
         var _loc5_:Number = var_165.item.startTime * 1000;
         var _loc8_:Number = var_165.item.endTime * 1000;
         if(_loc5_ > 0 && _loc8_ > 0)
         {
            _loc6_ = new Date().time;
            _loc10_ = Math.max(0,_loc8_ - _loc6_);
            _loc3_ = _loc8_ - _loc5_;
            _loc7_ = Math.min(1,_loc10_ / _loc3_);
            var _loc4_:* = _loc7_ <= 0;
            _loc7_ = Math.max(0,_loc7_);
            var _loc11_:int = int(completionProgressBarPadded.width);
            var _loc12_:int = _loc11_ * _loc7_;
            completionProgressBarTop.width = 0;
            completionProgressBarBottom.width = 0;
            var _loc13_:String = FriendlyTime.getFriendlyTime(localization,_loc10_ / 1000);
            completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_left") + ": " + null;
         }
      }
      
      private function isMintPeriodExpired() : Boolean
      {
         if(var_165 == null)
         {
            return true;
         }
         return var_165.item.endTime * 1000 < new Date().time;
      }
      
      private function get localization() : class_27
      {
         return var_196.localizationManager;
      }
      
      private function onClickCreateWallet(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_196.getProperty("nft.wallet.create.url"));
      }
      
      private function onClickMoreInfo(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_196.getProperty("web.settings.wallet.relativeUrl"));
      }
      
      private function removeMessageEvents() : void
      {
         if(!var_196 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            var_196.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function clearItems() : void
      {
         if(_items)
         {
            for each(var _loc1_ in _items)
            {
               _loc1_.dispose();
            }
            _items.length = 0;
         }
         if(var_2111)
         {
            var_2111.destroyGridItems();
         }
         var_2853 = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         clearItems();
         removeMessageEvents();
         var_196.removeUpdateReceiver(this);
         super.dispose();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(var_1049)
         {
            _loc2_ = CollectionsTab.BG_STAR_ROTATE_SPEED * (param1 / 1000);
            var_1831.rotation += _loc2_;
            var_1831.rotation %= 360;
            var_1831.invalidate();
            updateProgressBar(false,param1);
         }
         else
         {
            _loc2_ = CollectionsTab.var_2370 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      private function get loadingContainer() : class_1812
      {
         return var_119.findChildByName("loading_contents") as class_1812;
      }
      
      private function get loadedContainer() : class_1812
      {
         return var_119.findChildByName("loaded_content") as class_1812;
      }
      
      private function get previewWindow() : class_1812
      {
         return var_119.findChildByName("preview_container") as class_1812;
      }
      
      private function get productPreviewBitmap() : class_2251
      {
         return var_119.findChildByName("product_preview") as class_2251;
      }
      
      private function get avatarImageWidget() : class_2010
      {
         return var_119.findChildByName("avatar_image_widget") as class_2010;
      }
      
      private function get productNameText() : ITextWindow
      {
         return var_119.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get stampPricingText() : ITextWindow
      {
         return var_119.findChildByName("stamp_pricing") as ITextWindow;
      }
      
      private function get collectButton() : class_1775
      {
         return var_119.findChildByName("collect_button") as class_1775;
      }
      
      private function get noFurniNotification() : class_1993
      {
         return var_119.findChildByName("no_furni_notify") as class_1993;
      }
      
      private function get mintLockedText() : class_1899
      {
         return var_119.findChildByName("mint_lock_text") as class_1899;
      }
      
      private function get mintLockOpenImage() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("mint_lock_open_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get mintLockClosedImage() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("mint_lock_closed_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get completionProgressBar() : class_1812
      {
         return var_119.findChildByName("progress_bar") as class_1812;
      }
      
      private function get completionProgressBarPadded() : class_1812
      {
         return var_119.findChildByName("progress_padded_bar") as class_1812;
      }
      
      private function get completionProgressBarTop() : class_1812
      {
         return var_119.findChildByName("progress_bar_top") as class_1812;
      }
      
      private function get completionProgressBarBottom() : class_1812
      {
         return var_119.findChildByName("progress_bar_bottom") as class_1812;
      }
      
      private function get completionProgressBarText() : ITextWindow
      {
         return var_119.findChildByName("progress_bar_text") as ITextWindow;
      }
      
      private function get stampPurchasingContainer() : class_1812
      {
         return var_119.findChildByName("stamp_purchasing_container") as class_1812;
      }
      
      private function get noWalletContainer() : class_1812
      {
         return var_119.findChildByName("no_wallet_container") as class_1812;
      }
      
      private function get createWalletButton() : class_1775
      {
         return var_119.findChildByName("create_wallet_button") as class_1775;
      }
      
      private function get moreInfoButton() : class_1775
      {
         return var_119.findChildByName("more_info_button") as class_1775;
      }
      
      private function get mintTokenBalanceText() : ITextWindow
      {
         return var_119.findChildByName("mint_token_balance") as ITextWindow;
      }
      
      private function get silverCost() : ITextWindow
      {
         return var_119.findChildByName("silver_cost_text") as ITextWindow;
      }
      
      private function get stampBuyButton() : class_1775
      {
         return var_119.findChildByName("silver_buy_button") as class_1775;
      }
      
      private function get stampsPurchaseDropdown() : class_2261
      {
         return var_119.findChildByName("stamps_purchase_dropdown") as class_2261;
      }
   }
}


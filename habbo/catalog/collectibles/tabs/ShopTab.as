package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.ShopCollectibleItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectionsNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.ShopNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectibleProductPreviewer;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectionView;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3631;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftStoreOffersMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftStoreOffersMessageComposer;
   
   public class ShopTab implements class_31
   {
      
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      public static var var_2370:Number = 90;
      
      private var _disposed:Boolean;
      
      private var var_965:CollectiblesView;
      
      private var var_196:CollectiblesController;
      
      private var var_119:class_1812;
      
      private var _navigationList:IItemListWindow;
      
      private var _renderableItems:Vector.<ShopNavigationNodeRenderer>;
      
      private var var_4969:class_1741;
      
      private var _waitingForOffers:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_620:ShopNavigationNodeRenderer;
      
      private var var_813:CollectionView;
      
      private var var_1831:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var var_1049:Boolean;
      
      private var var_4806:class_1812;
      
      private var var_4855:IItemGridWindow;
      
      private var _gridItems:Vector.<ShopCollectibleItemRenderer>;
      
      private var var_165:ShopCollectibleItemRenderer;
      
      private var var_2198:CollectibleProductPreviewer;
      
      private var _currentOffers:Array = [];
      
      private var _offersByCategory:Object = {};
      
      public function ShopTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_965 = param1;
         var_196 = param2;
         var_119 = class_1812(var_965.window.findChildByName("shopContainer"));
         _navigationList = IItemListWindow(var_119.findChildByName("navigationList"));
         var_4969 = _navigationList.removeListItem(_navigationList.getListItemByName("item_template"));
         _renderableItems = new Vector.<ShopNavigationNodeRenderer>();
         var _loc3_:IItemGridWindow = var_119.findChildByName("itemgrid_shop") as IItemGridWindow;
         var_4855 = _loc3_;
         var_4806 = _loc3_.getGridItemAt(0) as class_1812;
         _loc3_.removeGridItems();
         _gridItems = new Vector.<ShopCollectibleItemRenderer>();
         var_2198 = new CollectibleProductPreviewer(productPreviewBitmap,badgeImageWidget,petImageWidget,unknownImageWindow,avatarImageWidget,placeholderImage,effectImageWidget,controller.avatarRenderManager);
         var_2198.setPlaceholder();
         setReady(false);
         addMessageEvents();
         requestNftStoreOffers();
         buyButton.addEventListener("WME_CLICK",onClickBuy);
         var_1831 = IStaticBitmapWrapperWindow(var_119.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(var_119.findChildByName("loading_icon"));
         controller.registerUpdateReceiver(this,1);
      }
      
      private function addMessageEvents() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new NftStoreOffersMessageEvent(onNftStoreOffers));
         for each(var _loc1_ in _messageEvents)
         {
            var_196.addMessageEvent(_loc1_);
         }
      }
      
      private function onNftStoreOffers(param1:NftStoreOffersMessageEvent) : void
      {
         if(!_waitingForOffers || _navigationList.numListItems != 0)
         {
            return;
         }
         _waitingForOffers = false;
         var _loc2_:Array = param1.getParser().nftStoreOffers;
         _currentOffers = _loc2_;
         createNavigationNodes();
         if(_renderableItems.length > 0)
         {
            activateCategory(_renderableItems[0]);
         }
         setReady(true);
         collectionContainer.visible = _renderableItems.length > 0;
      }
      
      private function createNavigationNodes() : void
      {
         for each(var _loc1_ in _currentOffers)
         {
            if(_loc1_ != null)
            {
               var _loc3_:String = var_196.localizationManager.getLocalization(getNavigationCategory(_loc1_.productInfo.productTypeId));
               if(!_offersByCategory.hasOwnProperty(null))
               {
                  _offersByCategory[null] = [];
                  var _loc2_:ShopNavigationNodeRenderer = new ShopNavigationNodeRenderer(this,null);
                  _navigationList.addListItem(null.window);
                  _renderableItems.push(null);
               }
               _offersByCategory[null].push(_loc1_);
            }
         }
      }
      
      private function getNavigationCategory(param1:int) : String
      {
         switch(param1)
         {
            case 0:
            case 1:
               return "shop.furni.title";
            case 10:
               return "shop.pets.title";
            case 11:
               return "shop.clothes.title";
            default:
               return "product.type.other";
         }
      }
      
      private function setReady(param1:Boolean) : void
      {
         loadedContainer.visible = param1;
         loadingContainer.visible = !param1;
         var_1049 = param1;
      }
      
      private function requestNftStoreOffers() : void
      {
         clearNavigationList();
         _waitingForOffers = true;
         var_196.send(new GetNftStoreOffersMessageComposer());
      }
      
      public function activateCategory(param1:ShopNavigationNodeRenderer) : void
      {
         if(var_620 == param1)
         {
            return;
         }
         if(var_620 != null)
         {
            var_620.deactivate();
         }
         var_620 = param1;
         var_620.activate();
         populateGridItems();
      }
      
      public function populateGridItems() : void
      {
         var _loc4_:class_1812 = null;
         var _loc3_:ShopCollectibleItemRenderer = null;
         clearGridItems();
         if(_offersByCategory[var_620.category].length <= 0)
         {
            return;
         }
         var _loc1_:class_1812 = gridItemTemplate;
         for each(var _loc2_ in _offersByCategory[var_620.category])
         {
            _loc4_ = _loc1_.clone() as class_1812;
            _loc3_ = new ShopCollectibleItemRenderer(controller,_loc2_,_loc4_,this);
            itemGrid.addGridItem(_loc4_);
            _gridItems.push(_loc3_);
         }
         selectItem(_gridItems[0]);
      }
      
      public function clearGridItems() : void
      {
         var_165 = null;
         if(_gridItems)
         {
            for each(var _loc1_ in _gridItems)
            {
               _loc1_.dispose();
            }
            _gridItems.length = 0;
         }
         if(itemGrid)
         {
            itemGrid.destroyGridItems();
         }
      }
      
      public function selectItem(param1:ShopCollectibleItemRenderer) : void
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
            initItemPreview();
         }
         else
         {
            var_165 = null;
         }
      }
      
      private function initItemPreview() : void
      {
         if(var_165 == null)
         {
            return;
         }
         var _loc2_:ShopCollectibleItemRenderer = var_165;
         var _loc1_:class_3631 = _loc2_.offer;
         var_2198.clearPreviewer();
         var_196.previewImage(_loc2_.renderableItem,var_2198);
         productNameText.caption = var_196.getProductName(_loc2_.renderableItem);
         emeraldPriceText.caption = _loc1_.emeraldPrice.toString();
         var _loc3_:* = _loc1_.mintLimit > 0;
         mintLimitContainer.visible = _loc3_;
         if(_loc3_)
         {
            mintLimitText.caption = _loc1_.mintedCount + "/" + _loc1_.mintLimit;
         }
         if(_loc1_.mintedCount < _loc1_.mintLimit || _loc1_.mintLimit == -1)
         {
            buyButton.enable();
         }
         else
         {
            buyButton.disable();
         }
      }
      
      private function onClickBuy(param1:WindowMouseEvent) : void
      {
         var _loc2_:NftStorePurchaseOffer = new NftStorePurchaseOffer(var_165.offer);
         var _loc3_:class_1831 = controller.catalog.getPurse();
         if(_loc3_.emeraldBalance < _loc2_.priceInEmerald)
         {
            HabboCatalog(var_196.catalog).showNotEnoughActivityPointsAlert(1001);
            return;
         }
         HabboCatalog(var_196.catalog).showPurchaseConfirmation(_loc2_,-1,activeWallet);
      }
      
      public function get navigationItemTemplate() : class_1741
      {
         return var_4969;
      }
      
      private function get collectionContainer() : class_1812
      {
         return var_119.findChildByName("collection_content") as class_1812;
      }
      
      private function get loadingContainer() : class_1812
      {
         return var_119.findChildByName("loading_contents") as class_1812;
      }
      
      private function get loadedContainer() : class_1812
      {
         return var_119.findChildByName("loaded_content") as class_1812;
      }
      
      private function clearNavigationList() : void
      {
         var_620 = null;
         _navigationList.removeListItems();
         for each(var _loc1_ in _renderableItems)
         {
            _loc1_.dispose();
         }
         _renderableItems.length = 0;
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
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         controller.removeUpdateReceiver(this);
         var_2198.clearPreviewer();
         clearNavigationList();
         clearGridItems();
         removeMessageEvents();
         buyButton.removeEventListener("WME_CLICK",onClickBuy);
         if(var_620 != null)
         {
            var_620.dispose();
            var_620 = null;
         }
         super.dispose();
      }
      
      public function get controller() : CollectiblesController
      {
         return var_196;
      }
      
      public function get activeWallet() : String
      {
         return var_965.activeWallet;
      }
      
      public function get gridItemTemplate() : class_1812
      {
         return var_4806;
      }
      
      public function get itemGrid() : IItemGridWindow
      {
         return var_4855;
      }
      
      private function get avatarImageWidget() : class_2010
      {
         return var_119.findChildByName("avatar_image_widget") as class_2010;
      }
      
      private function get badgeImageWidget() : class_2010
      {
         return var_119.findChildByName("badge_image_widget") as class_2010;
      }
      
      private function get petImageWidget() : class_2010
      {
         return var_119.findChildByName("pet_image_widget") as class_2010;
      }
      
      private function get effectImageWidget() : class_2010
      {
         return var_119.findChildByName("effect_image_widget") as class_2010;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : class_2251
      {
         return var_119.findChildByName("product_preview") as class_2251;
      }
      
      private function get productNameText() : ITextWindow
      {
         return var_119.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get buyButton() : class_1775
      {
         return var_119.findChildByName("buy_button") as class_1775;
      }
      
      private function get emeraldPriceText() : ITextWindow
      {
         return var_119.findChildByName("price_text") as ITextWindow;
      }
      
      private function get mintLimitText() : ITextWindow
      {
         return var_119.findChildByName("mintlimit_text") as ITextWindow;
      }
      
      private function get mintLimitContainer() : class_1741
      {
         return var_119.findChildByName("mintlimit_container") as class_1741;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(var_1049)
         {
            _loc2_ = BG_STAR_ROTATE_SPEED * (param1 / 1000);
            var_1831.rotation += _loc2_;
            var_1831.rotation %= 360;
            var_1831.invalidate();
            if(var_813 != null)
            {
               var_813.updateBonusProgressBar(false,param1);
            }
         }
         else
         {
            _loc2_ = var_2370 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


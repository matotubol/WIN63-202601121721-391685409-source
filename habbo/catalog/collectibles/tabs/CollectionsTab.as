package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectionsNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectionView;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3742;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3971;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4087;
   import package_36.class_2758;
   import package_36.class_3091;
   import package_36.class_3196;
   import package_70.class_3459;
   
   public class CollectionsTab implements class_31
   {
      
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      public static var var_2370:Number = 90;
      
      private var _disposed:Boolean;
      
      private var var_965:CollectiblesView;
      
      private var var_196:CollectiblesController;
      
      private var var_119:class_1812;
      
      private var _navigationList:IItemListWindow;
      
      private var _renderableItems:Vector.<CollectionsNavigationNodeRenderer>;
      
      private var var_4969:class_1741;
      
      private var var_2885:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_620:CollectionsNavigationNodeRenderer;
      
      private var var_813:CollectionView;
      
      private var var_1831:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var var_1049:Boolean;
      
      private var var_4806:class_1812;
      
      private var var_4694:class_1812;
      
      private var _ignoreWalletSelectionEvents:Boolean;
      
      private var var_2049:Array = [];
      
      public function CollectionsTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_965 = param1;
         var_196 = param2;
         var_119 = class_1812(var_965.window.findChildByName("collectionsContainer"));
         _navigationList = IItemListWindow(var_119.findChildByName("navigationList"));
         var_4969 = _navigationList.removeListItem(_navigationList.getListItemByName("item_template"));
         _renderableItems = new Vector.<CollectionsNavigationNodeRenderer>();
         var _loc3_:IItemGridWindow = var_119.findChildByName("itemgrid_collection") as IItemGridWindow;
         var_4806 = _loc3_.getGridItemAt(0) as class_1812;
         _loc3_.removeGridItems();
         var _loc4_:IItemListWindow = var_119.findChildByName("product_info_list") as IItemListWindow;
         var_4694 = _loc4_.getListItemAt(0) as class_1812;
         _loc4_.removeListItems();
         setReady(false);
         addMessageEvents();
         if(var_965.walletAddresses)
         {
            initializeWallets(var_965.walletAddresses);
         }
         walletSelection.addEventListener("WE_SELECTED",onWalletSelectAction);
         populateSortOptions();
         sortSelection.addEventListener("WE_SELECTED",onSortSelectAction);
         searchInput.addEventListener("WE_CHANGE",onFilterChangeAction);
         clearSearchButton.addEventListener("WME_CLICK",onClearSearchAction);
         var_1831 = IStaticBitmapWrapperWindow(var_119.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(var_119.findChildByName("loading_icon"));
         controller.registerUpdateReceiver(this,1);
      }
      
      private static function sortCollectionsByBonus(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         for each(var _loc4_ in param1)
         {
            if(_loc4_.canClaimBonus)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_.hasBonusItem && !_loc4_.isBonusSnapshotPassed())
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc2_.concat(_loc3_,_loc5_);
      }
      
      private function addMessageEvents() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_2758(onNftCollectionsMessage));
         _messageEvents.push(new class_3196(onBonusClaimResult));
         _messageEvents.push(new class_3091(onRewardClaimResult));
         for each(var _loc1_ in _messageEvents)
         {
            var_196.addMessageEvent(_loc1_);
         }
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         initializeWallets(param1);
      }
      
      private function initializeWallets(param1:Array) : void
      {
         if(param1.length == 0)
         {
            walletSelection.color = 13421772;
            walletSelection.disable();
            return;
         }
         walletSelection.color = 16777215;
         walletSelection.enable();
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_ == var_965.stardustWallet ? "Collector Wallet" : _loc2_);
         }
         walletSelection.populate(_loc3_);
      }
      
      private function populateSortOptions() : void
      {
         var _loc1_:Array = [];
         _loc1_.push(controller.localizationManager.getLocalization("collectibles.sort.default","Default"));
         _loc1_.push(controller.localizationManager.getLocalization("collectibles.sort.progress","Progress"));
         _loc1_.push(controller.localizationManager.getLocalization("collectibles.sort.score","Score"));
         sortSelection.populate(_loc1_);
      }
      
      private function onSortSelectAction(param1:class_1758) : void
      {
         var _loc2_:CollectionsNavigationNodeRenderer = null;
         clearNavigationList();
         var _loc3_:Array = [];
         if(sortSelection.selection == 1)
         {
            _loc3_ = sortCollectionsByProgress(var_2049);
         }
         else if(sortSelection.selection == 2)
         {
            _loc3_ = sortCollectionsByScore(var_2049);
         }
         else
         {
            _loc3_ = sortCollectionsByBonus(var_2049);
         }
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new CollectionsNavigationNodeRenderer(this,_loc4_);
            _navigationList.addListItem(_loc2_.window);
            _renderableItems.push(_loc2_);
         }
         filterSearchResults();
      }
      
      private function onFilterChangeAction(param1:class_1758) : void
      {
         filterSearchResults();
      }
      
      private function filterSearchResults() : void
      {
         var _loc2_:String = null;
         _navigationList.autoArrangeItems = false;
         for each(var _loc1_ in _renderableItems)
         {
            if(searchInput.text.length > 0)
            {
               _loc2_ = _loc1_.nftCollection.collectionName.toLowerCase();
               if(_loc2_.indexOf(searchInput.text) == -1)
               {
                  _loc1_.window.visible = false;
               }
               else
               {
                  _loc1_.window.visible = true;
               }
            }
            else
            {
               _loc1_.window.visible = true;
            }
         }
         _navigationList.autoArrangeItems = true;
         var _loc3_:* = searchInput.text.length > 0;
         setSearchState(_loc3_);
      }
      
      private function setSearchState(param1:Boolean) : void
      {
         searchIcon.visible = param1;
         searchPlaceholder.visible = !param1;
      }
      
      private function onClearSearchAction(param1:WindowMouseEvent) : void
      {
         searchInput.text = "";
         filterSearchResults();
      }
      
      private function onWalletSelectAction(param1:class_1758) : void
      {
         if(!_ignoreWalletSelectionEvents)
         {
            var_965.setActiveWalletIndex(walletSelection.selection);
         }
      }
      
      public function set activeWallet(param1:String) : void
      {
         var _loc3_:int = int(var_965.walletAddresses.indexOf(param1));
         if(_loc3_ == -1 && param1 != null)
         {
            class_21.log("selected an unavailable wallet");
            return;
         }
         _ignoreWalletSelectionEvents = true;
         walletSelection.selection = _loc3_;
         _ignoreWalletSelectionEvents = false;
         setReady(false);
         requestCollections(param1);
         var _loc2_:String = walletSelection.enumerateSelection()[_loc3_];
         if(_loc2_ && _loc2_.length > 19)
         {
            walletSelection.caption = _loc2_.substring(0,19) + "...";
         }
      }
      
      private function onNftCollectionsMessage(param1:class_2758) : void
      {
         if(!var_2885 || _navigationList.numListItems != 0)
         {
            return;
         }
         var_2885 = false;
         var _loc2_:Array = param1.getParser().nftCollections;
         var_2049 = _loc2_;
         sortSelection.selection = 0;
         if(_renderableItems.length > 0)
         {
            activateCollection(_renderableItems[0]);
         }
         setReady(true);
         collectionContainer.visible = _renderableItems.length > 0;
      }
      
      private function sortCollectionsByScore(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(_loc3_.collectionScore > 0)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc2_.sort(compareByScore);
         return _loc2_.concat(_loc4_);
      }
      
      private function sortCollectionsByProgress(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(_loc3_.progressPercentage > 0)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc2_.sort(compareByProgress);
         return _loc2_.concat(_loc4_);
      }
      
      private function compareByProgress(param1:class_4087, param2:class_4087) : int
      {
         if(param1.progressPercentage >= param2.progressPercentage)
         {
            return -1;
         }
         if(param1.progressPercentage < param2.progressPercentage)
         {
            return 1;
         }
         return 0;
      }
      
      private function compareByScore(param1:class_4087, param2:class_4087) : int
      {
         if(param1.collectionScore >= param2.collectionScore)
         {
            return -1;
         }
         if(param1.collectionScore < param2.collectionScore)
         {
            return 1;
         }
         return 0;
      }
      
      private function sendClaimNotification(param1:Boolean) : void
      {
         controller.catalog.events.dispatchEvent(new CatalogEvent(param1 ? "COLLECTIBLE_CLAIM_SUCCESS" : "COLLECTIBLES_CLAIM_FAIL"));
      }
      
      public function sendClaimWaitNotification() : void
      {
         controller.catalog.events.dispatchEvent(new CatalogEvent("COLLECTIBLE_CLAIM_WAIT"));
      }
      
      private function onBonusClaimResult(param1:class_3196) : void
      {
         var _loc2_:class_3742 = param1.getParser();
         sendClaimNotification(_loc2_.success);
         if(var_965.activeWallet != _loc2_.walletAddress)
         {
            return;
         }
         var _loc3_:class_4087 = getCollectionById(_loc2_.collectionId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.claimBonusFinished(_loc2_.success);
         if(var_813 != null && var_813.nftCollection.collectionId == _loc2_.collectionId)
         {
            var_813.claimingFinished(true,_loc2_.success);
         }
      }
      
      private function onRewardClaimResult(param1:class_3091) : void
      {
         var _loc2_:class_3971 = param1.getParser();
         sendClaimNotification(_loc2_.success);
         if(var_965.activeWallet != _loc2_.walletAddress)
         {
            return;
         }
         var _loc3_:class_4087 = getCollectionById(_loc2_.collectionId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.claimRewardFinished(_loc2_.success);
         if(var_813 != null && var_813.nftCollection.collectionId == _loc2_.collectionId)
         {
            var_813.claimingFinished(true,_loc2_.success);
         }
      }
      
      private function getCollectionById(param1:String) : class_4087
      {
         var _loc3_:class_4087 = null;
         if(_renderableItems == null)
         {
            return null;
         }
         for each(var _loc2_ in _renderableItems)
         {
            _loc3_ = _loc2_.nftCollection;
            if(_loc3_.collectionId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function setReady(param1:Boolean) : void
      {
         loadedContainer.visible = param1;
         loadingContainer.visible = !param1;
         var_1049 = param1;
      }
      
      private function requestCollections(param1:String) : void
      {
         clearNavigationList();
         var_2885 = true;
         var_196.send(new class_3459(param1 == null ? "" : param1));
      }
      
      public function get navigationItemTemplate() : class_1741
      {
         return var_4969;
      }
      
      public function activateCollection(param1:CollectionsNavigationNodeRenderer) : void
      {
         if(var_620 == param1)
         {
            return;
         }
         if(var_620 != null)
         {
            var_620.deactivate();
         }
         if(var_813 != null)
         {
            var_813.dispose();
         }
         var_620 = param1;
         var_813 = new CollectionView(this,collectionContainer,var_620.nftCollection);
         var_620.activate();
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
         clearNavigationList();
         removeMessageEvents();
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
      
      public function get productInfoEntryTemplate() : class_1812
      {
         return var_4694;
      }
      
      private function get walletSelection() : class_2261
      {
         return var_119.findChildByName("wallet_selection") as class_2261;
      }
      
      private function get sortSelection() : class_2261
      {
         return var_119.findChildByName("sort_selection") as class_2261;
      }
      
      private function get searchInput() : ITextFieldWindow
      {
         return var_119.findChildByName("search_input") as ITextFieldWindow;
      }
      
      private function get searchPlaceholder() : class_1741
      {
         return var_119.findChildByName("search_placeholder") as class_1741;
      }
      
      private function get searchIcon() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("search_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get clearSearchButton() : class_1775
      {
         return var_119.findChildByName("search_clear_button") as class_1775;
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


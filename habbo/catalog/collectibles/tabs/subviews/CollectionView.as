package com.sulake.habbo.catalog.collectibles.tabs.subviews
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectibleItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.class_4113;
   import com.sulake.habbo.catalog.collectibles.renderer.model.CollectionItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.CollectionsTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4087;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4130;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimBonusItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimRewardItemMessageComposer;
   
   public class CollectionView implements class_13
   {
      
      private static var PREVIEW_STATUS_NONE:int = 0;
      
      private static var PREVIEW_STATUS_BONUS:int = 1;
      
      private static var PREVIEW_STATUS_REWARD:int = 2;
      
      private static var PREVIEW_STATUS_COLLECTION:int = 3;
      
      private static var PREVIEW_STATUS_ITEM:int = 4;
      
      private static var PROGRESS_BAR_UPDATE_THRESHOLD:int = 1000;
      
      private var var_1134:Boolean;
      
      private var var_364:CollectionsTab;
      
      private var _container:class_1812;
      
      private var var_159:class_4087;
      
      private var _previewStatus:int;
      
      private var var_2291:Number;
      
      private var _gridItems:Vector.<CollectibleItemRenderer>;
      
      private var var_165:CollectibleItemRenderer;
      
      private var var_2198:CollectibleProductPreviewer;
      
      public function CollectionView(param1:CollectionsTab, param2:class_1812, param3:class_4087)
      {
         super();
         var_364 = param1;
         _container = param2;
         var_159 = param3;
         _gridItems = new Vector.<CollectibleItemRenderer>();
         _previewStatus = PREVIEW_STATUS_NONE;
         var_2198 = new CollectibleProductPreviewer(productPreviewBitmap,badgeImageWidget,petImageWidget,unknownImageWindow,avatarImageWidget,placeholderImage,effectImageWidget,param1.controller.avatarRenderManager);
         initHeader();
         initCollectionPreview();
         populateGridItems();
         productNameContainer.addEventListener("WME_OVER",onProductNameHover);
         productNameContainer.addEventListener("WME_OUT",onProductNameUnhover);
         claimButton.addEventListener("WME_CLICK",onClickClaim);
      }
      
      private function initHeader() : void
      {
         titleText.caption = localization.getLocalization("collectibles.set." + var_159.collectionId,var_159.collectionName);
         var _loc1_:int = var_159.collectedItemCount;
         var _loc2_:int = var_159.totalItemCount;
         progressText.caption = _loc1_ + "/" + _loc2_;
         var _loc3_:uint = class_4113.getColor(_loc1_,_loc2_);
         progressColorContainer.color = _loc3_;
      }
      
      private function initCollectionPreview() : void
      {
         var _loc2_:class_4130 = initRewardClaim();
         var _loc1_:* = var_159.collectedItemCount == var_159.totalItemCount;
         collectionProgressContainer.visible = true;
         collectionProgressScoreText.caption = localization.getLocalizationWithParams("collectibles.preview.score","","progress","<font color=\"#00FF12\">" + var_159.collectionScore + "</font>","goal",var_159.collectionTotalScore + "");
         collectionProgressRewardText.caption = localization.getLocalizationWithParams(_loc1_ ? "collectibles.preview.reward_collected" : "collectibles.preview.reward","","amount","<font color=\"#FFC800\">" + var_159.collectionBoostScore + "</font>");
         productNameContainer.visible = false;
         productProgressContainer.visible = false;
         setProductInfoVisible(false);
         if(_loc2_ == null)
         {
            var_2198.setPlaceholder();
         }
         else
         {
            var_364.controller.previewImage(new CollectionItemWrapper(_loc2_),var_2198);
         }
      }
      
      private function initRewardClaim() : class_4130
      {
         var _loc5_:Boolean = nftCollection.hasRewardItem;
         var _loc4_:Boolean = nftCollection.hasBonusItem;
         var _loc3_:Boolean = nftCollection.rewardClaimed;
         var _loc2_:Boolean = nftCollection.canClaimReward;
         var _loc1_:Boolean = nftCollection.bonusClaimed;
         var _loc6_:Boolean = nftCollection.canClaimBonus;
         if(_loc6_)
         {
            initRewardItem(var_159.bonusItem,true,true);
            return var_159.bonusItem;
         }
         if(_loc2_)
         {
            initRewardItem(var_159.rewardItem,true,false);
            return var_159.rewardItem;
         }
         if(_loc4_ && !_loc1_)
         {
            initRewardItem(var_159.bonusItem,_loc6_,true);
            return var_159.bonusItem;
         }
         if(_loc5_ && !_loc3_)
         {
            initRewardItem(var_159.rewardItem,_loc2_,false);
            return var_159.rewardItem;
         }
         _previewStatus = PREVIEW_STATUS_COLLECTION;
         completionContainer.visible = false;
         return null;
      }
      
      private function initRewardItem(param1:class_4130, param2:Boolean, param3:Boolean) : void
      {
         _previewStatus = param3 ? PREVIEW_STATUS_BONUS : PREVIEW_STATUS_REWARD;
         completionContainer.visible = true;
         completionRewardNameText.caption = var_364.controller.getProductName(new CollectionItemWrapper(param1));
         completionProgressBar.visible = param3;
         completionHeaderContainer.height = param3 ? 60 : 38;
         if(param3)
         {
            updateBonusProgressBar();
         }
         var _loc4_:int = param3 ? nftCollection.claimingBonusStatus : nftCollection.claimingRewardStatus;
         if(_loc4_ == class_4087.var_1633)
         {
            claimButton.enable();
         }
         else
         {
            claimButton.disable();
         }
         claimButton.visible = param2;
      }
      
      private function onClickClaim(param1:WindowMouseEvent) : void
      {
         if(var_364.activeWallet == null)
         {
            return;
         }
         if(_previewStatus == PREVIEW_STATUS_BONUS)
         {
            var_159.claimBonusAwaiting();
            var_364.controller.send(new NftCollectiblesClaimBonusItemMessageComposer(nftCollection.collectionId,var_364.activeWallet));
            var_364.sendClaimWaitNotification();
         }
         else
         {
            if(_previewStatus != PREVIEW_STATUS_REWARD)
            {
               return;
            }
            var_159.claimRewardAwaiting();
            var_364.controller.send(new NftCollectiblesClaimRewardItemMessageComposer(nftCollection.collectionId,var_364.activeWallet));
            var_364.sendClaimWaitNotification();
         }
         claimButton.disable();
      }
      
      public function claimingFinished(param1:Boolean, param2:Boolean) : void
      {
         if(_previewStatus == PREVIEW_STATUS_REWARD || _previewStatus == PREVIEW_STATUS_BONUS)
         {
            initCollectionPreview();
         }
      }
      
      public function updateBonusProgressBar(param1:Boolean = true, param2:uint = 0) : void
      {
         var _loc4_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var_2291 += param2;
         if(_previewStatus != PREVIEW_STATUS_BONUS)
         {
            return;
         }
         var _loc8_:Boolean = param1 || var_2291 >= PROGRESS_BAR_UPDATE_THRESHOLD;
         if(!_loc8_)
         {
            return;
         }
         var_2291 = 0;
         if(var_159.isBonusSnapshotPassed())
         {
            completionProgressBarTop.width = 0;
            completionProgressBarBottom.width = 0;
            completionProgressBarText.caption = localization.getLocalization("shop.minting.time_ended");
            return;
         }
         var _loc5_:Number = var_159.releasedTime;
         var _loc7_:Number = var_159.snapshotTime;
         if(_loc5_ > 0 && _loc7_ > 0)
         {
            _loc4_ = new Date().time;
            _loc9_ = Math.max(0,_loc7_ - _loc4_);
            _loc3_ = _loc7_ - _loc5_;
            _loc6_ = Math.min(1,Math.max(0,_loc9_ / _loc3_));
            var _loc10_:int = int(completionProgressBarPadded.width);
            var _loc11_:int = _loc10_ * _loc6_;
            completionProgressBarTop.width = 0;
            completionProgressBarBottom.width = 0;
            var _loc12_:String = FriendlyTime.getFriendlyTime(localization,_loc9_ / 1000);
            completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_left","") + ": " + null;
         }
      }
      
      private function initMintedItemPreview(param1:class_4130) : void
      {
         _previewStatus = PREVIEW_STATUS_ITEM;
         completionContainer.visible = false;
         collectionProgressContainer.visible = false;
         var_2198.clearPreviewer();
         var _loc2_:IRenderableCollectibleItem = new CollectionItemWrapper(param1);
         var_364.controller.previewImage(_loc2_,var_2198);
         productNameContainer.visible = true;
         productNameText.caption = var_364.controller.getProductName(_loc2_);
         productProgressContainer.visible = true;
         productProgressScoreText.caption = localization.getLocalizationWithParams(param1.amount > 0 ? "collectibles.preview.product.complete" : "collectibles.preview.product.incomplete","","amount","<font color=\"#FFC800\">" + param1.score + "</font>");
         initInfoEntries(param1);
      }
      
      private function initInfoEntries(param1:class_4130) : void
      {
         clearInfoEntries();
         var _loc3_:String = localization.getLocalization("collectibles.item.type");
         var _loc6_:String = localization.getLocalization("collectibles.item.rarity");
         var _loc7_:String = localization.getLocalization("collectibles.item.xp");
         var _loc5_:String = var_364.controller.getProductType(new CollectionItemWrapper(param1));
         var _loc2_:String = param1.rarity;
         var _loc4_:String = String(param1.score);
         addInfoEntry(_loc3_,_loc5_);
         addInfoEntry(_loc6_,_loc2_);
         addInfoEntry(_loc7_,_loc4_);
      }
      
      private function addInfoEntry(param1:String, param2:String) : void
      {
         var _loc3_:class_1812 = var_364.productInfoEntryTemplate.clone() as class_1812;
         _loc3_.findChildByName("product_info_key").caption = param1;
         _loc3_.findChildByName("product_info_value").caption = param2;
         productInfoList.addListItem(_loc3_);
      }
      
      private function clearInfoEntries() : void
      {
         productInfoList.removeListItems();
      }
      
      private function setProductInfoVisible(param1:Boolean) : void
      {
         productInfoContainer.visible = param1;
      }
      
      private function onProductNameUnhover(param1:WindowMouseEvent) : void
      {
         setProductInfoVisible(false);
      }
      
      private function onProductNameHover(param1:WindowMouseEvent) : void
      {
         setProductInfoVisible(true);
      }
      
      public function populateGridItems() : void
      {
         var _loc4_:class_1812 = null;
         var _loc3_:CollectibleItemRenderer = null;
         clearGridItems();
         var _loc1_:class_1812 = var_364.gridItemTemplate;
         for each(var _loc2_ in var_159.items)
         {
            _loc4_ = _loc1_.clone() as class_1812;
            _loc3_ = new CollectibleItemRenderer(var_364.controller,_loc2_,_loc4_,this);
            itemGrid.addGridItem(_loc4_);
            _gridItems.push(_loc3_);
         }
      }
      
      public function clearGridItems() : void
      {
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
      
      public function get nftCollection() : class_4087
      {
         return var_159;
      }
      
      public function selectItem(param1:CollectibleItemRenderer) : void
      {
         if(var_165 == param1)
         {
            var_165.deactivate();
            var_165 = null;
            initCollectionPreview();
            return;
         }
         if(var_165 != null)
         {
            var_165.deactivate();
            var_165 = null;
         }
         if(param1 != null)
         {
            var_165 = param1;
            var_165.activate();
            initMintedItemPreview(param1.item);
         }
         else
         {
            var_165 = null;
            initCollectionPreview();
         }
      }
      
      public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_2198.clearPreviewer();
         clearInfoEntries();
         clearGridItems();
         productNameContainer.removeEventListener("WME_OVER",onProductNameHover);
         productNameContainer.removeEventListener("WME_OUT",onProductNameUnhover);
         claimButton.removeEventListener("WME_CLICK",onClickClaim);
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function get localization() : class_27
      {
         return var_364.controller.localizationManager;
      }
      
      private function get titleText() : ITextWindow
      {
         return _container.findChildByName("collection_name") as ITextWindow;
      }
      
      private function get progressColorContainer() : class_1993
      {
         return _container.findChildByName("progress_color") as class_1993;
      }
      
      private function get progressText() : ITextWindow
      {
         return _container.findChildByName("progress_text") as ITextWindow;
      }
      
      private function get completionContainer() : class_1812
      {
         return _container.findChildByName("bonus_or_reward_container") as class_1812;
      }
      
      private function get completionHeaderContainer() : class_1812
      {
         return _container.findChildByName("completion_header_container") as class_1812;
      }
      
      private function get completionRewardNameText() : ITextWindow
      {
         return _container.findChildByName("reward_furni_name") as ITextWindow;
      }
      
      private function get completionProgressBar() : class_1812
      {
         return _container.findChildByName("progress_bar") as class_1812;
      }
      
      private function get completionProgressBarPadded() : class_1812
      {
         return _container.findChildByName("progress_padded_bar") as class_1812;
      }
      
      private function get completionProgressBarTop() : class_1812
      {
         return _container.findChildByName("progress_bar_top") as class_1812;
      }
      
      private function get completionProgressBarBottom() : class_1812
      {
         return _container.findChildByName("progress_bar_bottom") as class_1812;
      }
      
      private function get completionProgressBarText() : ITextWindow
      {
         return _container.findChildByName("progress_bar_text") as ITextWindow;
      }
      
      private function get claimButton() : class_1775
      {
         return _container.findChildByName("claim_button") as class_1775;
      }
      
      private function get collectionProgressContainer() : class_1812
      {
         return _container.findChildByName("collection_progress_container") as class_1812;
      }
      
      private function get collectionProgressScoreText() : ITextWindow
      {
         return _container.findChildByName("preview_score_text") as ITextWindow;
      }
      
      private function get collectionProgressRewardText() : ITextWindow
      {
         return _container.findChildByName("preview_reward_text") as ITextWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : class_2251
      {
         return _container.findChildByName("product_preview") as class_2251;
      }
      
      private function get productNameContainer() : class_1812
      {
         return _container.findChildByName("product_name_container") as class_1812;
      }
      
      private function get productNameText() : ITextWindow
      {
         return _container.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get productInfoContainer() : class_1812
      {
         return _container.findChildByName("product_info_container") as class_1812;
      }
      
      private function get productInfoList() : IItemListWindow
      {
         return _container.findChildByName("product_info_list") as IItemListWindow;
      }
      
      private function get productProgressContainer() : class_1812
      {
         return _container.findChildByName("product_progress_container") as class_1812;
      }
      
      private function get productProgressScoreText() : ITextWindow
      {
         return _container.findChildByName("procuct_score_text") as ITextWindow;
      }
      
      private function get itemGrid() : IItemGridWindow
      {
         return _container.findChildByName("itemgrid_collection") as IItemGridWindow;
      }
      
      private function get avatarImageWidget() : class_2010
      {
         return _container.findChildByName("avatar_image_widget") as class_2010;
      }
      
      private function get badgeImageWidget() : class_2010
      {
         return _container.findChildByName("badge_image_widget") as class_2010;
      }
      
      private function get petImageWidget() : class_2010
      {
         return _container.findChildByName("pet_image_widget") as class_2010;
      }
      
      private function get effectImageWidget() : class_2010
      {
         return _container.findChildByName("effect_image_widget") as class_2010;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
   }
}


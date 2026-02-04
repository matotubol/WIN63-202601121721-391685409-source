package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.catalog.viewer.widgets.utils.RentUtils;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.tracking.HabboTracking;
   
   public class PurchaseCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var _stubPurchaseVipXML:XML;
      
      private var var_1828:class_1812;
      
      private var _offer:class_1793;
      
      private var _additionalParameters:String = "";
      
      private var var_3544:IStuffData = null;
      
      private var var_1048:int = 1;
      
      private var _purchaseCallback:Function;
      
      private var _catalog:HabboCatalog;
      
      private var var_3155:Boolean;
      
      private var var_4503:Boolean = false;
      
      private var var_1191:Boolean = true;
      
      public function PurchaseCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
         events.removeEventListener("CWE_SET_EXTRA_PARM",onSetParameter);
         events.removeEventListener("PURCHASE_OVERRIDE",onPurchaseOverride);
         events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA",onSetPreviewerStuffData);
         events.removeEventListener("CWE_TOGGLE",onToggleWidget);
         super.dispose();
      }
      
      private function onToggleWidget(param1:CatalogWidgetToggleEvent) : void
      {
         if(param1.widgetId == "purchaseWidget")
         {
            var_1191 = param1.enabled;
            window.visible = var_1191;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(_catalog.catalogType == "BUILDERS_CLUB")
         {
            _window.visible = false;
            return true;
         }
         attachWidgetView("purchaseWidget");
         _window.findChildByName("selection_information").visible = true;
         _window.findChildByName("default_buttons").visible = false;
         var_3155 = false;
         if(window.tags.indexOf("ROOM_INITIATE_PURCHASE") > -1)
         {
            _catalog.sendRoomAdPurchaseInitiatedEvent();
         }
         _window.findChildByName("buy_button").addEventListener("WME_CLICK",onPurchase);
         var _loc2_:class_1775 = _window.findChildByName("gift_button") as class_1775;
         if(window.tags.indexOf("NO_GIFT_OPTION") > -1)
         {
            var_3155 = true;
            _loc2_.visible = false;
         }
         _loc2_.addEventListener("WME_CLICK",onGift);
         _loc2_.disable();
         var _loc1_:XmlAsset = _catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset;
         if(_loc1_ != null)
         {
            _stubPurchaseVipXML = _loc1_.content as XML;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("CWE_SET_EXTRA_PARM",onSetParameter);
         events.addEventListener("PURCHASE_OVERRIDE",onPurchaseOverride);
         events.addEventListener("INIT_PURCHASE",initPurchase);
         events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA",onSetPreviewerStuffData);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChanged);
         events.addEventListener("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY",onExtraParamRequired);
         events.addEventListener("CWE_TOGGLE",onToggleWidget);
         return true;
      }
      
      private function onPurchaseOverride(param1:CatalogWidgetPurchaseOverrideEvent) : void
      {
         _purchaseCallback = param1.callback;
      }
      
      private function attachStub(param1:class_1793) : void
      {
         if(var_1828 != null)
         {
            var_1828.visible = false;
            _window.removeChild(var_1828);
            var_1828.dispose();
            var_1828 = null;
         }
      }
      
      private function get extraParamRequirementsMet() : Boolean
      {
         return !(var_4503 && _additionalParameters == "");
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var_1048 = 1;
         _offer = param1.offer;
         _window.findChildByName("selection_information").visible = false;
         _window.findChildByName("default_buttons").visible = true;
         attachStub(_offer);
         _catalog.purchaseWillBeGift(false);
         if(var_1828 == null)
         {
            enableBuyButton(extraParamRequirementsMet);
            enableGiftButton(extraParamRequirementsMet);
            RentUtils.updateBuyCaption(_offer,_window.findChildByName("purchase_label"));
            var _loc2_:class_1741 = _window.findChildByName("gift_button");
            if(!_offer.giftable)
            {
               enableGiftButton(false);
            }
            var _loc3_:Boolean = isSoldOut(_offer);
            window.visible = var_1191;
         }
         else
         {
            enableBuyButton(false);
            enableGiftButton(false);
         }
      }
      
      private function isSoldOut(param1:class_1793) : Boolean
      {
         var _loc2_:class_1857 = null;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            if(param1.pricingModel == "pricing_model_single")
            {
               _loc2_ = _offer.product;
               if(_loc2_ != null && _loc2_.isUniqueLimitedItem)
               {
                  return _loc2_.uniqueLimitedItemsLeft == 0;
               }
            }
         }
         return false;
      }
      
      private function enableBuyButton(param1:Boolean) : void
      {
         if(_catalog.sessionDataManager.isAccountSafetyLocked())
         {
            param1 = false;
         }
         enableButton("buy_button",param1);
      }
      
      private function enableGiftButton(param1:Boolean) : void
      {
         if(_catalog.sessionDataManager.isAccountSafetyLocked())
         {
            param1 = false;
         }
         enableButton("gift_button",param1);
      }
      
      private function enableButton(param1:String, param2:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:class_1741 = _window.findChildByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         if(param2)
         {
            _loc3_.enable();
            _loc3_.blend = 1;
         }
         else
         {
            _loc3_.disable();
            _loc3_.blend = 0.5;
         }
      }
      
      private function onSetParameter(param1:SetExtraPurchaseParameterEvent) : void
      {
         _additionalParameters = param1.parameter;
         enableBuyButton(extraParamRequirementsMet);
         enableGiftButton(_offer != null && _offer.giftable && extraParamRequirementsMet && var_1048 == 1);
      }
      
      private function onPurchase(param1:WindowMouseEvent, param2:Boolean = false) : void
      {
         var event:WindowMouseEvent = param1;
         var isGift:Boolean = param2;
         if(!_catalog.verifyClubLevel(_offer.clubLevel))
         {
            _catalog.openClubCenter();
            return;
         }
         _catalog.purchaseWillBeGift(isGift);
         if(_purchaseCallback == null)
         {
            if(_offer != null)
            {
               if(_catalog.roomAdPurchaseData != null && _catalog.roomAdPurchaseData.offerId == _offer.offerId)
               {
                  if(_catalog.roomAdPurchaseData.flatId == 0)
                  {
                     _catalog.windowManager.alert("${roomad.error.title}","${roomad.alert.no.available.room}",0,function(param1:class_1750, param2:class_1758):void
                     {
                        param1.dispose();
                     });
                     return;
                  }
                  if(_catalog.roomAdPurchaseData.name == null || _catalog.roomAdPurchaseData.name.length < 5 || _catalog.roomAdPurchaseData.name.substr(0,1) == " ")
                  {
                     _catalog.windowManager.alert("${roomad.error.title}","${roomad.alert.name.empty}",0,function(param1:class_1750, param2:class_1758):void
                     {
                        param1.dispose();
                     });
                     return;
                  }
               }
               _catalog.showPurchaseConfirmation(_offer,page.pageId,_additionalParameters,var_1048,var_3544,null,true,null);
            }
         }
         else
         {
            _purchaseCallback(event);
         }
      }
      
      private function onGift(param1:WindowMouseEvent) : void
      {
         onPurchase(param1,true);
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.buy_as_gift.clicked");
      }
      
      private function initPurchase(param1:CatalogWidgetInitPurchaseEvent) : void
      {
         if(_offer != null)
         {
            _catalog.showPurchaseConfirmation(_offer,page.pageId,_additionalParameters,var_1048,var_3544,null,true,null);
         }
      }
      
      private function onBuyClub(param1:WindowMouseEvent) : void
      {
         _catalog.rememberPageDuringVipPurchase(page.pageId);
         _catalog.openClubCenter();
         HabboTracking.getInstance().trackEventLog("Catalog","click","BUY_CLUB");
      }
      
      private function onSetPreviewerStuffData(param1:SetRoomPreviewerStuffDataEvent) : void
      {
         var_3544 = param1.stuffData;
      }
      
      private function onSpinnerValueChanged(param1:CatalogWidgetSpinnerEvent) : void
      {
         var_1048 = param1.value;
         if(var_1048 > 1)
         {
            enableGiftButton(false);
         }
         else if(_offer != null && extraParamRequirementsMet)
         {
            enableGiftButton(_offer.giftable);
         }
      }
      
      private function onExtraParamRequired(param1:CatalogWidgetEvent) : void
      {
         var_4503 = true;
         enableBuyButton(extraParamRequirementsMet);
         enableGiftButton(_offer != null && extraParamRequirementsMet && var_1048 == 1);
      }
   }
}


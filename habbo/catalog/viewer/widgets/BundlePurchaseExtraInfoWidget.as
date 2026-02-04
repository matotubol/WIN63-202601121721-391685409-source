package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoViewManager;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BundlePurchaseExtraInfoWidget extends CatalogWidget implements class_2612
   {
      
      private static const PROMO_ITEM_DROP_DELAY_MS:uint = 4000;
      
      private var _catalog:HabboCatalog;
      
      private var var_635:ExtraInfoViewManager;
      
      private var var_2642:int = 1;
      
      private var var_3227:int;
      
      private var var_2346:int;
      
      private var var_4422:int;
      
      private var var_5213:String;
      
      private var var_923:int = -1;
      
      private var var_1004:int = -1;
      
      private var var_1674:int = -1;
      
      private var var_2696:Boolean = false;
      
      private var var_1584:Timer;
      
      public function BundlePurchaseExtraInfoWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_635.dispose();
            var_635 = null;
            _catalog = null;
            var_1584.stop();
            var_1584.removeEventListener("timerComplete",onPromoItemDropDownTimerEvent);
            var_1584 = null;
            events.removeEventListener("CWPPEIE_RESET",onResetEvent);
            events.removeEventListener("CWPPEIE_HIDE",onHideEvent);
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
            events.removeEventListener("CWPPEIE_ITEM_CLICKED",onExtraInfoItemClickedEvent);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         var_635 = new ExtraInfoViewManager(this,_catalog);
         events.addEventListener("CWPPEIE_RESET",onResetEvent);
         events.addEventListener("CWPPEIE_HIDE",onHideEvent);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
         events.addEventListener("CWPPEIE_ITEM_CLICKED",onExtraInfoItemClickedEvent);
         var_1584 = new Timer(4000,1);
         var_1584.addEventListener("timerComplete",onPromoItemDropDownTimerEvent);
         return true;
      }
      
      private function createPromoItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(0);
         _loc1_.quantity = var_2642;
         var_923 = var_635.addItem(_loc1_);
      }
      
      private function updatePromoItem(param1:int) : void
      {
         var _loc3_:UpdateableExtraInfoListItem = null;
         var _loc2_:ExtraInfoItemData = null;
         if(var_923 != -1)
         {
            _loc3_ = UpdateableExtraInfoListItem(var_635.getItem(var_923));
            _loc2_ = _loc3_.data;
            _loc2_.quantity = param1;
            _loc3_.update(_loc2_);
         }
      }
      
      private function removePromoItem() : void
      {
         if(var_923 != -1)
         {
            var_635.removeItem(var_923);
            var_923 = -1;
         }
      }
      
      private function createDiscountValueItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(2);
         _loc1_.quantity = var_2642;
         _loc1_.priceActivityPoints = var_2346;
         _loc1_.activityPointType = var_4422;
         _loc1_.priceCredits = var_3227;
         var_1004 = var_635.addItem(_loc1_);
         _catalog.utils.discountShownEventTrack();
      }
      
      private function updateDiscountValueItem(param1:int) : void
      {
         var _loc2_:UpdateableExtraInfoListItem = null;
         var _loc3_:ExtraInfoItemData = null;
         if(var_1004 != -1)
         {
            _loc2_ = UpdateableExtraInfoListItem(var_635.getItem(var_1004));
            _loc3_ = _loc2_.data;
            _loc3_.quantity = param1;
            _loc3_.discountPriceCredits = _catalog.utils.calculateBundlePrice(true,var_3227,param1);
            _loc3_.discountPriceActivityPoints = _catalog.utils.calculateBundlePrice(true,var_2346,param1);
            _loc2_.update(_loc3_);
         }
      }
      
      private function removeDiscountValueItem() : void
      {
         if(var_1004 != -1)
         {
            var_635.removeItem(var_1004);
            var_1004 = -1;
         }
      }
      
      private function createBundleInfoItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(1);
         var_1674 = var_635.addItem(_loc1_);
         _catalog.utils.bundlesInfoShownEventTrack();
      }
      
      private function removeBundleInfoItem() : void
      {
         if(var_1674 != -1)
         {
            var_635.removeItem(var_1674);
            var_1674 = -1;
         }
      }
      
      private function onResetEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         if(disposed)
         {
            return;
         }
         window.visible = true;
         var_3227 = param1.data.priceCredits;
         var_2346 = param1.data.priceActivityPoints;
         var_4422 = param1.data.activityPointType;
         var_5213 = param1.data.badgeCode;
         var_635.clear();
         var_1004 = -1;
         var_923 = -1;
         var_1584.start();
      }
      
      private function onSpinnerEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_catalog.bundleDiscountEnabled)
         {
            return;
         }
         if(param1.type == "CWSE_VALUE_CHANGED")
         {
            if(param1.value != var_2642)
            {
               if(param1.value >= _catalog.bundleDiscountRuleset.bundleSize && var_1004 == -1)
               {
                  createDiscountValueItem();
               }
               else if(param1.value < _catalog.bundleDiscountRuleset.bundleSize)
               {
                  removeDiscountValueItem();
               }
               updatePromoItem(param1.value);
               updateDiscountValueItem(param1.value);
               var_2642 = param1.value;
               removeBundleInfoItem();
               if(var_2642 >= _catalog.utils.bundleDiscountHighestFlatPriceStep)
               {
                  removePromoItem();
                  var_2696 = true;
               }
               else if(var_2696)
               {
                  createPromoItem();
                  var_2696 = false;
               }
               _catalog.utils.spinnerValueChangedEventTrack();
            }
         }
      }
      
      private function onHideEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         window.visible = false;
      }
      
      private function onExtraInfoItemClickedEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         switch(param1.id)
         {
            case var_923:
               if(var_1674 == -1)
               {
                  createBundleInfoItem();
               }
               break;
            case var_1674:
               removeBundleInfoItem();
         }
      }
      
      private function onPromoItemDropDownTimerEvent(param1:TimerEvent) : void
      {
         createPromoItem();
      }
   }
}


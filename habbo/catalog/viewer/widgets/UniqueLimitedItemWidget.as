package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.window.utils.ILimitedItemOverlay;
   import com.sulake.habbo.window.widgets.ILimitedItemSupplyLeftOverlayWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UniqueLimitedItemWidget extends CatalogWidget implements class_2612
   {
      
      private static const SUPPLY_REFRESH_PERIOD_MS:int = 20000;
      
      private var _catalog:HabboCatalog;
      
      private var _overlay:ILimitedItemOverlay;
      
      private var var_1602:class_1793;
      
      private var var_1115:Timer;
      
      private var _overlayWidget:ILimitedItemSupplyLeftOverlayWidget;
      
      public function UniqueLimitedItemWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1115 != null)
            {
               var_1115.stop();
               var_1115.removeEventListener("timer",onSupplyLeftTimer);
               var_1115 = null;
            }
            window.visible = false;
            _catalog = null;
            var_1602 = null;
            if(_overlay)
            {
               _overlay.dispose();
               _overlay = null;
            }
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            events.removeEventListener("CWE_PRODUCT_OFFER_UPDATED",onOfferUpdated);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var _loc1_:class_2010 = class_2010(_window.findChildByName("unique_item_overlay_container"));
         _overlayWidget = ILimitedItemSupplyLeftOverlayWidget(_loc1_.widget);
         window.visible = false;
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("CWE_PRODUCT_OFFER_UPDATED",onOfferUpdated);
         var_1115 = new Timer(20000);
         var_1115.addEventListener("timer",onSupplyLeftTimer);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_1602 = param1.offer;
         update(param1.offer,true);
      }
      
      private function onOfferUpdated(param1:ProductOfferUpdatedEvent) : void
      {
         var_1602 = param1.offer;
         update(param1.offer);
      }
      
      private function update(param1:class_1793, param2:Boolean = false) : void
      {
         var _loc3_:class_1857 = null;
         if(param1.pricingModel == "pricing_model_single" && param1.product.isUniqueLimitedItem)
         {
            _loc3_ = param1.product;
            _overlayWidget.supplyLeft = _loc3_.uniqueLimitedItemsLeft;
            _overlayWidget.seriesSize = _loc3_.uniqueLimitedItemSeriesSize;
            window.visible = true;
            if(param2)
            {
               _catalog.sendGetProductOffer(param1.offerId);
            }
            var_1115.start();
         }
         else
         {
            window.visible = false;
            var_1115.stop();
         }
      }
      
      private function onSupplyLeftTimer(param1:TimerEvent) : void
      {
         if(_window.visible && var_1602 != null)
         {
            update(var_1602,true);
         }
      }
   }
}


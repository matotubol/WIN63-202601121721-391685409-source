package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import flash.events.Event;
   
   public class TotalPriceWidget extends CatalogWidget implements class_2612
   {
      
      private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
      
      private static const ELEMENT_PLUS:String = "plus";
      
      private static const const_146:String = "amount_text_left";
      
      private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
      
      private static const const_1056:String = "total_left";
      
      private static const ELEMENT_TOTAL_RIGHT:String = "total_right";
      
      private static const const_1108:String = "currency_indicator_bitmap_left";
      
      private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";
      
      private var _catalog:HabboCatalog;
      
      private var var_3227:int;
      
      private var var_2346:int;
      
      private var var_1525:int;
      
      private var var_4422:int;
      
      private var var_1281:class_1741;
      
      private var var_1253:class_1741;
      
      private var var_477:class_1812;
      
      private var var_297:class_1812;
      
      private var var_1048:int = 1;
      
      public function TotalPriceWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _catalog = null;
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChangedEvent);
            events.removeEventListener("SELECT_PRODUCT",onSelectProductEvent);
            clear();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("totalPriceWidget");
         window.visible = false;
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChangedEvent);
         events.addEventListener("SELECT_PRODUCT",onSelectProductEvent);
         events.dispatchEvent(new Event("TOTAL_PRICE_WIDGET_INITIALIZED"));
         return true;
      }
      
      private function onSpinnerValueChangedEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         var_1048 = param1.value;
         updateCurrencyIndicators();
      }
      
      private function onSelectProductEvent(param1:SelectProductEvent) : void
      {
         window.visible = param1.offer.bundlePurchaseAllowed;
         var_3227 = param1.offer.priceInCredits;
         var_2346 = param1.offer.priceInActivityPoints;
         var_1525 = param1.offer.priceInSilver;
         var_4422 = param1.offer.activityPointType;
         var_1048 = 1;
         clear();
         createCurrencyIndicators();
         updateCurrencyIndicators();
      }
      
      private function clear() : void
      {
         var_1281 = null;
         var_1253 = null;
         var_477 = null;
         var_297 = null;
         _window.findChildByName("plus").visible = false;
         _window.findChildByName("amount_text_left").visible = false;
         if(_window.findChildByName("total_left"))
         {
            _window.findChildByName("total_left").visible = false;
         }
         if(_window.findChildByName("total_right"))
         {
            _window.findChildByName("total_right").visible = false;
         }
         _window.findChildByName("currency_indicator_bitmap_left").visible = false;
      }
      
      private function updateCurrencyIndicators() : void
      {
         var _loc4_:class_1741 = null;
         var _loc8_:class_1741 = null;
         _loc8_ = null;
         var _loc3_:int = var_1048 * var_3227;
         var _loc7_:int = var_1048 * var_2346;
         var _loc6_:int = var_1048 * var_1525;
         var _loc1_:int = _loc3_;
         var _loc2_:int = _loc7_;
         var _loc5_:int = _loc6_;
         if(_catalog.bundleDiscountEnabled)
         {
            _loc1_ = _catalog.utils.calculateBundlePrice(true,var_3227,var_1048);
            _loc2_ = _catalog.utils.calculateBundlePrice(true,var_2346,var_1048);
            _loc5_ = _catalog.utils.calculateBundlePrice(true,var_1525,var_1048);
         }
         if(var_1281 != null)
         {
            var_1281.caption = _catalog.bundleDiscountEnabled ? _loc1_.toString() : _loc3_.toString();
         }
         if(var_1253 != null)
         {
            if(var_1525 > 0)
            {
               var_1253.caption = _catalog.bundleDiscountEnabled ? _loc5_.toString() : _loc6_.toString();
            }
            else
            {
               var_1253.caption = _catalog.bundleDiscountEnabled ? _loc2_.toString() : _loc7_.toString();
            }
         }
         if(var_477)
         {
            var_477.visible = _loc3_ != _loc1_;
            _loc4_ = var_477.findChildByName("text");
            _loc4_.caption = var_477.visible ? _loc3_.toString() : "0";
            var_477.findChildByName("strike").width = _loc4_.width;
         }
         if(var_297)
         {
            if(var_1525 > 0)
            {
               var_297.visible = _loc6_ != _loc5_;
               _loc8_ = var_297.findChildByName("text");
               _loc8_.caption = var_297.visible ? _loc6_.toString() : "0";
               var_297.findChildByName("strike").width = _loc8_.width;
            }
            else
            {
               var_297.visible = _loc7_ != _loc2_;
               _loc8_ = var_297.findChildByName("text");
               _loc8_.caption = var_297.visible ? _loc7_.toString() : "0";
               var_297.findChildByName("strike").width = _loc8_.width;
            }
         }
      }
      
      private function createCurrencyIndicators() : void
      {
         if(var_3227 > 0)
         {
            if(var_2346 > 0 || var_1525 > 0)
            {
               var_1281 = _window.findChildByName("amount_text_left");
               var_1281.visible = true;
               var_477 = _window.findChildByName("total_left") as class_1812;
               if(var_477)
               {
                  var_477.visible = false;
               }
               var _loc2_:class_1741 = _window.findChildByName("currency_indicator_bitmap_left");
               null.visible = true;
               _window.findChildByName("plus").visible = true;
            }
            else
            {
               var_1281 = _window.findChildByName("amount_text_right");
               var_477 = _window.findChildByName("total_right") as class_1812;
               if(var_477)
               {
                  var_477.visible = false;
               }
               _loc2_ = _window.findChildByName("currency_indicator_bitmap_right");
            }
            if(page.acceptSeasonCurrencyAsCredits)
            {
               null.style = class_2085.getIconStyleFor(_catalog.getSeasonalCurrencyActivityPointType(),_catalog,true,true);
               null.width = 53;
            }
            else
            {
               null.style = class_2085.getIconStyleFor(-1,_catalog,true);
               null.width = 22;
            }
         }
         if(var_2346 > 0)
         {
            var_1253 = ITextWindow(_window.findChildByName("amount_text_right"));
            var_297 = _window.findChildByName("total_left") as class_1812;
            if(var_297)
            {
               var_297.visible = false;
            }
            var _loc3_:class_1741 = _window.findChildByName("currency_indicator_bitmap_right");
            null.style = class_2085.getIconStyleFor(var_4422,_catalog,true);
         }
         else if(var_1525 > 0)
         {
            var_1253 = ITextWindow(_window.findChildByName("amount_text_right"));
            var_297 = _window.findChildByName("total_left") as class_1812;
            if(var_297)
            {
               var_297.visible = false;
            }
            var _loc1_:class_1741 = _window.findChildByName("currency_indicator_bitmap_right");
            null.style = class_2085.getIconStyleFor(1000,_catalog,true);
         }
         IItemListWindow(_window.findChildByName("totalprice_container")).arrangeListItems();
      }
   }
}


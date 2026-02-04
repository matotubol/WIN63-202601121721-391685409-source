package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ExtraInfoPromoItem extends UpdateableExtraInfoListItem
   {
      
      private static const const_261:String = "catalog.bundlewidget.discount.promo";
      
      private var _window:class_1812 = null;
      
      private var var_3014:Boolean = true;
      
      private var _catalog:HabboCatalog;
      
      private var var_2126:class_55;
      
      private var var_2361:int = 0;
      
      private var var_16:BundlePurchaseExtraInfoWidget;
      
      private var var_1073:Number = 0;
      
      private var var_1731:Timer;
      
      public function ExtraInfoPromoItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:HabboCatalog)
      {
         super(null,param2,param3,0);
         var_16 = param1;
         _catalog = param4;
         createNextDiscountMap();
         resolveNextDiscountLevel();
         var_1731 = new Timer(50);
         var_1731.addEventListener("timer",onEffectTimer);
         var_1731.start();
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_1731.stop();
            var_1731.removeEventListener("timer",onEffectTimer);
            var_1731 = null;
            var_2126 = null;
            _catalog = null;
            super.dispose();
         }
      }
      
      override public function update(param1:ExtraInfoItemData) : void
      {
         super.update(param1);
         var _loc2_:int = var_2361;
         resolveNextDiscountLevel();
         if(var_2361 != _loc2_)
         {
            var_1073 = 1;
         }
         var_3014 = true;
         render();
      }
      
      override public function getRenderedWindow() : class_1812
      {
         if(_window == null)
         {
            createWindow();
         }
         if(var_3014)
         {
            render();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = class_1812(_catalog.utils.createWindow("discountPromoItem"));
         _window.procedure = windowProcedure;
         var _loc1_:class_2251 = class_2251(_window.findChildByName("icon_bitmap"));
         HabboCatalogUtils.replaceCenteredImage(_loc1_,BitmapData(_catalog.assets.getAssetByName("thumb_up").content).clone());
      }
      
      private function render() : void
      {
         _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo","quantity",var_2361.toString());
         _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo","discount",var_2126.getValue(var_2361));
         var _loc1_:String = _catalog.localization.getLocalizationRaw("catalog.bundlewidget.discount.promo").value;
         _window.findChildByName("promo_text").caption = _loc1_;
         _window.findChildByName("promo_text_effect").caption = _loc1_;
         var_3014 = false;
      }
      
      private function resolveNextDiscountLevel() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = var_2126.getKeys();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(int(_loc1_[_loc2_]) > data.quantity)
            {
               var_2361 = int(_loc1_[_loc2_]);
               break;
            }
            _loc2_++;
         }
      }
      
      private function createNextDiscountMap() : void
      {
         var_2126 = new class_55();
         var _loc2_:int = 1;
         var _loc3_:int = 0;
         while(true)
         {
            var _loc4_:int = _catalog.utils.calculateBundlePrice(true,1,0);
            var _loc1_:int = 0 - 0;
            _loc2_++;
         }
      }
      
      private function onEffectTimer(param1:TimerEvent) : void
      {
         if(var_1073 > 0)
         {
            var_1073 -= 0.1;
            if(var_1073 < 0)
            {
               var_1073 = 0;
            }
            _window.findChildByName("promo_text_effect").blend = var_1073;
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param2.name == "click_region")
         {
            switch(param1.type)
            {
               case "WME_CLICK":
                  var_16.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED",data,id));
                  break;
               case "WME_OVER":
                  ITextWindow(_window.findChildByName("promo_text")).textColor = 12582911;
                  break;
               case "WME_OUT":
                  ITextWindow(_window.findChildByName("promo_text")).textColor = 16777215;
            }
         }
      }
   }
}


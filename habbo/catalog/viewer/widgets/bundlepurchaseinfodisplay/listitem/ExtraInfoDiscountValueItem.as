package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ExtraInfoDiscountValueItem extends UpdateableExtraInfoListItem
   {
      
      private static const ELEMENT_SPLASH_STAR:String = "icon_splash_bitmap";
      
      private static const const_942:String = "icon_bitmap";
      
      private static const const_229:String = "total_currency_value_left";
      
      private static const const_612:String = "total_currency_icon_left";
      
      private static const ELEMENT_TOTAL_LEFT_CURRENCY_STRIKETHROUGH:String = "striketrough_total_currency_left";
      
      private static const const_1224:String = "total_currency_value_right";
      
      private static const const_507:String = "total_currency_icon_right";
      
      private static const ELEMENT_TOTAL_RIGHT_CURRENCY_STRIKETHROUGH:String = "striketrough_total_currency_right";
      
      private static const const_510:String = "discount_currency_value_left";
      
      private static const const_826:String = "discount_currency_icon_left";
      
      private static const const_698:String = "discount_currency_value_right";
      
      private static const const_1197:String = "discount_currency_icon_right";
      
      private static const STRIKETHROUGH_LEFT_MARGIN:int = 4;
      
      private static const STRIKETHROUGH_RIGHT_MARGIN:int = 20;
      
      private var _window:class_1812 = null;
      
      private var var_3014:Boolean = true;
      
      private var _catalog:HabboCatalog;
      
      private var _starAnimationOffset:int = 0;
      
      private var var_1707:Timer;
      
      private var var_2360:Boolean;
      
      private var var_2082:Boolean;
      
      private var var_2718:Boolean;
      
      private var var_4255:Boolean = false;
      
      public function ExtraInfoDiscountValueItem(param1:int, param2:ExtraInfoItemData, param3:HabboCatalog)
      {
         super(null,param1,param2,1,true);
         _catalog = param3;
         var_1707 = new Timer(150);
         var_1707.addEventListener("timer",starAnimationTimerEvent);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1707 != null)
            {
               var_1707.stop();
               var_1707 = null;
            }
            _catalog = null;
            super.dispose();
         }
      }
      
      override public function update(param1:ExtraInfoItemData) : void
      {
         super.update(param1);
         var_2360 = false;
         var_2082 = false;
         var_2718 = false;
         if(param1.priceCredits > 0 && param1.priceActivityPoints > 0)
         {
            var_2360 = true;
         }
         else if(param1.priceActivityPoints > 0 && param1.priceCredits == 0)
         {
            var_2718 = true;
         }
         else
         {
            var_2082 = true;
         }
         var_3014 = true;
         render();
         if(!var_4255)
         {
            setCurrencyIcons();
         }
      }
      
      override public function getRenderedWindow() : class_1812
      {
         if(var_3014)
         {
            render();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = class_1812(_catalog.utils.createWindow("discountValueItem"));
         setElementBitmap("icon_bitmap","thumb_up");
         startSplashAnimation();
      }
      
      private function render() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         updateColumns();
         updatePriceIndicators();
         updateStrikeThroughElements();
         var_3014 = false;
      }
      
      private function updateColumns() : void
      {
         if(var_2718 || var_2082)
         {
            setLeftColumnVisibility(false);
         }
         else
         {
            setLeftColumnVisibility(true);
         }
      }
      
      private function setCurrencyIcons() : void
      {
         if(var_2360)
         {
            setIconStyle("total_currency_icon_left",-1);
            setIconStyle("discount_currency_icon_left",-1);
         }
         if(var_2082)
         {
            setIconStyle("total_currency_icon_right",-1);
            setIconStyle("discount_currency_icon_right",-1);
         }
         else
         {
            setIconStyle("total_currency_icon_right",data.activityPointType);
            setIconStyle("discount_currency_icon_right",data.activityPointType);
         }
         var_4255 = true;
      }
      
      private function updatePriceIndicators() : void
      {
         if(var_2360)
         {
            setElementText("total_currency_value_left",(data.quantity * data.priceCredits).toString());
            setElementText("discount_currency_value_left",(data.quantity * data.priceCredits - data.discountPriceCredits).toString());
         }
         if(var_2082)
         {
            setElementText("total_currency_value_right",(data.quantity * data.priceCredits).toString());
            setElementText("discount_currency_value_right",(data.quantity * data.priceCredits - data.discountPriceCredits).toString());
         }
         else
         {
            setElementText("total_currency_value_right",(data.quantity * data.priceActivityPoints).toString());
            setElementText("discount_currency_value_right",(data.quantity * data.priceActivityPoints - data.discountPriceActivityPoints).toString());
         }
      }
      
      private function updateStrikeThroughElements() : void
      {
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("total_currency_value_left"));
         var _loc2_:int = _loc4_.x + _loc4_.width - _loc4_.textWidth;
         var _loc5_:class_1812 = class_1812(_window.findChildByName("striketrough_total_currency_left"));
         _loc5_.x = _loc2_ - 4;
         _loc5_.width = 4 + _loc4_.textWidth + 20;
         var _loc1_:ITextWindow = ITextWindow(_window.findChildByName("total_currency_value_right"));
         var _loc3_:int = _loc1_.x + _loc1_.width - _loc1_.textWidth;
         var _loc6_:class_1812 = class_1812(_window.findChildByName("striketrough_total_currency_right"));
         _loc6_.x = _loc3_ - 4;
         _loc6_.width = 4 + _loc1_.textWidth + 20;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         _window.findChildByName(param1).caption = param2;
      }
      
      private function setElementBitmap(param1:String, param2:String) : void
      {
         var _loc4_:class_2251 = class_2251(_window.findChildByName(param1));
         var _loc3_:BitmapData = BitmapData(_catalog.assets.getAssetByName(param2).content);
         HabboCatalogUtils.replaceCenteredImage(_loc4_,_loc3_);
      }
      
      private function setIconStyle(param1:String, param2:int) : void
      {
         var _loc3_:class_1741 = _window.findChildByName(param1);
         _loc3_.style = class_2085.getIconStyleFor(param2,_catalog,false);
      }
      
      private function setLeftColumnVisibility(param1:Boolean) : void
      {
         var _loc2_:Array = ["discount_currency_icon_left","discount_currency_value_left","total_currency_icon_left","striketrough_total_currency_left","total_currency_value_left"];
         for each(var _loc3_ in _loc2_)
         {
            _window.findChildByName(_loc3_).visible = param1;
         }
      }
      
      private function startSplashAnimation() : void
      {
         var _loc1_:class_2251 = class_2251(_window.findChildByName("icon_splash_bitmap"));
         _loc1_.bitmap = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         starAnimationTimerEvent(new TimerEvent("timer"));
         var_1707.start();
      }
      
      private function starAnimationTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:class_2251 = null;
         var _loc3_:IAsset = null;
         if(_window != null)
         {
            _loc2_ = class_2251(_window.findChildByName("icon_splash_bitmap"));
            _loc3_ = _catalog.assets.getAssetByName("bundle_discount_star_" + _starAnimationOffset);
            HabboCatalogUtils.replaceCenteredImage(_loc2_,BitmapData(_loc3_.content),BitmapDataAsset(_loc3_).rectangle);
            if(++_starAnimationOffset > 7)
            {
               _starAnimationOffset = 0;
            }
         }
      }
   }
}


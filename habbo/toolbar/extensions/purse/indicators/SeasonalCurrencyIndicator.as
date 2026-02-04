package com.sulake.habbo.toolbar.extensions.purse.indicators
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.localization.class_26;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.utils.ColorConverter;
   import flash.events.IEventDispatcher;
   
   public class SeasonalCurrencyIndicator extends CurrencyIndicatorBase
   {
      
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
      
      private var _catalog:IHabboCatalog;
      
      private var var_3634:int = -1;
      
      private var _toolbar:HabboToolbar;
      
      public function SeasonalCurrencyIndicator(param1:HabboToolbar, param2:class_38, param3:class_40, param4:IHabboCatalog, param5:class_26)
      {
         super(param2,param3);
         _toolbar = param1;
         _catalog = param4;
         this.bgColorLight = 4286084205;
         this.bgColorDark = 4283781966;
         this.textElementName = "amount";
         this.amountZeroText = param5.getLocalization("purse.snowflakes.zero.amount.text","Info");
         createWindow("purse_indicator_seasonal_xml",null);
         setAmount(0);
         param1.extensionView.attachExtension("purse_seasonal_currency",window,5);
         registerUpdateEvents(param4.events);
         initializeCurrencyLayouts();
      }
      
      private function initializeCurrencyLayouts() : void
      {
         var _loc3_:int = displayedActivityPointType;
         var _loc5_:IIconWindow = IIconWindow(window.findChildByName("seasonal_icon"));
         _loc5_.style = class_2085.getIconStyleFor(_loc3_,_toolbar,true);
         _loc5_.fitToSize();
         var _loc2_:ITextWindow = ITextWindow(window.findChildByName("seasonal_name"));
         _loc2_.text = _catalog.getActivityPointName(_loc3_);
         _loc2_.textColor = currencyTextColor;
         var _loc1_:class_1993 = class_1993(window.findChildByName("seasonal_bg"));
         _loc1_.color = currencyBackgroundColor;
         var _loc4_:class_1993 = class_1993(window.findChildByName("change_overlay"));
         _loc4_.color = currencyBackgroundColor;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener("catalog_purse_activity_point_balance",onBalance);
      }
      
      override protected function onContainerClick(param1:WindowMouseEvent) : void
      {
         _catalog.openCatalogPage(catalogPageName);
      }
      
      public function onBalance(param1:PurseEvent) : void
      {
         if(param1.activityPointType == displayedActivityPointType)
         {
            setAmount(param1.balance);
            if(var_3634 != -1)
            {
               animateChange(var_3634,param1.balance);
            }
            var_3634 = param1.balance;
         }
      }
      
      override protected function setAmount(param1:int, param2:int = -1) : void
      {
         var _loc3_:String = param1.toString();
         if(param1 == 0)
         {
            _loc3_ = this.amountZeroText;
            setTextUnderline(true);
         }
         else
         {
            setTextUnderline(false);
         }
         setText(_loc3_);
      }
      
      public function get displayedActivityPointType() : int
      {
         return _toolbar.getInteger("seasonalcurrencyindicator.currency",1);
      }
      
      private function get seasonalCurrencyId() : String
      {
         return _toolbar.getProperty("seasonalcurrency.id." + displayedActivityPointType);
      }
      
      private function get catalogPageName() : String
      {
         return _toolbar.getProperty("seasonalcurrencyindicator.page");
      }
      
      private function get currencyColor() : String
      {
         return _toolbar.getProperty("seasonalcurrency." + seasonalCurrencyId + ".color");
      }
      
      private function get currencyBackgroundColor() : uint
      {
         return ColorConverter.hexToUint(_toolbar.getProperty("seasonalcurrency.preset." + currencyColor + ".border"));
      }
      
      private function get currencyTextColor() : uint
      {
         return ColorConverter.hexToUint(_toolbar.getProperty("seasonalcurrency.preset." + currencyColor + ".font"));
      }
   }
}


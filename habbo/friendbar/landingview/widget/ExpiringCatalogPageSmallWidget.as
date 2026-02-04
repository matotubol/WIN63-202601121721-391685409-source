package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.window.widgets.class_2728;
   import package_10.class_3124;
   import package_13.class_2380;
   import package_6.class_4064;
   
   public class ExpiringCatalogPageSmallWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var _pageName:String = "";
      
      private var _lastRequestTime:Date;
      
      private var var_4702:int;
      
      public function ExpiringCatalogPageSmallWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("expiring_catalog_page_small"));
         _container.findChildByName("open_catalog_button").procedure = onOpenCatalogButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_3124(onCatalogPage));
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 30000 < new Date().time)
         {
            _landingView.send(new class_2380());
            _lastRequestTime = new Date();
         }
      }
      
      private function refreshContent() : void
      {
         if(_pageName == "")
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         _container.findChildByName("page_header_txt").caption = getText("landing.view.pageexpiry.page." + _pageName + ".header");
         _container.findChildByName("page_desc_txt").caption = getText("landing.view.pageexpiry.page." + _pageName + ".desc");
         var _loc1_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("promo_bitmap"));
         _loc1_.assetUri = "${image.library.url}reception/catalog_teaser_" + _pageName + ".png";
         refreshTimer();
      }
      
      private function getText(param1:String) : String
      {
         return "${" + param1 + "}";
      }
      
      private function onOpenCatalogButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.catalog.openCatalogPage(_pageName);
            _landingView.tracking.trackGoogle("landingView","click_goToExpiringCatalogPage");
         }
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:class_2010 = class_2010(_container.findChildByName("countdown_widget"));
         var _loc2_:class_2728 = class_2728(_loc1_.widget);
         _loc2_.seconds = var_4702;
      }
      
      private function onCatalogPage(param1:IMessageEvent) : void
      {
         var _loc2_:class_4064 = class_4064(param1.parser);
         _pageName = _loc2_.pageName;
         var_4702 = _loc2_.secondsToExpiry;
         refreshContent();
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}


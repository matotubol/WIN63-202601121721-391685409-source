package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.session.product.class_59;
   import com.sulake.habbo.window.widgets.class_2728;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_10.class_3141;
   import package_13.class_2727;
   
   public class NextLimitedRareCountdownWidget implements ILandingViewWidget, class_59, ISettingsAwareWidget
   {
      
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_3006:int = 0;
      
      private var var_2228:int;
      
      private var _offerId:int;
      
      private var var_576:String;
      
      private var _lastRequestTime:Date;
      
      private var var_842:Timer;
      
      public function NextLimitedRareCountdownWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_842 != null)
            {
               var_842.stop();
               var_842 = null;
            }
            _landingView = null;
            _container = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("next_ltd_available"));
         _container.findChildByName("get").procedure = onOpenCatalogButton;
         _container.findChildByName("catalogue_button").procedure = onOpenCatalogButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_3141(onLimitedOfferAppearingNextMessage));
         requestLimitedOfferAppearingNextMessage(null);
      }
      
      private function requestLimitedOfferAppearingNextMessage(param1:TimerEvent) : void
      {
         if(!_landingView.getBoolean("next.limited.rare.countdown.widget.disabled"))
         {
            _landingView.communicationManager.connection.send(new class_2727());
         }
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 30000 < new Date().time)
         {
            requestLimitedOfferAppearingNextMessage(null);
            _lastRequestTime = new Date();
         }
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function productDataReady() : void
      {
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         if(disposed)
         {
            return;
         }
         if(_landingView.getProductData(var_576,this) != null)
         {
            _container.findChildByName("get").caption = _landingView.getProductData(var_576,this).name;
         }
         if(var_2228 >= 0)
         {
            _container.visible = true;
            _container.findChildByName("get").visible = true;
            _container.findChildByName("countdown").visible = false;
         }
         else if(var_3006 > 0)
         {
            _container.visible = true;
            _container.findChildByName("get").visible = false;
            _container.findChildByName("countdown").visible = true;
         }
         else
         {
            _container.visible = false;
         }
         refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:class_2010 = class_2010(_container.findChildByName("countdown"));
         var _loc2_:class_2728 = class_2728(_loc1_.widget);
         _loc2_.seconds = var_3006;
         _loc2_.running = true;
      }
      
      private function setModeSwitchTimer(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         if(var_842 != null)
         {
            var_842.stop();
            var_842 = null;
         }
         var_842 = new Timer((param1 + 1) * 1000,1);
         var_842.addEventListener("timer",requestLimitedOfferAppearingNextMessage);
         var_842.start();
      }
      
      private function onLimitedOfferAppearingNextMessage(param1:class_3141) : void
      {
         var_3006 = param1.getParser().appearsInSeconds;
         var_2228 = param1.getParser().pageId;
         _offerId = param1.getParser().offerId;
         var_576 = param1.getParser().productType;
         refreshContent();
         setModeSwitchTimer(var_3006);
      }
      
      private function onOpenCatalogButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.catalog.openCatalogPageById(var_2228,_offerId,"NORMAL");
            _landingView.tracking.trackGoogle("landingView","click_goToNextLimitedCatalogPage");
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}


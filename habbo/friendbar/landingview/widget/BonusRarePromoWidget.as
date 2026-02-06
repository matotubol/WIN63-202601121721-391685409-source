package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.session.product.class_59;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.catalog.BonusRareInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetBonusRareInfoMessageComposer;
   
   public class BonusRarePromoWidget implements ILandingViewWidget, class_59, ISettingsAwareWidget, class_1829
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_576:String;
      
      private var var_3320:int = -1;
      
      private var _totalCoinsForBonus:int;
      
      private var var_3048:int;
      
      public function BonusRarePromoWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            _landingView.roomEngine.events.removeEventListener("REE_ENGINE_INITIALIZED",onRoomEngineInitialized);
            _landingView.communicationManager.removeHabboConnectionMessageEvent(new BonusRareInfoMessageEvent(onBonusRareInfoMessage));
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
         _container = class_1812(_landingView.getXmlWindow("bonus_rare_promo"));
         _container.findChildByName("buy_button").procedure = onOpenCreditsPageButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new BonusRareInfoMessageEvent(onBonusRareInfoMessage));
         _landingView.roomEngine.events.addEventListener("REE_ENGINE_INITIALIZED",onRoomEngineInitialized);
         requestBonusRareInfo();
      }
      
      private function requestBonusRareInfo() : void
      {
         _landingView.communicationManager.connection.send(new GetBonusRareInfoMessageComposer());
      }
      
      public function refresh() : void
      {
         requestBonusRareInfo();
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function productDataReady() : void
      {
         refreshContent();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         refreshContent();
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onRoomEngineInitialized(param1:RoomEngineEvent) : void
      {
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         if(disposed)
         {
            return;
         }
         _container.visible = var_3320 != -1;
         var _loc1_:class_1949 = _landingView.getProductData(var_576,this);
         if(_loc1_ != null)
         {
            IStaticBitmapWrapperWindow(_container.findChildByName("promo_image")).assetUri = _landingView.getProperty("landing.view.bonus.rare.image.uri");
            _container.findChildByName("header").caption = _landingView.localizationManager.getLocalizationWithParams("landing.view.bonus.rare.header","","rarename",_loc1_.name,"amount",_totalCoinsForBonus);
            _container.findChildByName("status").caption = _landingView.localizationManager.getLocalizationWithParams("landing.view.bonus.rare.status","","amount",var_3048,"total",_totalCoinsForBonus);
            setProgress(_totalCoinsForBonus - var_3048,_totalCoinsForBonus);
         }
      }
      
      private function onBonusRareInfoMessage(param1:BonusRareInfoMessageEvent) : void
      {
         var_576 = param1.getParser().productType;
         var_3320 = param1.getParser().productClassId;
         _totalCoinsForBonus = param1.getParser().totalCoinsForBonus;
         var_3048 = param1.getParser().coinsStillRequiredToBuy;
         refreshContent();
      }
      
      private function onOpenCreditsPageButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.tracking.trackGoogle("landingView","click_bonusRarePromoOpenCreditsPage");
            _landingView.catalog.openCreditsHabblet();
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
      
      private function setProgress(param1:int, param2:int) : void
      {
         var _loc5_:int = int(_container.findChildByName("bar_a_bkg").width);
         var _loc4_:int = int(_container.findChildByName("bar_a_bkg").x);
         var _loc3_:int = param1 / param2 * _loc5_;
         _container.findChildByName("bar_a_c").width = _loc3_;
         _container.findChildByName("bar_a_r").x = _loc3_ + _loc4_;
      }
   }
}


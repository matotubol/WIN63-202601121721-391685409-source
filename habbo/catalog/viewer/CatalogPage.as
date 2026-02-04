package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.AddOnBadgeViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderAddonsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderLoyaltyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderSubscriptionCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuyGuildWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.FeaturedItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.FirstProductSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildBadgeViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildForumSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LoyaltyVipBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RecyclerCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RecyclerPrizesCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RoomAdsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SimplePriceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SoldLtdItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpinnerCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TotalPriceWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.UniqueLimitedItemWidget;
   import com.sulake.habbo.catalog.viewer.widgets.UserBadgeSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.VipBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.WarningCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.class_2612;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
   import flash.events.Event;
   
   public class CatalogPage implements class_2044
   {
      
      protected static const LAYOUT_MAGIC_PREFIX:String = "layout_";
      
      public static const MODE_NORMAL:int = 0;
      
      public static const MODE_SEARCH:int = 1;
      
      protected var _layout:XML;
      
      protected var _window:class_1812;
      
      private var var_2217:class_2109;
      
      private var var_2228:int;
      
      private var var_1333:String;
      
      private var _offers:Vector.<class_1793>;
      
      private var _localization:class_1998;
      
      private var var_35:Array = [];
      
      private var _widgetEvents:EventDispatcherWrapper;
      
      private var _catalog:HabboCatalog;
      
      private var var_5278:int;
      
      private var var_2272:ItemGridCatalogWidget;
      
      private var var_3043:Boolean;
      
      private var var_261:int;
      
      public function CatalogPage(param1:class_2109, param2:int, param3:String, param4:class_1998, param5:Vector.<class_1793>, param6:HabboCatalog, param7:Boolean, param8:int = -1)
      {
         super();
         var_2217 = param1;
         var_2228 = param2;
         var_1333 = param3;
         _localization = param4;
         _offers = param5;
         _catalog = param6;
         for each(var _loc9_ in param5)
         {
            _loc9_.page = this;
         }
         _widgetEvents = new EventDispatcherWrapper();
         var_35 = [];
         var_3043 = param7;
         if(param8 == -1)
         {
            var_261 = 0;
         }
         else
         {
            var_261 = param8;
         }
         init();
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get viewer() : class_2109
      {
         return var_2217;
      }
      
      public function get pageId() : int
      {
         return var_261 == 1 ? -12345678 : var_2228;
      }
      
      public function get layoutCode() : String
      {
         return var_1333;
      }
      
      public function get offers() : Vector.<class_1793>
      {
         return _offers;
      }
      
      public function get localization() : class_1998
      {
         return _localization;
      }
      
      public function get links() : Array
      {
         return _localization.getLinks(var_1333);
      }
      
      public function get hasLinks() : Boolean
      {
         return _localization.hasLinks(var_1333);
      }
      
      public function get acceptSeasonCurrencyAsCredits() : Boolean
      {
         return var_3043;
      }
      
      public function get allowDragging() : Boolean
      {
         return var_1333 != "sold_ltd_items";
      }
      
      public function set searchPageId(param1:int) : void
      {
         var_5278 = param1;
      }
      
      public function get mode() : int
      {
         return var_261;
      }
      
      public function get isBuilderPage() : Boolean
      {
         return _catalog.catalogType == "BUILDERS_CLUB";
      }
      
      public function selectOffer(param1:int) : void
      {
         var _loc3_:class_2253 = null;
         var _loc4_:ITextFieldWindow = null;
         if(var_2272 != null && param1 > -1)
         {
            class_21.log("selecting offer " + param1);
            for each(var _loc2_ in _offers)
            {
               if(_loc2_.offerId == param1)
               {
                  _loc3_ = _loc2_.gridItem;
                  var_2272.select(_loc3_,true);
               }
            }
         }
         if(_window && _window.findChildByName("trophyWidget") != null)
         {
            _loc4_ = _window.findChildByName("input_text") as ITextFieldWindow;
            _loc4_.focus();
            _loc4_.activate();
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc2_ in var_35)
         {
            _loc2_.dispose();
         }
         var_35 = null;
         _localization.dispose();
         for each(var _loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers = new Vector.<class_1793>(0);
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_widgetEvents != null)
         {
            _widgetEvents.dispose();
            _widgetEvents = null;
         }
         var_2217 = null;
         _layout = null;
         var_2228 = 0;
         var_1333 = "";
         var_3043 = false;
      }
      
      public function init() : void
      {
         if(createWindow(layoutCode))
         {
            createWidgets();
         }
      }
      
      public function closed() : void
      {
         if(var_35 != null)
         {
            for each(var _loc1_ in var_35)
            {
               _loc1_.closed();
            }
         }
      }
      
      protected function createWindow(param1:String) : Boolean
      {
         if(param1 == "frontpage4")
         {
            param1 = "frontpage_featured";
         }
         var _loc2_:String = "layout_" + param1;
         if(var_2217.viewerTags.indexOf("UBUNTU") > -1)
         {
            if(!viewer.catalog.assets.hasAsset(_loc2_))
            {
               _loc2_ = "old_" + _loc2_;
            }
         }
         else
         {
            _loc2_ = "old_" + _loc2_;
         }
         var _loc3_:XmlAsset = viewer.catalog.assets.getAssetByName(_loc2_) as XmlAsset;
         if(_loc3_ == null)
         {
            class_21.log("Could not find asset for layout " + _loc2_);
            return false;
         }
         _layout = _loc3_.content as XML;
         _window = viewer.catalog.windowManager.buildFromXML(_layout) as class_1812;
         if(_window == null)
         {
            class_21.log("Could not create layout " + param1);
            return false;
         }
         return true;
      }
      
      private function localize() : void
      {
      }
      
      private function createWidgets() : void
      {
         createWidgetsRecursion(_window);
         initializeWidgets();
      }
      
      private function createWidgetsRecursion(param1:class_1812) : void
      {
         var _loc2_:int = 0;
         var _loc3_:class_1812 = null;
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.numChildren)
            {
               _loc3_ = param1.getChildAt(_loc2_) as class_1812;
               if(_loc3_ != null)
               {
                  createWidget(_loc3_);
                  createWidgetsRecursion(_loc3_);
               }
               _loc2_++;
            }
         }
      }
      
      private function createWidget(param1:class_1812) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.name)
         {
            case "itemGridWidget":
               if(var_2272 == null)
               {
                  var_2272 = new ItemGridCatalogWidget(param1,_catalog.sessionDataManager,_catalog.catalogType);
                  var_35.push(var_2272);
               }
               break;
            case "productViewWidget":
               var_35.push(new ProductViewCatalogWidget(param1,_catalog));
               break;
            case "songDiskProductViewWidget":
               var_35.push(new SongDiskProductViewCatalogWidget(param1,_catalog));
               break;
            case "singleViewWidget":
               var_35.push(new SingleViewCatalogWidget(param1,_catalog));
               break;
            case "purchaseWidget":
               var_35.push(new PurchaseCatalogWidget(param1,_catalog));
               break;
            case "colourGridWidget":
               var_35.push(new ColourGridCatalogWidget(param1));
               break;
            case "traxPreviewWidget":
               var_35.push(new TraxPreviewCatalogWidget(param1,_catalog.soundManager));
               break;
            case "redeemItemCodeWidget":
               var_35.push(new RedeemItemCodeCatalogWidget(param1));
               break;
            case "spacesNewWidget":
               var_35.push(new SpacesNewCatalogWidget(param1,_catalog.sessionDataManager,_catalog.catalogType));
               break;
            case "roomPreviewWidget":
               var_35.push(new RoomPreviewCatalogWidget(param1));
               break;
            case "trophyWidget":
               var_35.push(new TrophyCatalogWidget(param1,_catalog));
               break;
            case "addOnBadgeViewWidget":
               var_35.push(new AddOnBadgeViewCatalogWidget(param1));
               break;
            case "petsWidget":
               var_35.push(new PetsCatalogWidget(param1,_catalog));
               break;
            case "newPetsWidget":
               var_35.push(new NewPetsCatalogWidget(param1,_catalog));
               break;
            case "roomAdsCatalogWidget":
               var_35.push(new RoomAdsCatalogWidget(param1,_catalog));
               break;
            case "textInputWidget":
               var_35.push(new TextInputCatalogWidget(param1));
               break;
            case "specialInfoWidget":
               var_35.push(new SpecialInfoWidget(param1));
               break;
            case "recyclerWidget":
               var_35.push(new RecyclerCatalogWidget(param1));
               break;
            case "recyclerPrizesWidget":
               var_35.push(new RecyclerPrizesCatalogWidget(param1));
               break;
            case "marketPlaceWidget":
               var_35.push(new MarketPlaceCatalogWidget(param1));
               break;
            case "marketPlaceOwnItemsWidget":
               var_35.push(new MarketPlaceOwnItemsCatalogWidget(param1));
               break;
            case "clubGiftWidget":
               var_35.push(new ClubGiftWidget(param1,_catalog.getClubGiftController(),_catalog));
               break;
            case "clubBuyWidget":
               var_35.push(new ClubBuyCatalogWidget(param1));
               break;
            case "vipBuyWidget":
               var_35.push(new VipBuyCatalogWidget(param1,_catalog));
               break;
            case "loyaltyVipBuyWidget":
               var_35.push(new LoyaltyVipBuyCatalogWidget(param1,_catalog));
               break;
            case "vipGiftWidget":
               var_35.push(new VipBuyCatalogWidget(param1,_catalog,true));
               break;
            case "activityPointDisplayWidget":
               var_35.push(new ActivityPointDisplayCatalogWidget(param1));
               break;
            case "madMoneyWidget":
               var_35.push(new MadMoneyCatalogWidget(param1));
               break;
            case "buyGuildWidget":
               var_35.push(new BuyGuildWidget(param1));
               break;
            case "guildBadgeViewWidget":
               var_35.push(new GuildBadgeViewCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "guildSelectorWidget":
               var_35.push(new GuildSelectorCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "guildForumSelectorWidget":
               var_35.push(new GuildForumSelectorCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "petPreviewWidget":
               var_35.push(new PetPreviewCatalogWidget(param1,_catalog));
               break;
            case "spinnerWidget":
               var_35.push(new SpinnerCatalogWidget(param1,_catalog));
               break;
            case "bundlePurchaseExtraInfoWidget":
               var_35.push(new BundlePurchaseExtraInfoWidget(param1,_catalog));
               break;
            case "totalPriceWidget":
               var_35.push(new TotalPriceWidget(param1,_catalog));
               break;
            case "limitedItemWidget":
               var_35.push(new UniqueLimitedItemWidget(param1,_catalog));
               break;
            case "soldLtdItemsWidget":
               var_35.push(new SoldLtdItemsCatalogWidget(param1,_catalog));
               break;
            case "userBadgeSelectorWidget":
               var_35.push(new UserBadgeSelectorCatalogWidget(param1,_catalog));
               break;
            case "bundleGridScrollWidget":
               var_35.push(new BundleGridViewCatalogWidget(param1));
               break;
            case "simplePriceWidget":
               var_35.push(new SimplePriceCatalogWidget(param1,_catalog));
               break;
            case "builderWidget":
               var_35.push(new BuilderCatalogWidget(param1,_catalog));
               break;
            case "builderSubscriptionWidget":
               var_35.push(new BuilderSubscriptionCatalogWidget(param1,_catalog));
               break;
            case "builderAddonsWidget":
               var_35.push(new BuilderAddonsCatalogWidget(param1,_catalog));
               break;
            case "builderLoyaltyWidget":
               var_35.push(new BuilderLoyaltyCatalogWidget(param1,_catalog));
               break;
            case "warningWidget":
               var_35.push(new WarningCatalogWidget(param1));
               break;
            case "firstProductAutoSelectorWidget":
               var_35.push(new FirstProductSelectorCatalogWidget(param1));
               break;
            case "featuredItemsWidget":
               var_35.push(new FeaturedItemsCatalogWidget(param1,_catalog));
         }
      }
      
      private function initializeWidgets() : void
      {
         var _loc3_:* = null;
         var _loc6_:ColourGridCatalogWidget = null;
         var _loc7_:ItemGridCatalogWidget = null;
         var _loc1_:class_1812 = null;
         var _loc4_:int = 0;
         var _loc5_:class_1812 = null;
         var _loc2_:Array = [];
         if(var_1333 == "default_3x3_color_grouping")
         {
            _loc1_ = _window.findChildByName("itemGridWidget") as class_1812;
            _loc4_ = 3;
            _loc1_.height = 64 - _loc4_;
            _loc5_ = _window.findChildByName("colourGridWidget") as class_1812;
            _loc5_.visible = true;
            _loc5_.width = 360;
            _loc5_.x = _loc1_.x;
            _loc5_.y = _loc1_.y + _loc1_.height + _loc4_;
            _loc5_.height = 91;
            _loc6_ = new ColourGridCatalogWidget(_loc5_);
            var_35.push(_loc6_);
         }
         for each(_loc3_ in var_35)
         {
            _loc3_.page = this;
            if(_loc3_ is ItemGridCatalogWidget)
            {
               _loc7_ = _loc3_ as ItemGridCatalogWidget;
            }
            _loc3_.events = _widgetEvents;
            if(!_loc3_.init())
            {
               _loc2_.push(_loc3_);
            }
         }
         removeWidgets(_loc2_);
         initializeLocalizations();
         _widgetEvents.dispatchEvent(new CatalogWidgetEvent("WIDGETS_INITIALIZED"));
      }
      
      private function initializeLocalizations() : void
      {
         var _loc1_:class_2612 = new LocalizationCatalogWidget(_window,_catalog);
         var_35.push(_loc1_);
         _loc1_.page = this;
         _loc1_.events = _widgetEvents;
         _loc1_.init();
      }
      
      private function removeWidgets(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         for each(_loc3_ in var_35)
         {
            if(_loc3_.window != null)
            {
               for each(_loc2_ in param1)
               {
                  if(_loc2_.window != null)
                  {
                     if(_loc2_.window.getChildIndex(_loc3_.window) >= 0)
                     {
                        if(param1.indexOf(_loc3_) < 0)
                        {
                           param1.push(_loc3_);
                        }
                        break;
                     }
                  }
               }
            }
         }
         for each(_loc2_ in param1)
         {
            if(_loc2_.window != null)
            {
               _window.removeChild(_loc2_.window);
               _loc2_.window.dispose();
            }
            _loc4_ = int(var_35.indexOf(_loc2_));
            if(_loc4_ >= 0)
            {
               var_35.splice(_loc4_,1);
            }
            _loc2_.dispose();
         }
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         if(_widgetEvents != null)
         {
            return _widgetEvents.dispatchEvent(param1);
         }
         return false;
      }
      
      public function replaceOffers(param1:Vector.<class_1793>, param2:Boolean = false) : void
      {
         if(param2)
         {
            for each(var _loc3_ in _offers)
            {
               _loc3_.dispose();
            }
         }
         _offers = param1;
      }
      
      public function updateLimitedItemsLeft(param1:int, param2:int) : void
      {
         for each(var _loc3_ in _offers)
         {
            if(_loc3_.offerId == param1)
            {
               _loc3_.product.uniqueLimitedItemsLeft = param2;
               _widgetEvents.dispatchEvent(new ProductOfferUpdatedEvent(_loc3_));
               return;
            }
         }
      }
   }
}


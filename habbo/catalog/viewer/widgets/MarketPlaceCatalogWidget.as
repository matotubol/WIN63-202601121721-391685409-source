package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
   import com.sulake.habbo.catalog.marketplace.MarketplaceChart;
   import com.sulake.habbo.catalog.marketplace.class_2042;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class MarketPlaceCatalogWidget extends CatalogWidget implements class_2612, class_1829, IMarketPlaceVisualization
   {
      
      private const STATUS_SEARCHING:int = 1;
      
      private const STATUS_LIST_AVAILABLE:int = 2;
      
      private const MAX_SEARCH_STRING_LENGTH:int = 40;
      
      private const MAX_PRICE_STRING_LENGTH:int = 10;
      
      private var var_905:Array = [];
      
      private var var_2092:MarketPlaceOfferData;
      
      private var _itemList:IItemListWindow;
      
      private var var_1420:class_1812;
      
      private var var_896:Timer;
      
      private var _offers:class_55;
      
      private var var_2130:int;
      
      public function MarketPlaceCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2092 = null;
         _offers = null;
         _itemList = null;
         if(var_1420)
         {
            var_1420.dispose();
            var_1420 = null;
         }
         if(var_896)
         {
            var_896.removeEventListener("timer",onPopulationTimer);
            var_896 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(marketPlace == null)
         {
            return false;
         }
         marketPlace.registerVisualization(this);
         displayMainView();
         var _loc1_:IItemListWindow = _window.findChildByName("offer_list") as IItemListWindow;
         var_1420 = _loc1_.removeListItem(_loc1_.getListItemByName("offer_item")) as class_1812;
         return true;
      }
      
      public function listUpdatedNotify() : void
      {
         hideDetails();
         updateList();
      }
      
      public function updateStats() : void
      {
         var _loc9_:MarketplaceChart = null;
         var _loc3_:BitmapData = null;
         var _loc10_:String = null;
         if(!marketPlace || !marketPlace.localization || !_window)
         {
            return;
         }
         var _loc2_:class_2042 = marketPlace.itemStats;
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:class_1812 = _window.findChildByName("details_container") as class_1812;
         if(!_loc5_ || !_loc5_.visible)
         {
            return;
         }
         var _loc4_:class_1741 = _loc5_.findChildByName("offer_count");
         if(_loc4_)
         {
            marketPlace.localization.registerParameter("catalog.marketplace.offer_details.offer_count","count",_loc2_.offerCount.toString());
            _loc4_.visible = true;
         }
         var _loc6_:ISelectorWindow = _loc5_.findChildByName("chart_selector") as ISelectorWindow;
         if(!_loc6_)
         {
            return;
         }
         var _loc1_:ISelectableWindow = _loc6_.getSelected();
         if(!_loc1_)
         {
            return;
         }
         switch(_loc1_.name)
         {
            case "price_development":
               _loc9_ = new MarketplaceChart(_loc2_.dayOffsets,_loc2_.averagePrices);
               break;
            case "trade_volume":
               _loc9_ = new MarketplaceChart(_loc2_.dayOffsets,_loc2_.soldAmounts);
               break;
            default:
               return;
         }
         if(!_loc9_)
         {
            return;
         }
         var _loc7_:class_2251 = _loc5_.findChildByName("chart_bitmap") as class_2251;
         if(_loc7_)
         {
            _loc7_.bitmap = null;
            _loc7_.bitmap = new BitmapData(_loc7_.width,_loc7_.height);
            _loc3_ = _loc9_.draw(_loc7_.width,_loc7_.height);
            _loc7_.bitmap.draw(_loc3_);
            _loc3_.dispose();
         }
         var _loc8_:class_1741 = _loc5_.findChildByName("chart_title");
         if(_loc8_)
         {
            if(_loc9_.available)
            {
               _loc10_ = "catalog.marketplace.offer_details.chart_title." + _loc1_.name;
               marketPlace.localization.registerParameter(_loc10_,"days",_loc2_.historyLength.toString());
            }
            else
            {
               _loc10_ = "catalog.marketplace.offer_details.chart_title.not_available";
            }
            _loc8_.caption = marketPlace.localization.getLocalization(_loc10_);
         }
      }
      
      private function get marketPlace() : IMarketPlace
      {
         if(page && page.viewer && page.viewer.catalog)
         {
            return page.viewer.catalog.getMarketPlace();
         }
         return null;
      }
      
      public function displayMainView() : void
      {
         attachWidgetView("marketPlaceWidget");
         window.procedure = onWidgetEvent;
         _itemList = window.findChildByName("offer_list") as IItemListWindow;
         selectSearchCategory("search_by_activity");
      }
      
      private function selectSearchCategory(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc4_:ISelectorWindow = _window.findChildByName("search_selector") as ISelectorWindow;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:ISelectableWindow = _loc4_.getSelectableByName(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc4_.setSelected(_loc2_);
         var _loc3_:class_1812 = _window.findChildByName("search_container") as class_1812;
         if(_loc3_ == null)
         {
            return;
         }
         while(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         switch(param1)
         {
            case "search_by_value":
               _loc5_ = "marketplace_search_simple";
               var_905 = [1,2];
               break;
            case "search_by_activity":
               _loc5_ = "marketplace_search_simple";
               var_905 = [3,4,5,6];
               break;
            case "search_advanced":
               _loc5_ = "marketplace_search_advanced";
               var_905 = [1,2,3,4,5,6];
               break;
            default:
               return;
         }
         var _loc7_:class_1812 = createWindow(_loc5_) as class_1812;
         _loc3_.addChild(_loc7_);
         var _loc6_:class_2261 = _window.findChildByName("sort_dropmenu") as class_2261;
         if(_loc6_ != null)
         {
            _loc6_.populate(getSortKeys(var_905));
            _loc6_.selection = 0;
         }
      }
      
      private function getSortKeys(param1:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            _loc2_.push("${catalog.marketplace.sort." + _loc3_ + "}");
         }
         return _loc2_;
      }
      
      private function createWindow(param1:String) : class_1741
      {
         if(!page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets || !page.viewer.catalog.windowManager)
         {
            return null;
         }
         var _loc3_:XmlAsset = page.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return page.viewer.catalog.windowManager.buildFromXML(_loc2_);
      }
      
      private function updateStatusDisplay(param1:int, param2:int = -1, param3:int = -1) : void
      {
         var _loc6_:String = null;
         var _loc4_:class_27 = marketPlace.localization;
         if(!_loc4_)
         {
            return;
         }
         if(!window || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         var _loc5_:class_1741 = window.findChildByName("status_text");
         if(_loc5_ == null)
         {
            return;
         }
         if(param1 == 1)
         {
            _loc6_ = _loc4_.getLocalization("catalog.marketplace.searching");
         }
         else if(param3 > 0)
         {
            _loc6_ = _loc4_.getLocalization("catalog.marketplace.items_found");
            _loc6_ = _loc6_.replace("%count%",param3);
            if(param2 > 0 && param2 < param3)
            {
               _loc6_ += ". " + _loc4_.getLocalization("catalog.marketplace.items_shown") + ".";
               _loc6_ = _loc6_.replace("%count%",param2);
            }
         }
         else
         {
            _loc6_ = _loc4_.getLocalization("catalog.marketplace.no_items");
         }
         _loc5_.caption = _loc6_;
      }
      
      private function updateList() : void
      {
         if(!marketPlace || !window)
         {
            return;
         }
         var _loc1_:class_55 = marketPlace.latestOffers();
         if(!_loc1_)
         {
            return;
         }
         var _loc3_:int = marketPlace.totalItemsFound();
         _offers = _loc1_;
         if(!_itemList)
         {
            return;
         }
         _itemList.destroyListItems();
         if(!var_1420)
         {
            return;
         }
         var _loc2_:Array = _loc1_.getKeys();
         if(_loc2_ == null)
         {
            return;
         }
         updateStatusDisplay(2,_loc2_.length,_loc3_);
         if(!var_896)
         {
            var_896 = new Timer(25);
            var_896.addEventListener("timer",onPopulationTimer);
         }
         var_2130 = 0;
         populateList();
         var_896.start();
      }
      
      private function onPopulationTimer(param1:TimerEvent) : void
      {
         if(!var_896)
         {
            return;
         }
         if(populateList())
         {
            var_896.stop();
         }
      }
      
      private function populateList() : Boolean
      {
         var _loc1_:int = 0;
         if(!_offers)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(var_2130 >= _offers.length)
            {
               return true;
            }
            addListItem(_offers.getWithIndex(var_2130));
            var_2130 = var_2130 + 1;
            _loc1_++;
         }
         return false;
      }
      
      private function addListItem(param1:MarketPlaceOfferData) : void
      {
         var _loc17_:String = null;
         var _loc6_:String = null;
         var _loc5_:class_2251 = null;
         var _loc12_:Point = null;
         var _loc13_:class_1741 = null;
         var _loc3_:class_2010 = null;
         var _loc10_:ILimitedItemGridOverlayWidget = null;
         var _loc7_:class_2010 = null;
         var _loc2_:IRarityItemGridOverlayWidget = null;
         var _loc8_:class_1741 = null;
         if(!param1 || !_itemList || !var_1420 || !marketPlace.localization)
         {
            return;
         }
         var _loc14_:class_1812 = var_1420.clone() as class_1812;
         if(!_loc14_ || Boolean(_loc14_.disposed))
         {
            return;
         }
         var _loc9_:class_1741 = _loc14_.findChildByName("item_name");
         if(_loc9_ != null)
         {
            _loc9_.caption = "${" + marketPlace.getNameLocalizationKey(param1) + "}";
         }
         var _loc15_:class_1741 = _loc14_.findChildByName("item_desc");
         if(_loc15_ != null)
         {
            _loc15_.caption = "${" + marketPlace.getDescriptionLocalizationKey(param1) + "}";
         }
         var _loc16_:class_1741 = _loc14_.findChildByName("item_price");
         if(_loc16_ != null)
         {
            _loc17_ = marketPlace.localization.getLocalization("catalog.marketplace.offer.price_public_item");
            _loc17_ = _loc17_.replace("%price%",param1.price);
            _loc17_ = _loc17_.replace("%average%",param1.averagePrice != 0 ? param1.averagePrice.toString() : " - ");
            _loc16_.caption = _loc17_;
         }
         var _loc11_:class_1741 = _loc14_.findChildByName("offer_count");
         if(_loc11_)
         {
            _loc6_ = marketPlace.localization.getLocalization("catalog.marketplace.offer_count");
            _loc6_ = _loc6_.replace("%count%",param1.offerCount);
            _loc11_.caption = _loc6_;
         }
         if(param1.image == null)
         {
            var _loc4_:class_2198 = getFurniImageResult(param1.furniId,param1.furniType,param1.extraData);
            if(_loc4_ != null && null.data != null)
            {
               param1.image = null.data as BitmapData;
               param1.imageCallback = null.id;
            }
            _loc14_.id = null.id;
         }
         if(param1.image != null)
         {
            _loc5_ = _loc14_.findChildByName("item_image") as class_2251;
            if(_loc5_ != null)
            {
               _loc12_ = new Point((_loc5_.width - param1.image.width) / 2,(_loc5_.height - param1.image.height) / 2);
               if(_loc5_.bitmap == null)
               {
                  _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
               }
               _loc5_.bitmap.copyPixels(param1.image,param1.image.rect,_loc12_);
            }
         }
         if(param1.isUniqueLimitedItem)
         {
            _loc13_ = _loc14_.findChildByName("unique_item_background_bitmap");
            _loc3_ = class_2010(_loc14_.findChildByName("unique_item_overlay_widget"));
            _loc10_ = ILimitedItemGridOverlayWidget(_loc3_.widget);
            _loc10_.serialNumber = param1.stuffData.uniqueSerialNumber;
            _loc10_.animated = true;
            _loc13_.visible = true;
            _loc3_.visible = true;
         }
         if(param1.stuffData && param1.stuffData.rarityLevel >= 0)
         {
            _loc7_ = class_2010(_loc14_.findChildByName("rarity_item_overlay_widget"));
            _loc2_ = IRarityItemGridOverlayWidget(_loc7_.widget);
            _loc7_.visible = true;
            _loc2_.rarityLevel = param1.stuffData.rarityLevel;
         }
         if(marketPlace.isAccountSafetyLocked())
         {
            _loc8_ = _loc14_.findChildByName("buy_button");
            if(_loc8_ != null)
            {
               _loc8_.disable();
            }
         }
         _itemList.addListItem(_loc14_);
         _loc14_.procedure = onOfferListEvent;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc5_:* = null;
         var _loc7_:class_2251 = null;
         var _loc6_:Point = null;
         if(disposed || !marketPlace || !param2 || !_itemList || !_offers)
         {
            return;
         }
         var _loc4_:Array = [];
         if(_itemList.groupListItemsWithID(param1,_loc4_))
         {
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_)
               {
                  _loc7_ = _loc5_.findChildByName("item_image") as class_2251;
                  if(_loc7_ != null)
                  {
                     _loc7_.bitmap = new BitmapData(_loc7_.width,_loc7_.height,true,16777215);
                     _loc6_ = new Point((_loc7_.width - param2.width) / 2,(_loc7_.height - param2.height) / 2);
                     _loc7_.bitmap.copyPixels(param2,param2.rect,_loc6_,null,null,true);
                  }
                  _loc5_.id = 0;
               }
            }
         }
         for each(var _loc3_ in _offers)
         {
            if(_loc3_.imageCallback == param1)
            {
               _loc3_.imageCallback = 0;
               _loc3_.image = param2;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getFurniImageResult(param1:int, param2:int, param3:String = null) : class_2198
      {
         if(!page || !page.viewer || !page.viewer.roomEngine)
         {
            return null;
         }
         if(param2 == 1)
         {
            return page.viewer.roomEngine.getFurnitureIcon(param1,this);
         }
         if(param2 == 2)
         {
            return page.viewer.roomEngine.getWallItemIcon(param1,this,param3);
         }
         return null;
      }
      
      private function onOfferListEvent(param1:class_1758, param2:class_1741 = null) : void
      {
         var _loc5_:int = 0;
         var _loc3_:class_55 = null;
         var _loc4_:MarketPlaceOfferData = null;
         if(param1.type == "WME_CLICK")
         {
            if(!window || !marketPlace || !param2)
            {
               return;
            }
            if(_itemList == null)
            {
               return;
            }
            _loc5_ = _itemList.getListItemIndex(param1.window.parent);
            _loc3_ = marketPlace.latestOffers();
            _loc4_ = _loc3_.getWithIndex(_loc5_) as MarketPlaceOfferData;
            if(!_loc4_)
            {
               return;
            }
            switch(param2.name)
            {
               case "buy_button":
                  marketPlace.buyOffer(_loc4_.offerId);
                  break;
               case "more_button":
                  showDetails(_loc4_);
            }
         }
      }
      
      private function showDetails(param1:MarketPlaceOfferData) : void
      {
         if(!param1 || !_window || !marketPlace)
         {
            return;
         }
         var_2092 = param1;
         var _loc2_:class_27 = marketPlace.localization;
         if(!_loc2_)
         {
            return;
         }
         _window.getChildAt(0).visible = false;
         var _loc12_:class_1812 = _window.findChildByName("details_container") as class_1812;
         if(_loc12_)
         {
            _loc12_.visible = true;
         }
         else
         {
            _loc12_ = createWindow("marketplace_offer_details") as class_1812;
            _window.addChild(_loc12_);
            _loc12_.procedure = detailsEventHandler;
         }
         var _loc8_:class_1741 = _loc12_.findChildByName("item_name");
         if(_loc8_)
         {
            _loc8_.caption = "${" + marketPlace.getNameLocalizationKey(param1) + "}";
         }
         _loc8_ = _loc12_.findChildByName("item_description");
         if(_loc8_)
         {
            _loc8_.caption = "${" + marketPlace.getDescriptionLocalizationKey(param1) + "}";
         }
         _loc8_ = _loc12_.findChildByName("item_count");
         if(_loc8_)
         {
            _loc8_.visible = false;
         }
         _loc2_.registerParameter("catalog.marketplace.offer_details.price","price",param1.price.toString());
         _loc2_.registerParameter("catalog.marketplace.offer_details.average_price","days",marketPlace.averagePricePeriod.toString());
         var _loc4_:String = param1.averagePrice == 0 ? " - " : param1.averagePrice.toString();
         _loc2_.registerParameter("catalog.marketplace.offer_details.average_price","average",_loc4_);
         if(param1.image == null)
         {
            var _loc6_:class_2198 = getFurniImageResult(param1.furniId,param1.furniType,param1.extraData);
            if(_loc6_ != null && null.data != null)
            {
               param1.image = null.data as BitmapData;
               param1.imageCallback = null.id;
            }
         }
         if(param1.image != null)
         {
            var _loc7_:class_2251 = _loc12_.findChildByName("item_image") as class_2251;
            if(_loc7_ != null)
            {
               null.bitmap = null;
               null.bitmap = new BitmapData(null.width,null.height,true,0);
               null.bitmap.draw(param1.image,new Matrix(1,0,0,1,(null.width - param1.image.width) / 2,(null.height - param1.image.height) / 2));
            }
         }
         var _loc13_:ISelectorWindow = _loc12_.findChildByName("chart_selector") as ISelectorWindow;
         if(_loc13_)
         {
            _loc13_.setSelected(_loc13_.getSelectableAt(0));
         }
         var _loc14_:class_2251 = _loc12_.findChildByName("chart_bitmap") as class_2251;
         if(_loc14_)
         {
            _loc14_.bitmap = null;
         }
         var _loc5_:class_2010 = class_2010(_loc12_.findChildByName("unique_item_overlay_widget"));
         if(param1.isUniqueLimitedItem)
         {
            var _loc11_:ILimitedItemPreviewOverlayWidget = ILimitedItemPreviewOverlayWidget(_loc5_.widget);
            _loc11_.serialNumber = param1.stuffData.uniqueSerialNumber;
            null.seriesSize = param1.stuffData.uniqueSeriesSize;
            _loc5_.visible = true;
         }
         else
         {
            _loc5_.visible = false;
         }
         var _loc9_:class_2010 = class_2010(_loc12_.findChildByName("rarity_item_overlay_widget"));
         if(param1.stuffData && param1.stuffData.rarityLevel >= 0)
         {
            var _loc3_:IRarityItemGridOverlayWidget = IRarityItemGridOverlayWidget(_loc9_.widget);
            _loc9_.visible = true;
            null.rarityLevel = param1.stuffData.rarityLevel;
         }
         else
         {
            _loc9_.visible = false;
         }
         if(marketPlace.isAccountSafetyLocked())
         {
            var _loc10_:class_1741 = _loc12_.findChildByName("buy_button");
            if(_loc10_ != null)
            {
               null.disable();
            }
         }
         marketPlace.requestItemStats(param1.furniType,param1.furniId);
      }
      
      private function hideDetails() : void
      {
         if(!_window)
         {
            return;
         }
         var_2092 = null;
         var _loc1_:class_1741 = _window.findChildByName("details_container");
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
         _window.getChildAt(0).visible = true;
      }
      
      private function doSearch() : void
      {
         var _loc1_:class_1741 = null;
         updateStatusDisplay(1);
         var _loc4_:int = -1;
         var _loc6_:int = -1;
         var _loc2_:String = "";
         var _loc3_:int = 1;
         _loc1_ = _window.findChildByName("min_price_input");
         if(_loc1_)
         {
            if(_loc1_.caption == "")
            {
               _loc4_ = -1;
            }
            else
            {
               _loc4_ = parseInt(_loc1_.caption);
            }
         }
         _loc1_ = _window.findChildByName("max_price_input");
         if(_loc1_)
         {
            if(_loc1_.caption == "")
            {
               _loc6_ = -1;
            }
            else
            {
               _loc6_ = parseInt(_loc1_.caption);
            }
         }
         _loc1_ = _window.findChildByName("search_input");
         if(_loc1_)
         {
            _loc2_ = _loc1_.caption;
         }
         var _loc5_:class_2261 = _window.findChildByName("sort_dropmenu") as class_2261;
         if(_loc5_ && _loc5_.selection >= 0 && _loc5_.selection < var_905.length)
         {
            _loc3_ = int(var_905[_loc5_.selection]);
         }
         marketPlace.requestOffers(_loc4_,_loc6_,_loc2_,_loc3_);
      }
      
      private function onWidgetEvent(param1:class_1758, param2:class_1741 = null) : void
      {
         var _loc7_:ISelectorWindow = null;
         var _loc6_:ISelectableWindow = null;
         var _loc5_:ITextFieldWindow = null;
         var _loc8_:int = 0;
         if(!param1 || !param2 || !marketPlace)
         {
            return;
         }
         var _loc3_:class_27 = marketPlace.localization;
         var _loc4_:class_1741 = window.findChildByName("search_input");
         if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "sort_dropmenu":
                  _loc7_ = _window.findChildByName("search_selector") as ISelectorWindow;
                  if(!_loc7_)
                  {
                     return;
                  }
                  _loc6_ = _loc7_.getSelected();
                  if(!_loc6_)
                  {
                     return;
                  }
                  if(_loc6_.name == "search_by_value" || _loc6_.name == "search_by_activity")
                  {
                     doSearch();
                  }
                  break;
               case "search_by_value":
               case "search_by_activity":
               case "search_advanced":
                  selectSearchCategory(param2.name);
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "search_input":
                  if(_loc3_ && _loc4_ && _loc4_.caption == _loc3_.getLocalization("catalog.marketplace.search_name"))
                  {
                     _loc4_.caption = "";
                  }
                  break;
               case "search_button":
                  if(_loc3_ && _loc4_ && _loc4_.caption == _loc3_.getLocalization("catalog.marketplace.search_name"))
                  {
                     return;
                  }
                  doSearch();
            }
         }
         else if(param1.type == "WE_CHANGE")
         {
            _loc5_ = param2 as ITextFieldWindow;
            if(!_loc5_)
            {
               return;
            }
            switch(_loc5_.name)
            {
               case "min_price_input":
               case "max_price_input":
                  _loc8_ = 10;
                  break;
               case "search_input":
                  _loc8_ = 40;
                  break;
               default:
                  return;
            }
            if(_loc5_.text.length > _loc8_)
            {
               _loc5_.text = _loc5_.text.substr(0,_loc8_);
            }
            _loc5_.scrollH = 0;
         }
      }
      
      private function detailsEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "back_button":
                  hideDetails();
                  break;
               case "buy_button":
                  marketPlace.buyOffer(var_2092.offerId);
            }
            return;
         }
         if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "price_development":
               case "trade_volume":
                  updateStats();
            }
         }
      }
   }
}


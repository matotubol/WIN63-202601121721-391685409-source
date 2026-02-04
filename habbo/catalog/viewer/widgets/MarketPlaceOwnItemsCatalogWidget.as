package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MarketPlaceOwnItemsCatalogWidget extends CatalogWidget implements class_2612, class_1829, IMarketPlaceVisualization
   {
      
      private const STATUS_SEARCHING:int = 1;
      
      private const STATUS_LIST_AVAILABLE:int = 2;
      
      private var var_2306:class_55;
      
      private var _itemList:IItemListWindow;
      
      private var _offers:class_55;
      
      public function MarketPlaceOwnItemsCatalogWidget(param1:class_1812)
      {
         super(param1);
         var_2306 = new class_55();
      }
      
      override public function dispose() : void
      {
         super.dispose();
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
         var _loc2_:class_38 = marketPlace.windowManager;
         if(_loc2_ == null)
         {
            return false;
         }
         displayMainView();
         var _loc1_:IItemListWindow = _window.findChildByName("item_list") as IItemListWindow;
         var_2306.add(1,_loc1_.removeListItem(_loc1_.getListItemByName("ongoing_item")));
         var_2306.add(2,_loc1_.removeListItem(_loc1_.getListItemByName("sold_item")));
         var_2306.add(3,_loc1_.removeListItem(_loc1_.getListItemByName("expired_item")));
         marketPlace.registerVisualization(this);
         marketPlace.requestOwnItems();
         updateStatusDisplay(1);
         showRedeemInfo(false);
         return true;
      }
      
      private function showRedeemInfo(param1:Boolean) : void
      {
         if(!window)
         {
            return;
         }
         var _loc2_:class_1812 = window.findChildByName("redeem_border") as class_1812;
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function listUpdatedNotify() : void
      {
         if(marketPlace == null)
         {
            return;
         }
         updateList(marketPlace.latestOwnOffers());
      }
      
      private function updateStatusDisplay(param1:int, param2:int = -1) : void
      {
         var _loc5_:String = null;
         if(!marketPlace || !window)
         {
            return;
         }
         var _loc3_:class_27 = marketPlace.localization;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:class_1741 = window.findChildByName("status_text");
         if(_loc4_ == null)
         {
            return;
         }
         if(param1 == 1)
         {
            _loc5_ = _loc3_.getLocalization("catalog.marketplace.searching");
         }
         else if(param2 > 0)
         {
            _loc5_ = _loc3_.getLocalization("catalog.marketplace.items_found");
            _loc5_ = _loc5_.replace("%count%",param2);
         }
         else
         {
            _loc5_ = _loc3_.getLocalization("catalog.marketplace.no_items");
         }
         _loc4_.caption = _loc5_;
      }
      
      private function get marketPlace() : IMarketPlace
      {
         if(!page || !page.viewer || !page.viewer.catalog)
         {
            return null;
         }
         return page.viewer.catalog.getMarketPlace();
      }
      
      private function updateList(param1:class_55) : void
      {
         if(!param1 || !marketPlace || !window)
         {
            return;
         }
         _offers = param1;
         var _loc2_:class_27 = marketPlace.localization;
         if(!_loc2_)
         {
            return;
         }
         var _loc30_:IItemListWindow = window.findChildByName("item_list") as IItemListWindow;
         if(!_loc30_)
         {
            return;
         }
         _loc30_.destroyListItems();
         var _loc7_:int = 0;
         var _loc5_:Array = param1.getKeys();
         if(!_loc5_)
         {
            return;
         }
         updateStatusDisplay(2,_loc5_.length);
         var _loc21_:int = 0;
         while(0 < _loc5_.length)
         {
            var _loc14_:int = int(_loc5_[0]);
            var _loc17_:MarketPlaceOfferData = param1.getValue(0) as MarketPlaceOfferData;
            if(_loc17_.status == 2)
            {
               _loc7_++;
            }
            var _loc24_:class_1812 = var_2306.getValue(null.status);
            if(_loc24_)
            {
               var _loc4_:class_1812 = null.clone() as class_1812;
               if(!(!_loc4_ || Boolean(null.disposed)))
               {
                  var _loc8_:class_1741 = null.findChildByName("item_name");
                  if(_loc8_ != null)
                  {
                     null.caption = marketPlace != null ? "${" + marketPlace.getNameLocalizationKey(null) + "}" : "";
                  }
                  var _loc11_:class_1741 = null.findChildByName("item_desc");
                  if(_loc11_ != null)
                  {
                     null.caption = marketPlace != null ? "${" + marketPlace.getDescriptionLocalizationKey(null) + "}" : "";
                  }
                  var _loc31_:class_1741 = null.findChildByName("item_price");
                  if(_loc31_ != null)
                  {
                     var _loc12_:String = _loc2_.getLocalization("catalog.marketplace.offer.price_own_item");
                     _loc12_ = _loc12_.replace("%price%",null.price);
                     null.caption = null;
                  }
                  if(null.status == 1)
                  {
                     var _loc10_:class_1741 = null.findChildByName("item_time");
                     if(_loc10_ != null)
                     {
                        var _loc26_:int = Math.max(1,null.timeLeftMinutes);
                        var _loc18_:int = Math.floor(0 / 60);
                        var _loc20_:int = 0 - 0 * 60;
                        var _loc13_:String = _loc20_ + " " + _loc2_.getLocalization("catalog.marketplace.offer.minutes");
                        var _loc29_:String = _loc2_.getLocalization("catalog.marketplace.offer.time_left");
                        _loc29_ = _loc29_.replace("%time%",null);
                        null.caption = null;
                     }
                  }
                  if(null.status == 2)
                  {
                     var _loc22_:class_1741 = null.findChildByName("item_sold");
                     if(_loc22_ != null)
                     {
                        null.caption = _loc2_.getLocalization("catalog.marketplace.offer.sold");
                     }
                  }
                  if(null.status == 3)
                  {
                     var _loc16_:class_1741 = null.findChildByName("item_expired");
                     if(_loc16_ != null)
                     {
                        null.caption = _loc2_.getLocalization("catalog.marketplace.offer.expired");
                     }
                  }
                  if(null.image == null)
                  {
                     var _loc6_:class_2198 = getFurniImageResult(null.furniId,null.furniType,null.extraData);
                     if(_loc6_ != null && null.data != null)
                     {
                        null.image = null.data as BitmapData;
                        null.imageCallback = null.id;
                        null.id = null.id;
                     }
                  }
                  if(null.image != null)
                  {
                     var _loc23_:class_2251 = null.findChildByName("item_image") as class_2251;
                     if(_loc23_ != null)
                     {
                        var _loc9_:Point = new Point((null.width - null.image.width) / 2,(null.height - null.image.height) / 2);
                        if(null.bitmap == null)
                        {
                           null.bitmap = new BitmapData(null.width,null.height,true,0);
                        }
                        null.bitmap.copyPixels(null.image,null.image.rect,null);
                     }
                  }
                  if(null.isUniqueLimitedItem)
                  {
                     var _loc28_:class_1741 = null.findChildByName("unique_item_background_bitmap");
                     var _loc19_:class_2010 = class_2010(null.findChildByName("unique_item_overlay_widget"));
                     var _loc27_:ILimitedItemGridOverlayWidget = ILimitedItemGridOverlayWidget(null.widget);
                     _loc27_.serialNumber = null.stuffData.uniqueSerialNumber;
                     null.animated = true;
                     null.visible = true;
                     null.visible = true;
                  }
                  if(null.stuffData && null.stuffData.rarityLevel >= 0)
                  {
                     var _loc25_:class_2010 = class_2010(null.findChildByName("rarity_item_overlay_widget"));
                     var _loc3_:IRarityItemGridOverlayWidget = IRarityItemGridOverlayWidget(null.widget);
                     null.visible = true;
                     null.rarityLevel = null.stuffData.rarityLevel;
                  }
                  _loc30_.addListItem(null);
                  null.procedure = onGridEvent;
               }
            }
            _loc21_++;
         }
         showRedeemInfo(true);
         var _loc15_:class_1741 = window.findChildByName("redeem_info");
         if(_loc15_)
         {
            if(_loc7_ > 0)
            {
               _loc2_.registerParameter("catalog.marketplace.redeem.get_credits","count",_loc7_.toString());
               _loc2_.registerParameter("catalog.marketplace.redeem.get_credits","credits",marketPlace.creditsWaiting.toString());
               _loc15_.caption = "${catalog.marketplace.redeem.get_credits}";
            }
            else
            {
               _loc15_.caption = "${catalog.marketplace.redeem.no_sold_items}";
            }
         }
      }
      
      public function displayMainView() : void
      {
         attachWidgetView("marketPlaceOwnItemsWidget");
         window.procedure = onWidgetEvent;
         _itemList = window.findChildByName("item_list") as IItemListWindow;
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
      
      private function onGridEvent(param1:class_1758, param2:class_1741 = null) : void
      {
         var _loc5_:IItemListWindow = null;
         if(param1.type == "WME_CLICK")
         {
            if(!marketPlace || !param2 || !window)
            {
               return;
            }
            if(param2.name == "pick_button")
            {
               _loc5_ = window.findChildByName("item_list") as IItemListWindow;
               if(_loc5_ == null)
               {
                  return;
               }
               var _loc6_:int = _loc5_.getListItemIndex(param1.window.parent);
               var _loc3_:class_55 = marketPlace.latestOwnOffers();
               return;
            }
         }
      }
      
      private function onWidgetEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param2 == null)
         {
            param2 = param1.target as class_1741;
         }
         if(param1.type == "WME_CLICK")
         {
         }
      }
      
      public function updateStats() : void
      {
      }
   }
}


package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class MarketplaceConfirmationDialog implements class_1829
   {
      
      private var _marketplace:MarketPlaceLogic;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var _window:class_2250;
      
      private var _offer:MarketPlaceOfferData;
      
      public function MarketplaceConfirmationDialog(param1:MarketPlaceLogic, param2:IHabboCatalog, param3:IRoomEngine)
      {
         super();
         _marketplace = param1;
         _catalog = param2;
         _roomEngine = param3;
      }
      
      public function dispose() : void
      {
         _marketplace = null;
         _catalog = null;
         _roomEngine = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _offer = null;
      }
      
      public function showConfirmation(param1:int, param2:MarketPlaceOfferData) : void
      {
         if(!param2)
         {
            return;
         }
         _offer = param2;
         if(!_marketplace || !_catalog || !_catalog.localization)
         {
            return;
         }
         if(_window)
         {
            _window.dispose();
         }
         _window = createWindow("marketplace_purchase_confirmation") as class_2250;
         _window.procedure = eventHandler;
         _window.center();
         var _loc8_:ITextWindow = _window.findChildByName("header_text") as ITextWindow;
         if(_loc8_)
         {
            if(param1 == 1)
            {
               _loc8_.text = "${catalog.marketplace.confirm_header}";
            }
            if(param1 == 2)
            {
               _loc8_.text = "${catalog.marketplace.confirm_higher_header}";
            }
         }
         _loc8_ = _window.findChildByName("item_name") as ITextWindow;
         if(_loc8_)
         {
            _loc8_.text = "${" + _marketplace.getNameLocalizationKey(param2) + "}";
         }
         _loc8_ = _window.findChildByName("item_price") as ITextWindow;
         if(_loc8_)
         {
            var _loc9_:String = _catalog.localization.getLocalization("catalog.marketplace.confirm_price");
            _loc9_ = _loc9_.replace("%price%",_offer.price);
            _loc8_.text = null;
         }
         _loc8_ = _window.findChildByName("item_average_price") as ITextWindow;
         if(_loc8_)
         {
            var _loc3_:ILocalization = _catalog.localization.getLocalizationRaw("catalog.marketplace.offer_details.average_price");
            _loc8_.visible = false;
         }
         _loc8_ = _window.findChildByName("offer_count") as ITextWindow;
         if(_loc8_)
         {
            _loc3_ = _catalog.localization.getLocalizationRaw("catalog.marketplace.offer_details.offer_count");
            _loc8_.visible = false;
         }
         if(param2.isUniqueLimitedItem)
         {
            var _loc7_:class_1741 = _window.findChildByName("unique_item_background_bitmap");
            _loc7_.visible = true;
            var _loc10_:class_2010 = class_2010(_window.findChildByName("unique_item_overlay_widget"));
            var _loc6_:ILimitedItemGridOverlayWidget = ILimitedItemGridOverlayWidget(null.widget);
            null.visible = true;
            null.serialNumber = param2.stuffData.uniqueSerialNumber;
            null.animated = true;
         }
         if(param2.stuffData && param2.stuffData.rarityLevel >= 0)
         {
            var _loc12_:class_2010 = class_2010(_window.findChildByName("rarity_item_overlay_widget"));
            var _loc4_:IRarityItemGridOverlayWidget = IRarityItemGridOverlayWidget(null.widget);
            null.visible = true;
            null.rarityLevel = param2.stuffData.rarityLevel;
         }
         setImage();
         if((_catalog as HabboCatalog).getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            var _loc11_:class_1741 = _window.findChildByName("disclaimer");
            _window.height -= null.height;
            null.dispose();
            setDisclaimerAccepted(true);
         }
      }
      
      private function setImage() : void
      {
         var _loc1_:class_2198 = null;
         var _loc2_:class_2251 = null;
         if(!_offer || !_window || !_roomEngine)
         {
            return;
         }
         if(!_offer.image)
         {
            if(_offer.furniType == 1)
            {
               _loc1_ = _roomEngine.getFurnitureIcon(_offer.furniId,this);
            }
            else if(_offer.furniType == 2)
            {
               _loc1_ = _roomEngine.getWallItemIcon(_offer.furniId,this);
            }
            if(_loc1_ && _loc1_.data)
            {
               _offer.image = _loc1_.data as BitmapData;
               _offer.imageCallback = _loc1_.id;
            }
         }
         if(_offer.image != null)
         {
            _loc2_ = _window.findChildByName("item_image") as class_2251;
            if(_loc2_)
            {
               if(_loc2_.bitmap)
               {
                  _loc2_.bitmap.dispose();
                  _loc2_.bitmap = null;
               }
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc2_.bitmap.draw(_offer.image,new Matrix(1,0,0,1,(_loc2_.width - _offer.image.width) / 2,(_loc2_.height - _offer.image.height) / 2));
            }
         }
      }
      
      private function eventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOUBLE_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "spending_disclaimer":
               setDisclaimerAccepted(class_1885(param2).isSelected);
               break;
            case "buy_button":
               _catalog.buyMarketPlaceOffer(_offer.offerId);
               hide();
               break;
            case "header_button_close":
            case "cancel_button":
               hide();
         }
      }
      
      private function hide() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(_offer && _offer.imageCallback == param1)
         {
            _offer.image = param2;
            setImage();
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function createWindow(param1:String) : class_1741
      {
         if(!_catalog || !_catalog.assets || !_catalog.windowManager)
         {
            return null;
         }
         var _loc3_:XmlAsset = _catalog.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return _catalog.windowManager.buildFromXML(_loc2_);
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:class_1741 = _window.findChildByName("buy_button");
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
   }
}


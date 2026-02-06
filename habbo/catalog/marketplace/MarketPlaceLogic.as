package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.class_3020;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersEventParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersEventParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultEventParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultEventParser;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
   
   public class MarketPlaceLogic implements IMarketPlace
   {
      
      private static const TYPE_POSTER:String = "poster";
      
      public const PURCHASE_CONFIRM_TYPE_NORMAL:int = 1;
      
      public const PURCHASE_CONFIRM_TYPE_HIGHER:int = 2;
      
      public const const_844:int = 3;
      
      private var _catalog:HabboCatalog;
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _visualization:IMarketPlaceVisualization;
      
      private var var_69:MarketplaceConfirmationDialog;
      
      private var _latestOffers:class_55;
      
      private var _latestOwnOffers:class_55;
      
      private var var_4212:int;
      
      private var var_3883:int = -1;
      
      private var var_4076:class_2042;
      
      private var var_4150:int;
      
      private var var_4180:int;
      
      private var var_4423:int;
      
      private var _minPrice:int = 0;
      
      private var _maxPrice:int = 0;
      
      private var _searchString:String = "";
      
      private var var_4967:int = -1;
      
      private var _disposed:Boolean = false;
      
      public function MarketPlaceLogic(param1:HabboCatalog, param2:class_38, param3:IRoomEngine)
      {
         super();
         _catalog = param1;
         _windowManager = param2;
         _roomEngine = param3;
         getConfiguration();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _catalog = null;
         _windowManager = null;
         if(_latestOffers != null)
         {
            disposeOffers(_latestOffers);
            _latestOffers = null;
         }
         if(_latestOwnOffers != null)
         {
            disposeOffers(_latestOwnOffers);
            _latestOwnOffers = null;
         }
         _disposed = true;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localization() : class_27
      {
         return _catalog.localization;
      }
      
      public function registerVisualization(param1:IMarketPlaceVisualization = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         _visualization = param1;
      }
      
      private function getConfiguration() : void
      {
         if(!_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new GetMarketplaceConfigurationMessageComposer());
      }
      
      private function showConfirmation(param1:int, param2:MarketPlaceOfferData) : void
      {
         if(!var_69)
         {
            var_69 = new MarketplaceConfirmationDialog(this,_catalog,_roomEngine);
         }
         var_69.showConfirmation(param1,param2);
      }
      
      public function requestOffersByName(param1:String) : void
      {
         if(_catalog)
         {
            _catalog.getPublicMarketPlaceOffers(-1,-1,param1,-1);
         }
      }
      
      public function requestOffersByPrice(param1:int) : void
      {
         if(_catalog)
         {
            _catalog.getPublicMarketPlaceOffers(param1,-1,"",-1);
         }
      }
      
      public function requestOffers(param1:int, param2:int, param3:String, param4:int) : void
      {
         _minPrice = param1;
         _maxPrice = param2;
         _searchString = param3;
         var_4967 = param4;
         if(_catalog)
         {
            _catalog.getPublicMarketPlaceOffers(param1,param2,param3,param4);
         }
      }
      
      public function refreshOffers() : void
      {
         requestOffers(_minPrice,_maxPrice,_searchString,var_4967);
      }
      
      public function requestOwnItems() : void
      {
         if(_catalog)
         {
            _catalog.getOwnMarketPlaceOffers();
         }
      }
      
      public function requestItemStats(param1:int, param2:int) : void
      {
         if(_catalog)
         {
            var_4180 = param2;
            var_4150 = param1;
            _catalog.getMarketplaceItemStats(param1,param2);
         }
      }
      
      public function buyOffer(param1:int) : void
      {
         if(!_latestOffers || !_catalog || !_catalog.getPurse())
         {
            return;
         }
         var _loc2_:MarketPlaceOfferData = _latestOffers.getValue(param1) as MarketPlaceOfferData;
         if(!_loc2_)
         {
            return;
         }
         if(_catalog.getPurse().credits < _loc2_.price)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         showConfirmation(1,_loc2_);
      }
      
      public function redeemExpiredOffer(param1:int) : void
      {
         if(_catalog)
         {
            _catalog.redeemExpiredMarketPlaceOffer(param1);
         }
      }
      
      private function disposeOffers(param1:class_55) : void
      {
         if(param1 != null)
         {
            for each(var _loc2_ in param1)
            {
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            param1.dispose();
         }
      }
      
      public function onOffers(param1:IMessageEvent) : void
      {
         var _loc4_:MarketPlaceOffersEvent = param1 as MarketPlaceOffersEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:MarketPlaceOffersEventParser = _loc4_.getParser() as MarketPlaceOffersEventParser;
         if(_loc2_ == null)
         {
            return;
         }
         disposeOffers(_latestOffers);
         _latestOffers = new class_55();
         for each(var _loc5_ in _loc2_.offers)
         {
            var _loc3_:MarketPlaceOfferData = new MarketPlaceOfferData(_loc5_.offerId,_loc5_.furniId,_loc5_.furniType,_loc5_.extraData,_loc5_.stuffData,_loc5_.price,_loc5_.status,_loc5_.averagePrice,_loc5_.offerCount);
            null.timeLeftMinutes = _loc5_.timeLeftMinutes;
            _latestOffers.add(_loc5_.offerId,null);
         }
         var_4423 = _loc2_.totalItemsFound;
         if(_visualization != null)
         {
            _visualization.listUpdatedNotify();
         }
      }
      
      public function onOwnOffers(param1:IMessageEvent) : void
      {
         var _loc4_:MarketPlaceOwnOffersEvent = param1 as MarketPlaceOwnOffersEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:MarketPlaceOwnOffersEventParser = _loc4_.getParser() as MarketPlaceOwnOffersEventParser;
         if(_loc2_ == null)
         {
            return;
         }
         disposeOffers(_latestOwnOffers);
         _latestOwnOffers = new class_55();
         var_4212 = _loc2_.creditsWaiting;
         for each(var _loc5_ in _loc2_.offers)
         {
            var _loc3_:MarketPlaceOfferData = new MarketPlaceOfferData(_loc5_.offerId,_loc5_.furniId,_loc5_.furniType,_loc5_.extraData,_loc5_.stuffData,_loc5_.price,_loc5_.status,_loc5_.averagePrice);
            null.timeLeftMinutes = _loc5_.timeLeftMinutes;
            _latestOwnOffers.add(_loc5_.offerId,null);
         }
         if(_visualization != null)
         {
            _visualization.listUpdatedNotify();
         }
      }
      
      public function onBuyResult(param1:IMessageEvent) : void
      {
         var parser:MarketplaceBuyOfferResultEventParser;
         var item:MarketPlaceOfferData;
         var updateItem:MarketPlaceOfferData;
         var event:IMessageEvent = param1;
         var buyEvent:MarketplaceBuyOfferResultEvent = event as MarketplaceBuyOfferResultEvent;
         if(event == null)
         {
            return;
         }
         parser = buyEvent.getParser() as MarketplaceBuyOfferResultEventParser;
         if(parser == null)
         {
            return;
         }
         if(parser.result == 1)
         {
            refreshOffers();
         }
         else if(parser.result == 2)
         {
            item = _latestOffers.remove(parser.requestedOfferId);
            if(item != null)
            {
               item.dispose();
            }
            if(_visualization != null)
            {
               _visualization.listUpdatedNotify();
            }
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.marketplace.not_available_title}","${catalog.marketplace.not_available_header}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
            }
         }
         else if(parser.result == 3)
         {
            updateItem = _latestOffers.getValue(parser.requestedOfferId) as MarketPlaceOfferData;
            if(updateItem)
            {
               updateItem.offerId = parser.offerId;
               updateItem.price = parser.newPrice;
               updateItem.offerCount--;
               _latestOffers.add(parser.offerId,updateItem);
            }
            _latestOffers.remove(parser.requestedOfferId);
            showConfirmation(2,updateItem);
            if(_visualization != null)
            {
               _visualization.listUpdatedNotify();
            }
         }
         else if(parser.result == 4)
         {
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.alert.notenough.title}","${catalog.alert.notenough.credits.description}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
            }
         }
      }
      
      public function onCancelResult(param1:IMessageEvent) : void
      {
         var parser:MarketplaceCancelOfferResultEventParser;
         var item:MarketPlaceOfferData;
         var event:IMessageEvent = param1;
         var cancelEvent:MarketplaceCancelOfferResultEvent = event as MarketplaceCancelOfferResultEvent;
         if(event == null)
         {
            return;
         }
         parser = cancelEvent.getParser() as MarketplaceCancelOfferResultEventParser;
         if(parser == null)
         {
            return;
         }
         if(parser.success)
         {
            item = _latestOwnOffers.remove(parser.offerId);
            if(item != null)
            {
               item.dispose();
            }
            if(_visualization != null)
            {
               _visualization.listUpdatedNotify();
            }
         }
         else if(_windowManager != null)
         {
            _windowManager.alert("${catalog.marketplace.operation_failed.topic}","${catalog.marketplace.cancel_failed}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
         }
      }
      
      public function latestOffers() : class_55
      {
         return _latestOffers;
      }
      
      public function latestOwnOffers() : class_55
      {
         return _latestOwnOffers;
      }
      
      public function totalItemsFound() : int
      {
         return var_4423;
      }
      
      public function set itemStats(param1:class_2042) : void
      {
         if(param1.furniCategoryId != var_4150 || param1.furniTypeId != var_4180)
         {
            return;
         }
         var_4076 = param1;
         if(_visualization != null)
         {
            _visualization.updateStats();
         }
      }
      
      public function get itemStats() : class_2042
      {
         return var_4076;
      }
      
      public function get creditsWaiting() : int
      {
         return var_4212;
      }
      
      public function get averagePricePeriod() : int
      {
         return var_3883;
      }
      
      public function set averagePricePeriod(param1:int) : void
      {
         var_3883 = param1;
      }
      
      private function isPosterItem(param1:IMarketPlaceOfferData) : Boolean
      {
         var _loc2_:class_1800 = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         if(param1.furniType == 2 && param1.extraData != null)
         {
            _loc2_ = _catalog.getFurnitureData(param1.furniId,"i");
            if(_loc2_)
            {
               _loc3_ = _loc2_.className;
               if(_loc3_ != null && _loc3_ == "poster")
               {
                  _loc4_ = true;
               }
            }
         }
         return _loc4_;
      }
      
      public function getNameLocalizationKey(param1:IMarketPlaceOfferData) : String
      {
         if(param1 != null)
         {
            if(isPosterItem(param1))
            {
               var _loc2_:String = "poster_" + param1.extraData + "_name";
            }
            else if(param1.furniType == 1)
            {
               _loc2_ = "roomItem.name." + param1.furniId;
            }
            else if(param1.furniType == 2)
            {
               _loc2_ = "wallItem.name." + param1.furniId;
            }
         }
         return "";
      }
      
      public function getDescriptionLocalizationKey(param1:IMarketPlaceOfferData) : String
      {
         if(param1 != null)
         {
            if(isPosterItem(param1))
            {
               var _loc2_:String = "poster_" + param1.extraData + "_desc";
            }
            else if(param1.furniType == 1)
            {
               _loc2_ = "roomItem.desc." + param1.furniId;
            }
            else if(param1.furniType == 2)
            {
               _loc2_ = "wallItem.desc." + param1.furniId;
            }
         }
         return "";
      }
      
      public function isAccountSafetyLocked() : Boolean
      {
         if(_catalog)
         {
            return _catalog.sessionDataManager.isAccountSafetyLocked();
         }
         return false;
      }
   }
}


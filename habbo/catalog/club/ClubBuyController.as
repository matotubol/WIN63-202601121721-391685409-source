package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.catalog.viewer.widgets.IVipBuyCatalogWidget;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2374;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageEventParser;
   
   public class ClubBuyController
   {
      
      private var _visualization:IVipBuyCatalogWidget;
      
      private var _catalog:HabboCatalog;
      
      private var _offers:Array;
      
      private var var_69:ClubBuyConfirmationDialog;
      
      private var var_37:IConnection;
      
      private var _disposed:Boolean = false;
      
      public function ClubBuyController(param1:HabboCatalog, param2:IConnection)
      {
         super();
         _catalog = param1;
         var_37 = param2;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_visualization != null)
         {
            _visualization.dispose();
            _visualization = null;
         }
         reset();
         closeConfirmation();
         _catalog = null;
         _disposed = true;
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function reset() : void
      {
         for each(var _loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers = [];
      }
      
      public function onOffers(param1:HabboClubOffersMessageEventParser) : void
      {
         var _loc9_:ClubBuyOfferData = null;
         var _loc6_:ClubBuyOfferData = null;
         var _loc7_:Boolean = false;
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         if(_disposed)
         {
            return;
         }
         reset();
         var _loc5_:int = 0;
         for each(var _loc2_ in param1.offers)
         {
            _loc6_ = new ClubBuyOfferData(_loc2_.offerId,_loc2_.productCode,_loc2_.priceCredits,_loc2_.priceActivityPoints,_loc2_.priceActivityPointType,_loc2_.vip,_loc2_.months,_loc2_.extraDays,_loc2_.daysLeftAfterPurchase,_loc2_.year,_loc2_.month,_loc2_.day,_loc2_.isGiftable);
            _offers.push(_loc6_);
            if(_loc2_.vip)
            {
               _loc5_++;
               _loc9_ = _loc6_;
            }
         }
         if(_loc5_ == 1)
         {
            _loc9_.upgradeHcPeriodToVip = true;
         }
         _offers.sort(orderByPrecedence);
         if(_visualization != null)
         {
            _visualization.reset();
            _visualization.initClubType(getClubType());
            _loc7_ = _visualization.isGift;
            _loc3_ = getPromotedMonths(_loc7_);
            for each(var _loc4_ in _offers)
            {
               if(_loc4_.months > 0)
               {
                  if(_loc3_.length > 0)
                  {
                     _loc8_ = _loc4_.months;
                     if(_loc3_.indexOf(_loc8_) == -1)
                     {
                        continue;
                     }
                  }
                  _visualization.showOffer(_loc4_);
               }
            }
         }
      }
      
      private function getPromotedMonths(param1:Boolean) : Array
      {
         var _loc6_:Number = NaN;
         var _loc2_:Array = [];
         var _loc7_:String = param1 ? "catalog.vip.gift.promo" : "catalog.vip.buy.promo";
         if(_catalog.propertyExists(_loc7_))
         {
            var _loc4_:String = _catalog.getProperty(_loc7_,null);
            if(_loc4_ != null && null.length > 0)
            {
               var _loc3_:Array = null.split(",");
               if(null.length > 0)
               {
                  for each(var _loc5_ in null)
                  {
                     _loc6_ = parseInt(_loc5_);
                     if(!isNaN(_loc6_) && _loc6_ > 0)
                     {
                        _loc2_.push(_loc6_);
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function unRegisterVisualization(param1:IVipBuyCatalogWidget) : void
      {
         if(_visualization == param1)
         {
            _visualization = null;
         }
      }
      
      public function registerVisualization(param1:IVipBuyCatalogWidget) : void
      {
         _visualization = param1;
      }
      
      public function requestOffers(param1:int) : void
      {
         _catalog.getHabboClubOffers(param1);
      }
      
      public function showConfirmation(param1:ClubBuyOfferData, param2:int) : void
      {
         closeConfirmation();
         var_69 = new ClubBuyConfirmationDialog(this,param1,param2);
      }
      
      public function confirmSelection(param1:ClubBuyOfferData, param2:int) : void
      {
         if(!_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.purchaseProduct(param2,param1.offerId);
         closeConfirmation();
      }
      
      public function closeConfirmation() : void
      {
         if(var_69)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      public function getClubType() : int
      {
         var _loc1_:int = 0;
         if(_catalog.getPurse().hasClubLeft)
         {
            _loc1_ = _catalog.getPurse().isVIP ? 2 : 1;
         }
         return _loc1_;
      }
      
      public function get hasClub() : Boolean
      {
         if(!_catalog || !_catalog.getPurse())
         {
            return false;
         }
         return _catalog.getPurse().clubDays > 0;
      }
      
      public function get windowManager() : class_38
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.windowManager;
      }
      
      public function get localization() : class_27
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.localization;
      }
      
      public function get assets() : class_40
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.assets;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.roomEngine;
      }
      
      public function getProductData(param1:String) : class_1949
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getProductData(param1);
      }
      
      public function getPurse() : class_1831
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getPurse();
      }
      
      private function orderByPrecedence(param1:ClubBuyOfferData, param2:ClubBuyOfferData) : Number
      {
         var _loc3_:Number = param1.months;
         var _loc4_:Number = param2.months;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}


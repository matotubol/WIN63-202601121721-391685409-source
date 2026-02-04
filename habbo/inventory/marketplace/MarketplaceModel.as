package com.sulake.habbo.inventory.marketplace
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.class_38;
   import package_7.class_1922;
   import package_7.class_2462;
   import package_7.class_2496;
   import package_7.class_2844;
   import package_7.class_3406;
   
   public class MarketplaceModel implements IInventoryModel
   {
      
      private var var_55:HabboInventory;
      
      private var _assets:class_40;
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:class_57;
      
      private var _disposed:Boolean = false;
      
      private var var_452:FurnitureItem;
      
      private var var_3091:Boolean;
      
      private var var_4999:int;
      
      private var var_3452:int;
      
      private var var_3440:int;
      
      private var _offerMinPrice:int;
      
      private var _offerMaxPrice:int;
      
      private var _expirationHours:int;
      
      private var var_3883:int;
      
      private var var_3976:int;
      
      private var var_4026:int;
      
      private var var_3991:int;
      
      private var var_4150:int;
      
      private var var_4180:int;
      
      private var var_18:MarketplaceView;
      
      private var var_2116:Boolean = false;
      
      public function MarketplaceModel(param1:HabboInventory, param2:class_38, param3:class_57, param4:class_40, param5:IRoomEngine, param6:class_27)
      {
         super();
         var_55 = param1;
         _communication = param3;
         _windowManager = param2;
         _assets = param4;
         _roomEngine = param5;
         var_18 = new MarketplaceView(this,_windowManager,_assets,param5,param6,param1);
      }
      
      public function get id() : String
      {
         return "marketplace";
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         var_3091 = param1;
      }
      
      public function set commission(param1:int) : void
      {
         var_4999 = param1;
      }
      
      public function set tokenBatchPrice(param1:int) : void
      {
         var_3452 = param1;
      }
      
      public function set tokenBatchSize(param1:int) : void
      {
         var_3440 = param1;
      }
      
      public function set offerMinPrice(param1:int) : void
      {
         _offerMinPrice = param1;
      }
      
      public function set offerMaxPrice(param1:int) : void
      {
         _offerMaxPrice = param1;
      }
      
      public function set expirationHours(param1:int) : void
      {
         _expirationHours = param1;
      }
      
      public function set averagePricePeriod(param1:int) : void
      {
         var_3883 = param1;
      }
      
      public function set sellingFeePercentage(param1:int) : void
      {
         var_3976 = param1;
      }
      
      public function set revenueLimit(param1:int) : void
      {
         var_4026 = param1;
      }
      
      public function set halfTaxLimit(param1:int) : void
      {
         var_3991 = param1;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_3091;
      }
      
      public function get commission() : int
      {
         return var_4999;
      }
      
      public function get tokenBatchPrice() : int
      {
         return var_3452;
      }
      
      public function get tokenBatchSize() : int
      {
         return var_3440;
      }
      
      public function get offerMinPrice() : int
      {
         return _offerMinPrice;
      }
      
      public function get offerMaxPrice() : int
      {
         return _offerMaxPrice;
      }
      
      public function get expirationHours() : int
      {
         return _expirationHours;
      }
      
      public function get sellingFeePercentage() : int
      {
         return var_3976;
      }
      
      public function get revenueLimit() : int
      {
         return var_4026;
      }
      
      public function get halfTaxLimit() : int
      {
         return var_3991;
      }
      
      public function get controller() : HabboInventory
      {
         return var_55;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var_55 = null;
         _communication = null;
         _windowManager = null;
         _assets = null;
         _roomEngine = null;
      }
      
      public function releaseItem() : void
      {
         if(var_55 != null && var_55.furniModel != null && var_452 != null)
         {
            var_55.furniModel.removeLockFrom(var_452.id);
            var_452 = null;
         }
      }
      
      public function startOfferMaking(param1:FurnitureItem) : void
      {
         if(var_452 != null || param1 == null)
         {
            return;
         }
         if(var_55 == null)
         {
            return;
         }
         var _loc2_:FurniModel = var_55.furniModel;
         if(_loc2_ == null)
         {
            return;
         }
         var_452 = param1;
         _loc2_.addLockTo(param1.id);
         send(new class_2844());
      }
      
      public function buyMarketplaceTokens() : void
      {
         send(new class_2496());
         var_2116 = true;
      }
      
      public function makeOffer(param1:int) : void
      {
         if(var_452 == null)
         {
            return;
         }
         var _loc2_:int = var_452.isWallItem ? 2 : 1;
         send(new class_3406(param1,_loc2_,var_452.ref));
         releaseItem();
      }
      
      public function getItemStats() : void
      {
         if(var_452 == null)
         {
            return;
         }
         var _loc1_:int = var_452.isWallItem ? 2 : 1;
         var_4150 = _loc1_;
         var_4180 = var_452.type;
         send(new class_1922(_loc1_,var_452.type));
      }
      
      public function proceedOfferMaking(param1:int, param2:int) : void
      {
         var_2116 = false;
         switch(param1 - 1)
         {
            case 0:
               var_18.showMakeOffer(var_452);
               break;
            case 1:
               var_18.showAlert("${inventory.marketplace.no_trading_privilege.title}","${inventory.marketplace.no_trading_privilege.info}");
               break;
            case 2:
               var_18.showAlert("${inventory.marketplace.no_trading_pass.title}","${inventory.marketplace.no_trading_pass.info}");
               break;
            case 3:
               var_18.showBuyTokens(var_3452,var_3440);
               break;
            case 5:
               var_18.showAlert("${inventory.marketplace.trading_lock.title}","${inventory.marketplace.trading_lock.info}");
         }
      }
      
      public function endOfferMaking(param1:int) : void
      {
         if(!var_18)
         {
            return;
         }
         var_18.showResult(param1);
      }
      
      public function setAveragePrice(param1:int, param2:int, param3:int) : void
      {
         if(param1 != var_4150 || param2 != var_4180)
         {
            return;
         }
         if(!var_18)
         {
            return;
         }
         var_18.updateAveragePrice(param3,var_3883);
      }
      
      public function onNotEnoughCredits() : void
      {
         if(var_2116)
         {
            var_2116 = false;
            releaseItem();
         }
      }
      
      public function requestInitialization() : void
      {
         send(new class_2462());
      }
      
      public function getOfferItem() : class_1875
      {
         return var_452;
      }
      
      public function getWindowContainer() : class_1812
      {
         return null;
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function updateView() : void
      {
      }
      
      private function send(param1:IMessageComposer) : void
      {
         if(_communication != null && _communication.connection != null)
         {
            _communication.connection.send(param1);
         }
      }
      
      public function selectItemById(param1:String) : void
      {
         class_21.log("NOT SUPPORTED: MARKETPLACE SELECT BY ID");
      }
   }
}


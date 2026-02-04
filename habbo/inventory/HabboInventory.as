package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.inventory.badges.Badge;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.bots.BotsModel;
   import com.sulake.habbo.inventory.collectibles.CollectiblesModel;
   import com.sulake.habbo.inventory.effects.EffectsModel;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.pets.PetsModel;
   import com.sulake.habbo.inventory.purse.Purse;
   import com.sulake.habbo.inventory.recycler.RecyclerModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.*;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_43.class_1907;
   import package_45.GetNftCreditsMessageComposer;
   import package_45.GetSilverMessageComposer;
   import package_77.class_2233;
   import package_9.class_2081;
   
   public class HabboInventory extends class_17 implements class_61, ILinkEventTracker
   {
      
      private var _communication:class_57;
      
      private var var_1692:class_1762;
      
      private var _windowManager:class_38;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _localization:class_27;
      
      private var _soundManager:class_544;
      
      private var var_18:InventoryMainView;
      
      private var var_107:class_55;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_977:IRoomSession;
      
      private var var_1933:Array;
      
      private var var_139:Purse;
      
      private var _avatarRenderer:class_48;
      
      private var _catalog:IHabboCatalog;
      
      private var var_265:Boolean;
      
      private var var_827:UnseenItemTracker;
      
      private var var_3958:Boolean = false;
      
      private var _notifications:class_536;
      
      private var var_145:String;
      
      private var var_3127:Vector.<int>;
      
      private var var_3628:Vector.<String>;
      
      private var var_429:Timer;
      
      public function HabboInventory(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_139 = new Purse();
         var_1933 = [];
         var_3127 = new Vector.<int>(0);
      }
      
      public function get isVisible() : Boolean
      {
         return var_18.isVisible;
      }
      
      public function get isMainViewActive() : Boolean
      {
         return var_18.isActive;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_265;
      }
      
      public function get unseenItemTracker() : class_1954
      {
         return var_827;
      }
      
      public function get view() : InventoryMainView
      {
         return var_18;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderer = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDUE_ALLOW_PETS",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDHabboToolbar(),null,false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":habboToolbarEventHandler
         }]),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         })]);
      }
      
      private function habboToolbarEventHandler(param1:HabboToolbarEvent) : void
      {
         if(var_18 != null)
         {
            var_18.onHabboToolbarEvent(param1);
         }
      }
      
      override protected function initComponent() : void
      {
         if(HabboComponentFlags.isRoomViewerMode(flags))
         {
            return;
         }
         var_1692 = new class_1762(this);
         context.addLinkEventTracker(this);
         var_827 = new UnseenItemTracker(_communication,events,this);
         var_18 = new InventoryMainView(this,_windowManager,assets);
         _communication.connection.send(new class_2233());
         _communication.connection.send(new GetNftCreditsMessageComposer());
         _communication.connection.send(new GetSilverMessageComposer());
         _communication.connection.send(new class_2081("habbo_club"));
         _communication.connection.send(new class_1907());
      }
      
      override public function dispose() : void
      {
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc2_:IInventoryModel = null;
         if(disposed)
         {
            return;
         }
         if(var_429 != null)
         {
            var_429.stop();
            var_429.removeEventListener("timer",onPurseTimer);
            var_429 = null;
         }
         if(var_107)
         {
            _loc4_ = var_107.getKeys();
            _loc1_ = 0;
            while(_loc1_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc1_];
               _loc2_ = var_107.getValue(_loc3_) as IInventoryModel;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_107.dispose();
            var_107 = null;
         }
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
         var_977 = null;
         if(var_827 != null)
         {
            var_827.dispose();
            var_827 = null;
         }
         if(var_1692 != null)
         {
            var_1692.dispose();
            var_1692 = null;
         }
         super.dispose();
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function getModel(param1:String) : IInventoryModel
      {
         if(!var_265)
         {
            init();
         }
         return var_107.getValue(param1);
      }
      
      public function get furniModel() : FurniModel
      {
         return disposed ? null : FurniModel(getModel("furni"));
      }
      
      public function get tradingModel() : TradingModel
      {
         return disposed ? null : TradingModel(getModel("trading"));
      }
      
      public function get effectsModel() : EffectsModel
      {
         return disposed ? null : EffectsModel(getModel("effects"));
      }
      
      public function get badgesModel() : BadgesModel
      {
         return disposed ? null : BadgesModel(getModel("badges"));
      }
      
      public function get recyclerModel() : RecyclerModel
      {
         return disposed ? null : RecyclerModel(getModel("recycler"));
      }
      
      public function get petsModel() : PetsModel
      {
         return disposed ? null : PetsModel(getModel("pets"));
      }
      
      public function get botsModel() : BotsModel
      {
         return disposed ? null : BotsModel(getModel("bots"));
      }
      
      public function get collectiblesModel() : CollectiblesModel
      {
         return disposed ? null : CollectiblesModel(getModel("collectibles"));
      }
      
      public function get marketplaceModel() : MarketplaceModel
      {
         return disposed ? null : MarketplaceModel(getModel("marketplace"));
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_977;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get clubDays() : int
      {
         return var_139.clubDays;
      }
      
      public function get clubPeriods() : int
      {
         return var_139.clubPeriods;
      }
      
      public function get clubPastPeriods() : int
      {
         return var_139.clubPastPeriods;
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return var_139.clubHasEverBeenMember;
      }
      
      public function get clubIsExpiring() : Boolean
      {
         return var_139.clubIsExpiring;
      }
      
      public function get citizenshipVipIsExpiring() : Boolean
      {
         return var_139.citizenshipVipIsExpiring;
      }
      
      public function get clubMinutesUntilExpiration() : int
      {
         return var_139.minutesUntilExpiration;
      }
      
      public function get clubLevel() : int
      {
         if(clubDays == 0 && clubPeriods == 0)
         {
            return 0;
         }
         if(var_139.isVIP)
         {
            return 2;
         }
         return 1;
      }
      
      public function get hasRoomSession() : Boolean
      {
         return var_977 != null;
      }
      
      public function getSubCategoryViewId() : String
      {
         return var_18.getSubCategoryViewId();
      }
      
      public function setClubStatus(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:int, param8:int) : void
      {
         var_139.clubPeriods = param1;
         var_139.clubDays = param2;
         var_139.clubHasEverBeenMember = param3;
         var_139.isVIP = param4;
         var_139.clubIsExpiring = param5;
         var_139.citizenshipVipIsExpiring = param6;
         var_139.minutesUntilExpiration = param7;
         var_139.minutesSinceLastModified = param8;
         if(param7 > 0 && param7 < 86400000)
         {
            if(var_429 == null)
            {
               var_429 = new Timer(60000,0);
               var_429.addEventListener("timer",onPurseTimer);
            }
            if(!var_429.running)
            {
               var_429.start();
            }
         }
         else if(var_429 != null)
         {
            var_429.stop();
            var_429.removeEventListener("timer",onPurseTimer);
            var_429 = null;
         }
      }
      
      private function onPurseTimer(param1:TimerEvent) : void
      {
         _communication.connection.send(new class_2081("habbo_club"));
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               var_977 = param1.session;
               if(var_265)
               {
                  if(petsModel != null)
                  {
                     petsModel.updatePetsAllowed();
                  }
                  if(furniModel != null)
                  {
                     furniModel.updateView();
                  }
               }
               break;
            case "RSE_ENDED":
               var_977 = null;
               if(var_265)
               {
                  deselectAllEffects();
               }
               break;
            case "RSDUE_ALLOW_PETS":
               if(var_265)
               {
                  if(petsModel != null)
                  {
                     petsModel.updatePetsAllowed();
                  }
               }
         }
      }
      
      private function init() : void
      {
         if(!allRequiredDependenciesInjected)
         {
            return;
         }
         var_107 = new class_55();
         var _loc7_:MarketplaceModel = new MarketplaceModel(this,_windowManager,_communication,assets,_roomEngine,_localization);
         var_107.add("marketplace",_loc7_);
         var _loc1_:FurniModel = new FurniModel(this,_loc7_,_windowManager,_communication,assets,_roomEngine,_catalog,_soundManager,_localization);
         var_107.add("furni",_loc1_);
         if(!mergeRentFurni)
         {
            var_107.add("rentables",_loc1_);
         }
         var _loc9_:CollectiblesModel = new CollectiblesModel(this,_windowManager,_communication,assets,_roomEngine,_catalog,_avatarRenderer);
         var_107.add("collectibles",_loc9_);
         var _loc2_:BadgesModel = new BadgesModel(this,_windowManager,_communication,assets);
         var_107.add("badges",_loc2_);
         var _loc4_:EffectsModel = new EffectsModel(this,_windowManager,_communication,assets,_localization);
         var_107.add("effects",_loc4_);
         var _loc5_:TradingModel = new TradingModel(this,_windowManager,_communication,assets,_roomEngine,_localization,_soundManager,_notifications);
         var_107.add("trading",_loc5_);
         var _loc3_:RecyclerModel = new RecyclerModel(this,_windowManager,_communication,assets,_roomEngine,_localization);
         var_107.add("recycler",_loc3_);
         var _loc8_:PetsModel = new PetsModel(this,_windowManager,_communication,assets,_roomEngine,_catalog);
         var_107.add("pets",_loc8_);
         var _loc6_:BotsModel = new BotsModel(this,_windowManager,_communication,assets,_roomEngine,_catalog,_avatarRenderer);
         var_107.add("bots",_loc6_);
         var_265 = true;
      }
      
      public function getCategoryWindowContainer(param1:String) : class_1812
      {
         var _loc2_:IInventoryModel = IInventoryModel(var_107.getValue(param1));
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.getWindowContainer();
      }
      
      public function updateView(param1:String) : void
      {
         var _loc2_:IInventoryModel = IInventoryModel(var_107.getValue(param1));
         if(_loc2_ == null)
         {
            return;
         }
         return _loc2_.updateView();
      }
      
      public function getCategorySubWindowContainer(param1:String) : class_1812
      {
         var _loc2_:IInventoryModel = IInventoryModel(var_107.getValue(param1));
         return _loc2_ == null ? null : _loc2_.getWindowContainer();
      }
      
      public function getActivatedAvatarEffects() : Array
      {
         return effectsModel == null ? [] : effectsModel.getEffects(1);
      }
      
      public function getAvatarEffects() : Array
      {
         return effectsModel == null ? [] : effectsModel.getEffects();
      }
      
      public function setEffectSelected(param1:int) : void
      {
         var _loc2_:EffectsModel = effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.useEffect(param1);
         notifyChangedEffects();
      }
      
      public function setEffectDeselected(param1:int) : void
      {
         var _loc2_:EffectsModel = effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.stopUsingEffect(param1,true);
         notifyChangedEffects();
      }
      
      public function deselectAllEffects(param1:Boolean = false) : void
      {
         var _loc2_:EffectsModel = effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.stopUsingAllEffects(true,true,param1);
         notifyChangedEffects();
      }
      
      public function getAvatarEffect(param1:int) : class_1777
      {
         return effectsModel == null ? null : effectsModel.getEffectInterface(param1);
      }
      
      public function closeView() : void
      {
         if(var_18 && var_18.isVisible)
         {
            var_18.hideInventory();
         }
      }
      
      public function showView() : void
      {
         if(var_18)
         {
            var_18.showInventory();
         }
      }
      
      public function get isMainViewInitialized() : Boolean
      {
         return var_18.mainContainer != null;
      }
      
      public function initializeFurniturePage() : void
      {
         if(var_18)
         {
            toggleInventoryPage("furni");
            var_18.hideInventory();
         }
      }
      
      public function toggleInventoryPage(param1:String, param2:String = null, param3:Boolean = false) : void
      {
         var_145 = param1;
         var _loc4_:Boolean = var_18.toggleCategoryView(param1,false,param3);
         if(_loc4_)
         {
            inventoryViewOpened(param1);
            if(param2 != null)
            {
               IInventoryModel(var_107.getValue(var_145)).selectItemById(param2);
            }
         }
         if(!_loc4_)
         {
            events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_CLOSED"));
         }
      }
      
      public function toggleInventorySubPage(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IInventoryModel = null;
         var_18.toggleSubCategoryView(param1,false);
         _loc2_ = 0;
         while(_loc2_ < var_107.length)
         {
            _loc3_ = var_107.getWithIndex(_loc2_) as IInventoryModel;
            _loc3_.subCategorySwitch(param1);
            _loc2_++;
         }
         var _loc4_:String = param1;
         if("trading" === _loc4_)
         {
            var_18.toggleCategoryView("furni",false);
         }
      }
      
      public function updateSubView() : void
      {
         var_18.updateSubCategoryView();
      }
      
      public function closingInventoryView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IInventoryModel = null;
         if(var_107)
         {
            _loc1_ = 0;
            while(_loc1_ < var_107.length)
            {
               _loc2_ = var_107.getWithIndex(_loc1_) as IInventoryModel;
               _loc2_.closingInventoryView();
               _loc1_++;
            }
         }
         events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_CLOSED"));
      }
      
      public function preparingInventoryView() : void
      {
         if(!var_265)
         {
            init();
         }
      }
      
      public function inventoryViewOpened(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IInventoryModel = null;
         _loc2_ = 0;
         while(_loc2_ < var_107.length)
         {
            _loc3_ = var_107.getWithIndex(_loc2_) as IInventoryModel;
            _loc3_.categorySwitch(param1);
            _loc2_++;
         }
      }
      
      public function setupTrading(param1:int, param2:String) : void
      {
         if(!var_265)
         {
            init();
         }
         var _loc3_:TradingModel = tradingModel;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.requestOpenTrading(param1);
      }
      
      public function get tradingActive() : Boolean
      {
         return tradingModel?.running;
      }
      
      public function onTradeActiveChanged(param1:Boolean = false) : void
      {
         if(web3tradeEnabled)
         {
            view.disableNonTradingTabs(tradingActive);
            view.showCollectiblesTab(tradingActive);
            if(param1)
            {
               collectiblesModel.onTradeComplete();
            }
         }
      }
      
      public function get web3tradeEnabled() : Boolean
      {
         return getBoolean("web3trade.enabled");
      }
      
      public function setupRecycler(param1:Boolean) : void
      {
         if(recyclerModel != null)
         {
            if(param1)
            {
               recyclerModel.startRecycler();
            }
            else
            {
               recyclerModel.stopRecycler();
            }
         }
      }
      
      public function requestSelectedFurniToRecycler() : int
      {
         return recyclerModel != null ? recyclerModel.lockSelectedFurni() : 0;
      }
      
      public function returnInventoryFurniFromRecycler(param1:int) : Boolean
      {
         return recyclerModel != null ? recyclerModel.releaseFurni(param1) : false;
      }
      
      public function canUserOfferToTrade() : Boolean
      {
         var _loc1_:TradingModel = tradingModel;
         return _loc1_ != null ? _loc1_.ownUserCanTrade : false;
      }
      
      public function setInventoryCategoryInit(param1:String, param2:Boolean = true) : Boolean
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(var_1933.indexOf(param1) == -1)
            {
               var_1933.push(param1);
               return true;
            }
         }
         else
         {
            _loc3_ = int(var_1933.indexOf(param1));
            if(_loc3_ >= 0)
            {
               var_1933.splice(_loc3_,1);
            }
            if(var_18 != null && var_18.isVisible)
            {
               if(param1 != "rentables")
               {
                  requestInventoryCategoryInit(param1);
               }
            }
         }
         return false;
      }
      
      public function isInventoryCategoryInit(param1:String) : Boolean
      {
         return var_1933.indexOf(param1) >= 0;
      }
      
      public function checkCategoryInitilization(param1:String) : Boolean
      {
         if(isInventoryCategoryInit(param1))
         {
            return true;
         }
         requestInventoryCategoryInit(param1);
         return false;
      }
      
      public function requestInventoryCategoryInit(param1:String) : void
      {
         var _loc2_:IInventoryModel = var_107.getValue(param1) as IInventoryModel;
         if(_loc2_ != null)
         {
            _loc2_.requestInitialization();
         }
      }
      
      public function notifyChangedEffects() : void
      {
         events.dispatchEvent(new HabboInventoryEffectsEvent("HIEE_EFFECTS_CHANGED"));
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function requestSelectedFurniToMover(param1:class_1875) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(param1.isWallItem)
         {
            _loc3_ = 20;
         }
         else
         {
            _loc3_ = 10;
         }
         if(param1.category == 6)
         {
            _loc2_ = _roomEngine.initializeRoomObjectInsert("inventory",param1.id,_loc3_,param1.type,param1.stuffData.getLegacyString());
         }
         else
         {
            _loc2_ = _roomEngine.initializeRoomObjectInsert("inventory",param1.id,_loc3_,param1.type,param1.extra.toString(),param1.stuffData);
         }
         return _loc2_;
      }
      
      public function getFloorItemById(param1:int) : class_1875
      {
         var _loc2_:class_1875 = null;
         for each(var _loc3_ in furniModel.furniData)
         {
            _loc2_ = _loc3_.getItem(param1);
            if(_loc2_ != null && !_loc2_.isWallItem)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getWallItemById(param1:int) : class_1875
      {
         var _loc2_:class_1875 = null;
         for each(var _loc3_ in furniModel.furniData)
         {
            _loc2_ = _loc3_.getItem(param1);
            if(_loc2_ != null && _loc2_.isWallItem)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getNonRentedInventoryIds(param1:String, param2:int, param3:Boolean) : Array
      {
         var _loc5_:FurniModel = var_107.getValue(param1);
         if(!_loc5_)
         {
            return null;
         }
         var _loc4_:GroupItem = furniModel.getGroupItemByItemTypeId(param2,param3);
         if(!_loc4_)
         {
            return null;
         }
         return _loc4_.getNonRentedFurnitureIds();
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         return petsModel.placePetToRoom(param1,param2);
      }
      
      public function get mergeRentFurni() : Boolean
      {
         return true;
      }
      
      public function updateUnseenItemCounts() : void
      {
         var _loc4_:int = 0;
         _loc4_ = var_827.getCount(1);
         var_18.updateUnseenFurniCount(_loc4_);
         _loc4_ = var_827.getCount(2);
         var_18.updateUnseenRentedFurniCount(_loc4_);
         var _loc1_:int = var_827.getCount(3);
         var_18.updateUnseenPetsCount(_loc1_);
         var _loc3_:int = var_827.getCount(4);
         var_18.updateUnseenBadgeCount(_loc3_);
         var _loc2_:int = var_827.getCount(5);
         var_18.updateUnseenBotCount(_loc2_);
      }
      
      public function removeUnseenFurniCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = furniModel.removeUnseenFurniCounter(param1);
         if(_loc2_)
         {
            updateUnseenItemCounts();
         }
         return _loc2_;
      }
      
      public function removeUnseenPetCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = petsModel.removeUnseenFurniCounter(param1);
         if(_loc2_)
         {
            updateUnseenItemCounts();
         }
         return _loc2_;
      }
      
      public function get botsMax() : int
      {
         return getInteger("inventory.bots.max",150);
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get currentCategoryId() : String
      {
         return var_145;
      }
      
      public function getFurnitureData(param1:int, param2:String) : class_1800
      {
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            var _loc3_:class_1800 = _sessionDataManager.getFloorItemData(param1);
         }
         if(param2 == "i")
         {
            _loc3_ = _sessionDataManager.getWallItemData(param1);
         }
         return null;
      }
      
      public function getFurnitureDataByName(param1:String, param2:String, param3:int = 0) : class_1800
      {
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            var _loc4_:class_1800 = _sessionDataManager.getFloorItemDataByName(param1);
         }
         if(param2 == "i")
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param1);
         }
         return null;
      }
      
      public function get linkPattern() : String
      {
         return "inventory/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("open" !== _loc3_)
         {
            class_21.log("Inventory unknown link-type received: " + _loc2_[1]);
         }
         else if(_loc2_.length == 2)
         {
            toggleInventoryPage("furni");
         }
         else if(_loc2_.length == 3)
         {
            toggleInventoryPage(_loc2_[2]);
         }
         else if(_loc2_.length == 4)
         {
            toggleInventoryPage(_loc2_[2],_loc2_[3]);
         }
      }
      
      public function getAllMyBadgeIds(param1:Array) : Array
      {
         var _loc2_:BadgesModel = var_107.getValue("badges");
         var _loc4_:Array = [];
         if(_loc2_.getBadges().length == 0 && !var_3958)
         {
            badgesModel.requestInitialization();
            var_3958 = true;
         }
         for each(var _loc3_ in _loc2_.getBadges())
         {
            if(param1 == null || param1.indexOf(_loc3_.badgeId) == -1)
            {
               _loc4_.push(_loc3_.badgeId);
            }
         }
         return _loc4_;
      }
      
      public function hasFigureSetIdInInventory(param1:int) : Boolean
      {
         return var_3127.indexOf(param1) > -1;
      }
      
      public function hasBoundFigureSetFurniture(param1:String) : Boolean
      {
         return var_3628.indexOf(param1) > -1;
      }
      
      public function updatePurchasedFigureSetIds(param1:Vector.<int>, param2:Vector.<String>) : void
      {
         var_3127 = param1;
         var_3628 = param2;
      }
      
      public function getLastActivatedEffect() : int
      {
         return effectsModel.lastActivatedEffect;
      }
      
      public function get avatarRenderer() : class_48
      {
         return _avatarRenderer;
      }
      
      public function recycleSelectedFurni() : void
      {
         var _loc2_:GroupItem = null;
         var _loc1_:FurnitureItem = null;
         var _loc3_:int = 0;
         var _loc4_:IRecycler = catalog.getRecycler();
         if(_loc4_ != null)
         {
            _loc2_ = furniModel.getSelectedItem();
            if(_loc2_ == null)
            {
               return;
            }
            _loc1_ = _loc2_.peek();
            if(_loc1_ == null)
            {
               return;
            }
            _loc3_ = _loc1_.isWallItem ? 20 : 10;
            _loc4_.placeObjectAtSlot(-1,_loc1_.id,_loc3_,_loc1_.type,String(_loc1_.extra),true);
         }
      }
   }
}


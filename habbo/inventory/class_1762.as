package com.sulake.habbo.inventory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.bots.BotsModel;
   import com.sulake.habbo.inventory.collectibles.CollectibleGroupedItem;
   import com.sulake.habbo.inventory.collectibles.CollectiblesModel;
   import com.sulake.habbo.inventory.effects.Effect;
   import com.sulake.habbo.inventory.effects.EffectsModel;
   import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.pets.PetsModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.furniture.class_1800;
   import flash.utils.getTimer;
   import package_10.class_2053;
   import package_105.class_2485;
   import package_105.class_2545;
   import package_105.class_3367;
   import package_109.class_2384;
   import package_109.class_2433;
   import package_109.class_2445;
   import package_109.class_2566;
   import package_111.class_2392;
   import package_111.class_3106;
   import package_111.class_3185;
   import package_119.class_2432;
   import package_119.class_2511;
   import package_119.class_2606;
   import package_119.class_2662;
   import package_119.class_2760;
   import package_119.class_2853;
   import package_119.class_3149;
   import package_124.class_2467;
   import package_124.class_2592;
   import package_124.class_2943;
   import package_124.class_3589;
   import package_124.class_3660;
   import package_131.class_2471;
   import package_131.class_2942;
   import package_131.class_2947;
   import package_145.class_2577;
   import package_145.class_2970;
   import package_145.class_3308;
   import package_145.class_3460;
   import package_145.class_3608;
   import package_159.class_3593;
   import package_163.class_3661;
   import package_168.class_2864;
   import package_168.class_2997;
   import package_168.class_3521;
   import package_17.class_3447;
   import package_179.class_3090;
   import package_179.class_3241;
   import package_182.class_3126;
   import package_182.class_3211;
   import package_182.class_3263;
   import package_183.class_3147;
   import package_26.class_1799;
   import package_29.class_1832;
   import package_29.class_1943;
   import package_29.class_2170;
   import package_29.class_3422;
   import package_3.class_2125;
   import package_3.class_2238;
   import package_39.class_1980;
   import package_4.class_1757;
   import package_42.class_3544;
   import package_46.class_1918;
   import package_5.class_1746;
   import package_5.class_2097;
   import package_5.class_2172;
   import package_5.class_3584;
   import package_54.class_2039;
   import package_54.class_3653;
   import package_8.class_2014;
   import package_82.class_2302;
   import package_82.class_2317;
   import package_82.class_2487;
   import package_82.class_2878;
   import package_82.class_2899;
   import package_82.class_3088;
   import package_82.class_3099;
   import package_82.class_3335;
   import package_82.class_3471;
   import package_82.class_3477;
   import package_86.class_2327;
   import package_86.class_2362;
   import package_86.class_2646;
   import package_86.class_3075;
   import package_87.class_2493;
   import package_87.class_2518;
   import package_87.class_2966;
   import package_87.class_3116;
   import package_88.class_2393;
   import package_88.class_2491;
   import package_88.class_2568;
   import package_88.class_2622;
   import package_88.class_2668;
   import package_88.class_2706;
   import package_88.class_2871;
   import package_88.class_2882;
   import package_88.class_2941;
   import package_88.class_3066;
   import package_88.class_3098;
   import package_88.class_3329;
   import package_88.class_3503;
   
   [SecureSWF(rename="true")]
   public class class_1762
   {
      
      private static const GROUPED_FURNI_TYPE:String = "credit_groupitem_type_id";
      
      private var _inventory:HabboInventory;
      
      private var _com:class_57;
      
      private var var_2341:Vector.<class_55>;
      
      private var var_2523:Vector.<class_55>;
      
      private var var_5408:Vector.<class_55>;
      
      private var var_2561:Vector.<class_55>;
      
      private var var_278:int;
      
      public function class_1762(param1:HabboInventory)
      {
         super();
         _inventory = param1;
         _com = _inventory.communication;
         _com.addHabboConnectionMessageEvent(new class_3593(onFigureSetIds));
         _com.addHabboConnectionMessageEvent(new class_1943(onMarketplaceItemStats));
         _com.addHabboConnectionMessageEvent(new class_2871(onTradingClose,class_2302));
         _com.addHabboConnectionMessageEvent(new class_1980(onRoomEnter));
         _com.addHabboConnectionMessageEvent(new class_3329(onTradingItemList,class_2899));
         _com.addHabboConnectionMessageEvent(new class_2864(onBadges));
         _com.addHabboConnectionMessageEvent(new class_2493(onGoToBreedingNestFailure));
         _com.addHabboConnectionMessageEvent(new class_2706(onTradingNotOpen,class_2487));
         _com.addHabboConnectionMessageEvent(new class_2039(onRoomLeft));
         _com.addHabboConnectionMessageEvent(new class_2606(onFurniListInvalidate));
         _com.addHabboConnectionMessageEvent(new class_2966(onPets));
         _com.addHabboConnectionMessageEvent(new class_3503(onTradingOpen,class_3099));
         _com.addHabboConnectionMessageEvent(new class_2662(onFurnitureAddOrUpdate));
         _com.addHabboConnectionMessageEvent(new class_2125(onUserBadges));
         _com.addHabboConnectionMessageEvent(new class_1799(onAchievementReceived));
         _com.addHabboConnectionMessageEvent(new class_3422(onMarketplaceCanMakeOfferResult));
         _com.addHabboConnectionMessageEvent(new class_1757(onUserRights));
         _com.addHabboConnectionMessageEvent(new class_2170(onMarketplaceMakeOfferResult));
         _com.addHabboConnectionMessageEvent(new class_3098(onTradingOpenFailed,class_3088));
         _com.addHabboConnectionMessageEvent(new class_3521(onBadgeReceived));
         _com.addHabboConnectionMessageEvent(new class_2668(onTradeSilverFee));
         _com.addHabboConnectionMessageEvent(new class_2941(onTradeSilverSet));
         _com.addHabboConnectionMessageEvent(new class_2882(onTradingCompleted,class_2317));
         _com.addHabboConnectionMessageEvent(new class_2622(onTradingYouAreNotAllowed,class_3477));
         _com.addHabboConnectionMessageEvent(new class_2393(onTradingConfirmation,class_2878));
         _com.addHabboConnectionMessageEvent(new class_2511(onPostItPlaced));
         _com.addHabboConnectionMessageEvent(new class_2853(onFurniListRemoveMultiple));
         _com.addHabboConnectionMessageEvent(new class_2760(onFurniListRemove));
         _com.addHabboConnectionMessageEvent(new class_2997(onBadgePointLimits));
         _com.addHabboConnectionMessageEvent(new class_2467(onAvatarEffectAdded));
         _com.addHabboConnectionMessageEvent(new class_2471(onBotRemoved));
         _com.addHabboConnectionMessageEvent(new class_2592(onAvatarEffectExpired));
         _com.addHabboConnectionMessageEvent(new class_2053(onNotEnoughCredits));
         _com.addHabboConnectionMessageEvent(new class_2238(onClubStatus));
         _com.addHabboConnectionMessageEvent(new class_3589(onAvatarEffects));
         _com.addHabboConnectionMessageEvent(new class_3653(onRoomLeft));
         _com.addHabboConnectionMessageEvent(new class_2942(onBots));
         _com.addHabboConnectionMessageEvent(new class_3116(onPetRemoved));
         _com.addHabboConnectionMessageEvent(new class_3241(onTradeNfts));
         _com.addHabboConnectionMessageEvent(new class_2568(onTradingAccepted,class_3335));
         _com.addHabboConnectionMessageEvent(new class_2432(onFurniList));
         _com.addHabboConnectionMessageEvent(new class_3660(onAvatarEffectActivated));
         _com.addHabboConnectionMessageEvent(new class_2491(onTradingOtherNotAllowed,class_3471));
         _com.addHabboConnectionMessageEvent(new class_3661(onAchievementsScore));
         _com.addHabboConnectionMessageEvent(new class_2518(onPetAdded));
         _com.addHabboConnectionMessageEvent(new class_2947(onBotAdded));
         _com.addHabboConnectionMessageEvent(new class_1832(onMarketplaceConfiguration));
         _com.addHabboConnectionMessageEvent(new class_3544(onFlatAccessDenied));
         _com.addHabboConnectionMessageEvent(new class_3090(onCollectibles));
      }
      
      public function dispose() : void
      {
         _inventory = null;
         _com = null;
      }
      
      public function onFurniList(param1:class_2432) : void
      {
         var _loc4_:class_3460 = param1.getParser();
         if(_loc4_ == null)
         {
            return;
         }
         if(!_inventory.isMainViewInitialized)
         {
            _inventory.initializeFurniturePage();
         }
         var _loc2_:FurniModel = _inventory.furniModel;
         if(_loc2_ == null)
         {
            return;
         }
         if(var_2523 == null)
         {
            var_2523 = new Vector.<class_55>(_loc4_.totalFragments,true);
         }
         var _loc5_:class_55 = new class_55();
         _loc5_.concatenate(_loc4_.furniFragment);
         var _loc3_:class_55 = addMessageFragment(_loc5_,_loc4_.totalFragments,_loc4_.fragmentNo,var_2523);
         if(!_loc3_)
         {
            return;
         }
         _loc2_.insertFurniture(_loc3_);
         var_2523 = null;
         _inventory.events.dispatchEvent(new HabboInventoryFurniListParsedEvent("furni"));
      }
      
      public function onFurnitureAddOrUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FurnitureItem = null;
         var _loc5_:GroupItem = null;
         var _loc3_:class_3308 = (param1 as class_2662).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc7_:FurniModel = _inventory.furniModel;
         if(_loc7_ == null || !_loc7_.isListInited())
         {
            return;
         }
         var _loc6_:Vector.<class_3149> = _loc3_.getFurni();
         for each(var _loc4_ in _loc6_)
         {
            _loc5_ = _loc7_.getItemWithStripId(_loc4_.itemId);
            if(_loc5_)
            {
               _loc2_ = _loc5_.getItem(_loc4_.itemId);
               if(_loc2_)
               {
                  _loc2_.update(_loc4_);
                  _loc5_.hasUnseenItems = true;
               }
            }
            else
            {
               _loc2_ = new FurnitureItem(_loc4_);
               _loc7_.addOrUpdateItem(_loc2_,false);
            }
         }
         _loc7_.setViewToState();
         _loc7_.updateView();
      }
      
      public function onFurniListRemove(param1:IMessageEvent) : void
      {
         var _loc2_:class_3608 = (param1 as class_2760).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc5_:FurniModel = _inventory.furniModel;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.stripId;
         var _loc3_:GroupItem = _loc5_.removeFurni(_loc4_);
         if(_loc3_)
         {
            _loc5_.resetUnseenItems();
         }
      }
      
      public function onFurniListRemoveMultiple(param1:IMessageEvent) : void
      {
         var _loc2_:class_2970 = (param1 as class_2853).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:FurniModel = _inventory.furniModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:Boolean = _loc4_.removeFurnis(_loc2_.stripIds);
         if(_loc3_)
         {
            _loc4_.resetUnseenItems();
         }
      }
      
      public function onFurniListInvalidate(param1:IMessageEvent) : void
      {
         _inventory.setInventoryCategoryInit("furni",false);
         _inventory.setInventoryCategoryInit("rentables",false);
      }
      
      public function onPostItPlaced(param1:IMessageEvent) : void
      {
         var _loc2_:class_2577 = (param1 as class_2511).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:FurniModel = _inventory.furniModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.id;
         var _loc5_:int = _loc2_.itemsLeft;
         _loc3_.updatePostItCount(_loc4_,_loc5_);
      }
      
      public function onAvatarEffects(param1:IMessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:class_2943 = null;
         var _loc7_:Effect = null;
         if(_inventory == null)
         {
            return;
         }
         var _loc6_:EffectsModel = _inventory.effectsModel;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:class_3075 = (param1 as class_3589).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Array = _loc3_.effects;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_] as class_2943;
            _loc7_ = new Effect();
            _loc7_.type = _loc4_.type;
            _loc7_.subType = _loc4_.subType;
            _loc7_.duration = _loc4_.duration;
            _loc7_.isPermanent = _loc4_.isPermanent;
            _loc7_.amountInInventory = _loc4_.inactiveEffectsInInventory;
            if(_loc4_.secondsLeftIfActive >= 0)
            {
               _loc7_.isActive = true;
               _loc7_.secondsLeft = _loc4_.secondsLeftIfActive;
               _loc7_.amountInInventory++;
            }
            else if(_loc4_.secondsLeftIfActive == -1)
            {
               _loc7_.isActive = false;
               _loc7_.secondsLeft = _loc4_.duration;
            }
            _loc6_.addEffect(_loc7_,false);
            _loc5_++;
         }
         _inventory.setInventoryCategoryInit("effects");
         _loc6_.refreshViews();
         _inventory.notifyChangedEffects();
      }
      
      public function onAvatarEffectAdded(param1:IMessageEvent) : void
      {
         var _loc5_:EffectsModel = _inventory.effectsModel;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc2_:class_2646 = (param1 as class_2467).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc7_:int = _loc2_.type;
         var _loc6_:int = _loc2_.subType;
         var _loc8_:int = _loc2_.duration;
         var _loc3_:Boolean = _loc2_.isPermanent;
         var _loc4_:Effect = new Effect();
         _loc4_.type = _loc7_;
         _loc4_.subType = _loc6_;
         _loc4_.duration = _loc8_;
         _loc4_.isPermanent = _loc3_;
         _loc4_.secondsLeft = _loc8_;
         _loc5_.addEffect(_loc4_);
         _inventory.notifyChangedEffects();
      }
      
      public function onAvatarEffectActivated(param1:IMessageEvent) : void
      {
         var _loc3_:EffectsModel = _inventory.effectsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_2327 = (param1 as class_3660).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.type;
         _loc3_.setEffectActivated(_loc4_);
         _inventory.notifyChangedEffects();
      }
      
      public function onAvatarEffectExpired(param1:IMessageEvent) : void
      {
         var _loc3_:EffectsModel = _inventory.effectsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_2362 = (param1 as class_2592).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.type;
         _loc3_.setEffectExpired(_loc4_);
         _inventory.notifyChangedEffects();
      }
      
      public function onClubStatus(param1:IMessageEvent) : void
      {
         var _loc2_:class_2014 = (param1 as class_2238).getParser();
         if(_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
         {
            _inventory.setClubStatus(_loc2_.periodsSubscribedAhead,_loc2_.daysToPeriodEnd,_loc2_.hasEverBeenMember,_loc2_.isVIP,_loc2_.responseType == 3,_loc2_.responseType == 4,_loc2_.minutesUntilExpiration,_loc2_.minutesSinceLastModified);
            _inventory.events.dispatchEvent(new HabboInventoryHabboClubEvent());
         }
      }
      
      public function onBadges(param1:IMessageEvent) : void
      {
         var _loc3_:class_2445 = (param1 as class_2864).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:BadgesModel = _inventory.badgesModel;
         if(_loc4_ == null)
         {
            return;
         }
         if(var_2561 == null)
         {
            var_278 = getTimer();
            var_2561 = new Vector.<class_55>(_loc3_.totalFragments,true);
         }
         var _loc5_:class_55 = new class_55();
         _loc5_.concatenate(_loc3_.currentFragment);
         var _loc2_:class_55 = addMessageFragment(_loc5_,_loc3_.totalFragments,_loc3_.fragmentNo,var_2561);
         if(!_loc2_)
         {
            return;
         }
         var_2561 = null;
         var _loc6_:int = getTimer() - var_278;
         var_278 = 0;
         class_21.log("Parsing badges took: " + _loc6_ + "ms");
         var_278 = getTimer();
         _loc4_.initBadges(_loc2_);
         _loc6_ = getTimer() - var_278;
         var_278 = 0;
         class_21.log("Initializing badges took: " + _loc6_ + "ms");
         _loc4_.updateView();
         _inventory.setInventoryCategoryInit("badges");
      }
      
      public function onCollectibles(param1:IMessageEvent) : void
      {
         var _loc3_:class_2392 = (param1 as class_3090).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:CollectiblesModel = _inventory.collectiblesModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:class_55 = new class_55();
         for each(var _loc2_ in _loc3_.items)
         {
            _loc5_.add(_loc2_.assetId,_loc2_);
         }
         _loc4_.initCollectibles(_loc5_);
      }
      
      public function onTradeNfts(param1:IMessageEvent) : void
      {
         var _loc2_:class_3185 = (param1 as class_3241).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:CollectiblesModel = _inventory.collectiblesModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:class_55 = parseNftTradeMap(_loc2_.myItems,_loc4_);
         var _loc5_:class_55 = parseNftTradeMap(_loc2_.theirItems,_loc4_);
         var _loc6_:TradingModel = _inventory.tradingModel;
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.updateNftItems(_loc3_,_loc5_,_loc2_.myItems.length,_loc2_.theirItems.length);
      }
      
      public function parseNftTradeMap(param1:Vector.<class_3106>, param2:CollectiblesModel) : class_55
      {
         var _loc6_:String = null;
         var _loc7_:CollectibleGroupedItem = null;
         var _loc4_:* = undefined;
         var _loc5_:class_55 = new class_55();
         for each(var _loc3_ in param1)
         {
            _loc6_ = _loc3_.productCode;
            _loc7_ = _loc5_.getValue(_loc6_);
            if(_loc7_ == null)
            {
               _loc4_ = new Vector.<Number>();
               _loc4_.push(_loc3_.assetId);
               _loc7_ = new CollectibleGroupedItem(_loc3_,_loc4_,param2);
               _loc5_.add(_loc6_,_loc7_);
               _loc7_.initializeImage();
            }
            else
            {
               _loc7_.addAssetId(_loc3_.assetId);
            }
         }
         return _loc5_;
      }
      
      public function onBadgePointLimits(param1:IMessageEvent) : void
      {
         var _loc2_:class_2566 = (param1 as class_2997).getParser();
         for each(var _loc3_ in _loc2_.data)
         {
            _inventory.localization.setBadgePointLimit(_loc3_.badgeId,_loc3_.limit);
         }
      }
      
      public function onUserBadges(param1:IMessageEvent) : void
      {
         var _loc3_:class_2125 = param1 as class_2125;
         if(_loc3_.userId != _inventory.sessionData.userId)
         {
            return;
         }
         var _loc4_:BadgesModel = _inventory.badgesModel;
         if(_loc4_ == null)
         {
            return;
         }
         var_278 = getTimer();
         for each(var _loc2_ in _loc3_.badges)
         {
            _loc4_.updateBadge(_loc2_,true);
         }
         var _loc5_:int = getTimer() - var_278;
         var_278 = 0;
         class_21.log("Updating badges " + _loc3_.badges.length + "took: " + _loc5_ + "ms");
         var_278 = getTimer();
         _loc4_.updateView();
         _loc5_ = getTimer() - var_278;
         var_278 = 0;
         class_21.log("Updating badge view took: " + _loc5_ + "ms");
      }
      
      public function onAchievementReceived(param1:IMessageEvent) : void
      {
         var _loc4_:class_1799 = param1 as class_1799;
         var _loc3_:class_1918 = _loc4_.getParser();
         var _loc2_:BadgesModel = _inventory.badgesModel;
         if(_loc2_ != null)
         {
            _loc2_.updateBadge(_loc3_.data.badgeCode,false,_loc3_.data.badgeId);
            _loc2_.removeBadge(_loc3_.data.removedBadgeCode);
            _loc2_.updateView();
         }
      }
      
      public function onBadgeReceived(param1:IMessageEvent) : void
      {
         var _loc3_:class_2433 = class_3521(param1).getParser();
         var _loc2_:BadgesModel = _inventory.badgesModel;
         if(_loc2_ != null)
         {
            _loc2_.updateBadge(_loc3_.badgeCode,false,_loc3_.badgeId);
            _loc2_.updateView();
         }
      }
      
      public function onAchievementsScore(param1:IMessageEvent) : void
      {
         var _loc2_:class_3661 = param1 as class_3661;
         var _loc3_:class_3147 = _loc2_.getParser() as class_3147;
         if(_loc3_ == null)
         {
            return;
         }
         _inventory.localization.registerParameter("achievements_score_description","score",_loc3_.score.toString());
      }
      
      private function onTradingOpen(param1:IMessageEvent) : void
      {
         var _loc13_:int = 0;
         if(!_inventory)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - inventory is null!");
            return;
         }
         var _loc2_:ISessionDataManager = _inventory.sessionData;
         var _loc16_:IRoomSession = _inventory.roomSession;
         if(!_loc2_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - sessionData not available!");
            return;
         }
         if(!_loc16_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - roomSession not available!");
            return;
         }
         _inventory.toggleInventorySubPage("trading");
         var _loc5_:class_3503 = param1 as class_3503;
         if(!_loc5_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","event is of unknown type:" + param1 + "!");
            return;
         }
         var _loc8_:int = _loc5_.userID;
         var _loc3_:class_2146 = _loc16_.userDataManager.getUserData(_loc8_);
         if(!_loc3_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - failed to retrieve own user data!");
            return;
         }
         var _loc6_:String = _loc3_.name;
         var _loc4_:* = _loc5_.userCanTrade > 0;
         var _loc14_:int = _loc5_.otherUserID;
         var _loc15_:class_2146 = _loc16_.userDataManager.getUserData(_loc14_);
         if(!_loc15_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent","Trading open - failed to retrieve other user data!");
            return;
         }
         var _loc11_:String = _loc15_.name;
         var _loc10_:* = _loc5_.otherUserCanTrade > 0;
         if(_loc14_ == _loc2_.userId)
         {
            _loc13_ = _loc8_;
            var _loc9_:String = _loc6_;
            var _loc7_:Boolean = _loc4_;
            _loc8_ = _loc14_;
            _loc6_ = _loc11_;
            _loc4_ = _loc10_;
            _loc14_ = _loc13_;
            _loc11_ = _loc9_;
            _loc10_ = _loc7_;
         }
         var _loc12_:TradingModel = _inventory.tradingModel;
         if(_loc12_ != null)
         {
            _loc12_.startTrading(_loc8_,_loc6_,_loc4_,_loc14_,_loc11_,_loc10_);
         }
      }
      
      private function onTradingOpenFailed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingClose(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingCompleted(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingAccepted(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradeSilverFee(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradeSilverSet(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingConfirmation(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingItemList(param1:IMessageEvent) : void
      {
         var _loc8_:GroupItem = null;
         var _loc2_:class_3329 = param1 as class_3329;
         var _loc4_:class_55 = new class_55();
         var _loc5_:class_55 = new class_55();
         var _loc6_:int = _inventory.sessionData.userId;
         var _loc3_:FurniModel = _inventory.furniModel;
         if(_loc3_ == null)
         {
            return;
         }
         if(_inventory.getBoolean("trading.warning.enabled") && _loc2_.secondUserNumCredits > 0)
         {
            _loc8_ = _inventory.furniModel.createCreditGroupItem(_loc2_.secondUserNumCredits);
            _loc5_.add("credit_groupitem_type_id",_loc8_);
         }
         populateItemGroups(_loc2_.firstUserItemArray,_loc4_,_loc2_.firstUserID == _loc6_);
         populateItemGroups(_loc2_.secondUserItemArray,_loc5_,_loc2_.secondUserID == _loc6_);
         var _loc7_:TradingModel = _inventory.tradingModel;
         if(_loc7_ != null)
         {
            _loc7_.updateItemGroupMaps(_loc2_,_loc4_,_loc5_);
         }
      }
      
      private function populateItemGroups(param1:Array, param2:class_55, param3:Boolean) : void
      {
         var _loc9_:GroupItem = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:String = null;
         var _loc4_:class_3066 = null;
         var _loc6_:int = 0;
         var _loc10_:uint = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc10_)
         {
            _loc4_ = param1[_loc6_] as class_3066;
            _loc7_ = _loc4_.itemTypeId;
            _loc8_ = _loc4_.category;
            _loc5_ = _loc4_.itemType + String(_loc7_);
            if(!_loc4_.isGroupable || isFurniExternalImage(_loc4_.itemTypeId))
            {
               _loc5_ = "itemid" + _loc4_.itemId;
            }
            if(_loc4_.category == 6)
            {
               _loc5_ = String(_loc7_) + "poster" + _loc4_.stuffData.getLegacyString();
            }
            else if(_loc4_.category == 17)
            {
               _loc5_ = TradingModel.getGuildFurniType(_loc7_,_loc4_.stuffData);
            }
            _loc9_ = _loc4_.isGroupable && !isFurniExternalImage(_loc4_.itemTypeId) ? param2.getValue(_loc5_) as GroupItem : null;
            if(_loc9_ == null)
            {
               _loc9_ = _inventory.furniModel.createGroupItem(_loc7_,_loc8_,_loc4_.stuffData);
               param2.add(_loc5_,_loc9_);
            }
            _loc9_.push(new FurnitureItem(_loc4_));
            _loc6_++;
         }
      }
      
      private function isFurniExternalImage(param1:int) : Boolean
      {
         var _loc2_:class_1800 = _inventory.getFurnitureData(param1,"i");
         return _loc2_ && _loc2_.isExternalImageType;
      }
      
      private function onTradingNotOpen(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingOtherNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingYouAreNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onRoomLeft(param1:IMessageEvent) : void
      {
         _inventory.closeView();
         _inventory.furniModel.roomLeft();
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         var _loc2_:class_3447 = (param1 as class_3544).getParser();
         if(_inventory.sessionData == null || _loc2_.userName != _inventory.sessionData.userName)
         {
            return;
         }
         _inventory.closeView();
         _inventory.furniModel.roomLeft();
      }
      
      private function onPets(param1:class_2966) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:PetsModel = _inventory.petsModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:class_2545 = param1.getParser();
         if(var_2341 == null)
         {
            var_2341 = new Vector.<class_55>(_loc3_.totalFragments,true);
         }
         var _loc5_:class_55 = new class_55();
         _loc5_.concatenate(_loc3_.petListFragment);
         var _loc2_:class_55 = addMessageFragment(_loc5_,_loc3_.totalFragments,_loc3_.fragmentNo,var_2341);
         if(!_loc2_)
         {
            return;
         }
         _inventory.petsModel.updatePets(_loc2_);
         var_2341 = null;
      }
      
      private function onPetAdded(param1:class_2518) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:PetsModel = _inventory.petsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_2485 = param1.getParser();
         _loc3_.addPet(_loc2_.pet);
         if(_loc2_.openInventory())
         {
         }
      }
      
      private function onGoToBreedingNestFailure(param1:class_2493) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc2_:String = "${gotobreedingnestfailure.getnest}";
         var _loc3_:Function = getNest;
         if(param1.getParser().reason == 6)
         {
            _loc2_ = "${gotobreedingnestfailure.getfood}";
            _loc3_ = getFood;
         }
         _inventory.windowManager.simpleAlert("${gotobreedingnestfailure.caption}","${gotobreedingnestfailure.subtitle}","${gotobreedingnestfailure.message." + param1.getParser().reason + "}",_loc2_,"",null,null,_loc3_);
      }
      
      private function getNest() : void
      {
         var _loc1_:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.nests");
         _inventory.catalog.openCatalogPage(_loc1_);
      }
      
      private function getFood() : void
      {
         var _loc1_:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.food");
         _inventory.catalog.openCatalogPage(_loc1_);
      }
      
      private function onPetRemoved(param1:class_3116) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:PetsModel = _inventory.petsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_3367 = param1.getParser();
         _loc3_.removePet(_loc2_.petId);
      }
      
      private function onBots(param1:class_2942) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_3263 = param1.getParser();
         _loc3_.updateItems(_loc2_.items);
         _inventory.setInventoryCategoryInit("bots");
         _loc3_.setListInitialized();
      }
      
      private function onBotRemoved(param1:class_2471) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_3126 = param1.getParser();
         _loc3_.removeItem(_loc2_.itemId);
      }
      
      private function onBotAdded(param1:class_2947) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.items.length >= _inventory.botsMax)
         {
            return;
         }
         var _loc2_:class_3211 = param1.getParser();
         _loc3_.addItem(_loc2_.item);
      }
      
      private function onMarketplaceConfiguration(param1:class_1832) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:class_2097 = param1.getParser();
         _loc4_.isEnabled = _loc3_.isEnabled;
         _loc4_.commission = _loc3_.commission;
         _loc4_.tokenBatchPrice = _loc3_.tokenBatchPrice;
         _loc4_.tokenBatchSize = _loc3_.tokenBatchSize;
         _loc4_.offerMinPrice = _loc3_.offerMinPrice;
         _loc4_.offerMaxPrice = _loc3_.offerMaxPrice;
         _loc4_.expirationHours = _loc3_.expirationHours;
         _loc4_.averagePricePeriod = _loc3_.averagePricePeriod;
         _loc4_.sellingFeePercentage = _loc3_.sellingFeePercentage;
         _loc4_.revenueLimit = _loc3_.revenueLimit;
         _loc4_.halfTaxLimit = _loc3_.halfTaxLimit;
         _inventory.setInventoryCategoryInit("marketplace");
         var _loc2_:FurniModel = _inventory.furniModel;
         if(_loc2_ != null)
         {
            _loc2_.updateView();
         }
      }
      
      private function onMarketplaceCanMakeOfferResult(param1:class_3422) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_3584 = param1.getParser();
         _loc3_.proceedOfferMaking(_loc2_.resultCode,_loc2_.tokenCount);
      }
      
      private function onMarketplaceMakeOfferResult(param1:class_2170) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_2172 = param1.getParser();
         _loc3_.endOfferMaking(_loc2_.result);
      }
      
      private function onMarketplaceItemStats(param1:class_1943) : void
      {
         if(param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1746 = param1.getParser();
         _loc3_.setAveragePrice(_loc2_.furniCategoryId,_loc2_.furniTypeId,_loc2_.averagePrice);
      }
      
      private function onNotEnoughCredits(param1:class_2053) : void
      {
         if(!param1 || !_inventory)
         {
            return;
         }
         var _loc2_:MarketplaceModel = _inventory.marketplaceModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.onNotEnoughCredits();
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:MarketplaceModel = null;
         if(_inventory.isInventoryCategoryInit("marketplace"))
         {
            _loc2_ = _inventory.marketplaceModel;
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.requestInitialization();
         }
      }
      
      private function onFigureSetIds(param1:class_3593) : void
      {
         _inventory.updatePurchasedFigureSetIds(param1.getParser().figureSetIds,param1.getParser().boundFurnitureNames);
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(_inventory.getBoolean("effects.reactivate.on.room.entry"))
         {
            _inventory.effectsModel.reactivateLastEffect();
         }
         _inventory.furniModel.roomEntered();
      }
      
      private function addMessageFragment(param1:class_55, param2:int, param3:int, param4:Vector.<class_55>) : class_55
      {
         if(param2 == 1)
         {
            return param1;
         }
         param4[param3] = param1;
         for each(var _loc5_ in param4)
         {
            if(_loc5_ == null)
            {
               return null;
            }
         }
         var _loc6_:class_55 = new class_55();
         for each(var _loc7_ in param4)
         {
            _loc6_.concatenate(_loc7_);
            _loc7_.dispose();
         }
         param4 = null;
         return _loc6_;
      }
   }
}


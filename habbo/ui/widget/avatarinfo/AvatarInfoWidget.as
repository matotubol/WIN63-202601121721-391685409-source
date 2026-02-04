package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.events.WiredUserClickHandledEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChangeNameConfiguration;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChatterMarkovConfiguration;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotSkillConfigurationViewBase;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.class_2534;
   import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetLevelUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetStatusUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   import com.sulake.habbo.ui.widget.memenu.class_2303;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import package_161.class_2759;
   import package_161.class_3483;
   import package_66.class_3119;
   
   public class AvatarInfoWidget extends RoomWidgetBase implements class_31, class_1853
   {
      
      private static const EFFECT_TYPE_RIDE:int = 77;
      
      private static const EFFECT_TYPE_DEEP_WATER:int = 29;
      
      private static const EFFECT_TYPE_SHALLOW_WATER:int = 30;
      
      private static const const_514:int = 185;
      
      private static const AVATAR_HIGHLIGHT_DURATION_MSEC:int = 5000;
      
      private static const const_922:String = "avatar";
      
      private static const const_283:String = "use_minimized_own_avatar_menu";
      
      private var var_59:class_17;
      
      private var var_637:class_16;
      
      private var var_18:AvatarContextInfoButtonView;
      
      private var var_351:DecorateModeView;
      
      private var var_265:Boolean = false;
      
      private var var_1798:Boolean = false;
      
      private var var_1382:Boolean = false;
      
      private var var_1682:Timer;
      
      private var var_3025:class_3270;
      
      private var var_272:class_3025;
      
      private var var_583:PetInfoData;
      
      private var var_2909:int = -1;
      
      private var var_5321:Boolean = true;
      
      private var var_1062:AvatarContextInfoButtonView;
      
      private var _cachedOwnAvatarMenu:OwnAvatarMenuView;
      
      private var var_901:AvatarMenuView;
      
      private var var_1002:RentableBotMenuView;
      
      private var var_2086:OwnPetMenuView;
      
      private var var_903:PetMenuView;
      
      private var var_2004:NewUserHelpView;
      
      private var var_469:class_55;
      
      private var var_675:class_55;
      
      private var var_573:class_55;
      
      private var var_414:UseProductConfirmationView;
      
      private var var_404:BreedMonsterPlantsConfirmationView;
      
      private var var_655:ConfirmPetBreedingView;
      
      private var var_335:BreedPetsResultView;
      
      private var _breedingConfirmationAlert:class_1750;
      
      private var var_2801:int = -1;
      
      private var var_2098:int = -1;
      
      private var var_4634:Boolean = false;
      
      private var _handlePetInfo:Boolean = true;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEvents:IHabboUserDefinedRoomEvents;
      
      private var var_866:class_55 = new class_55();
      
      private var var_1458:class_55 = new class_55();
      
      private var var_3435:NestBreedingSuccessView;
      
      private var var_1296:int;
      
      private var _buttonsSetup:Function;
      
      public function AvatarInfoWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_16, param5:class_27, param6:class_17, param7:IHabboCatalog, param8:IHabboUserDefinedRoomEvents)
      {
         super(param1,param2,param3,param5);
         var_59 = param6;
         _catalog = param7;
         _roomEvents = param8;
         var_637 = param4;
         var_3025 = new class_3270();
         var_583 = new PetInfoData();
         var_272 = null;
         var_469 = new class_55();
         var_675 = new class_55();
         var_573 = new class_55();
         this.handler.roomEngine.events.addEventListener("REOE_ADDED",onRoomObjectAdded);
         this.handler.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
         this.handler.container.inventory.events.addEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         this.handler.container.userDefinedRoomEvents.events.addEventListener("WIRED_USER_CLICK_HANDLED",onUserClickHandledEvent);
         this.handler.widget = this;
      }
      
      public function get component() : class_17
      {
         return var_59;
      }
      
      public function get handler() : AvatarInfoWidgetHandler
      {
         return var_41 as AvatarInfoWidgetHandler;
      }
      
      public function get configuration() : class_16
      {
         return var_637;
      }
      
      public function get localization() : class_27
      {
         return var_167;
      }
      
      public function set handlePetInfo(param1:Boolean) : void
      {
         _handlePetInfo = param1;
      }
      
      private function onRoomObjectAdded(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:class_2146 = null;
         var _loc3_:class_258 = null;
         if(param1.category == 100 && handler != null && handler.roomSession != null)
         {
            _loc2_ = handler.roomSession.userDataManager.getUserDataByIndex(param1.objectId);
            _loc3_ = handler.friendList;
            if(_loc2_ && _loc3_)
            {
               if(handler.friendList.getFriendNames().indexOf(_loc2_.name) > -1)
               {
                  showUserName(_loc2_,param1.objectId);
               }
            }
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         if(param1.category == 100)
         {
            for each(var _loc2_ in var_469)
            {
               if(_loc2_.objectId == param1.objectId)
               {
                  removeView(_loc2_,false);
               }
            }
            _loc4_ = [];
            for each(var _loc8_ in var_573)
            {
               _loc6_ = _loc8_.requestRoomObjectId;
               if(_loc6_ == _loc5_)
               {
                  _loc4_.push(_loc8_);
               }
            }
            for each(_loc8_ in _loc4_)
            {
               removeView(_loc8_,false);
            }
            if(var_404 != null)
            {
               if(param1.objectId == var_404.requestRoomObjectId || param1.objectId == var_404.targetRoomObjectId)
               {
                  removeBreedMonsterPlantsConfirmationView();
               }
            }
            if(var_655 != null)
            {
               if(param1.objectId == var_655.requestRoomObjectId || param1.objectId == var_655.targetRoomObjectId)
               {
                  removeConfirmPetBreedingView();
               }
            }
            if(var_414 != null)
            {
               if(param1.objectId == var_414.requestObjectId || param1.objectId == var_414.targetRoomObjectId)
               {
                  removeUseProductConfirmationView();
               }
            }
         }
         if(param1.category == 10)
         {
            _loc5_ = param1.objectId;
            if(var_414 != null)
            {
               if(var_414.requestObjectId == _loc5_)
               {
                  removeUseProductConfirmationView();
               }
            }
            if(var_335 != null)
            {
               var_335.roomObjectRemoved(_loc5_);
            }
            _loc3_ = [];
            for each(var _loc7_ in var_675)
            {
               _loc6_ = _loc7_.requestRoomObjectId;
               if(_loc6_ == _loc5_)
               {
                  _loc3_.push(_loc7_);
               }
            }
            for each(_loc7_ in _loc3_)
            {
               removeView(_loc7_,false);
            }
         }
      }
      
      public function showUseProductMenuForItems(param1:Array) : void
      {
         var _loc3_:class_2146 = null;
         removeUseProductViews();
         removeUseProductConfirmationView();
         removeBreedMonsterPlantsConfirmationView();
         for each(var _loc2_ in param1)
         {
            _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.id);
            showUseProductMenu(_loc3_,_loc2_);
         }
      }
      
      public function showBreedPetMenuForItems(param1:Array) : void
      {
         var _loc3_:class_2146 = null;
         removeBreedPetViews();
         removeUseProductConfirmationView();
         removeBreedMonsterPlantsConfirmationView();
         for each(var _loc2_ in param1)
         {
            _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.id);
            showBreedPetMenu(_loc3_,_loc2_);
         }
      }
      
      private function onEffectsChanged(param1:HabboInventoryEffectsEvent) : void
      {
         if(var_18 is OwnAvatarMenuView)
         {
            (var_18 as OwnAvatarMenuView).updateButtons();
         }
      }
      
      private function getOwnCharacterInfo() : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OWN_CHARACTER_INFO",0,0));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeAvatarHighlightTimer();
         for each(var _loc1_ in var_469)
         {
            _loc1_.dispose();
         }
         var_469 = null;
         for each(var _loc2_ in var_675)
         {
            _loc2_.dispose();
         }
         var_675 = null;
         for each(var _loc4_ in var_573)
         {
            _loc4_.dispose();
         }
         var_573 = null;
         if(var_59)
         {
            var_59.removeUpdateReceiver(this);
            var_59 = null;
         }
         if(var_1062)
         {
            var_1062.dispose();
            var_1062 = null;
         }
         if(var_901)
         {
            var_901.dispose();
            var_901 = null;
         }
         if(_cachedOwnAvatarMenu)
         {
            _cachedOwnAvatarMenu.dispose();
            _cachedOwnAvatarMenu = null;
         }
         if(var_1002)
         {
            var_1002.dispose();
            var_1002 = null;
         }
         if(var_903)
         {
            var_903.dispose();
            var_903 = null;
         }
         if(var_18)
         {
            if(!var_18.disposed)
            {
               var_18.dispose();
               var_18 = null;
            }
         }
         if(var_351)
         {
            var_351.dispose();
            var_351 = null;
         }
         if(var_414)
         {
            var_414.dispose();
            var_414 = null;
         }
         removeBreedMonsterPlantsConfirmationView();
         removeConfirmPetBreedingView();
         if(var_335)
         {
            var_335.dispose();
            var_335 = null;
         }
         if(_breedingConfirmationAlert)
         {
            _breedingConfirmationAlert.dispose();
            _breedingConfirmationAlert = null;
         }
         if(var_866)
         {
            for each(var _loc3_ in var_866.getKeys())
            {
               BotSkillConfigurationViewBase(var_866.getValue(_loc3_)).dispose();
            }
            var_866.dispose();
            var_866 = null;
         }
         if(var_1458 && var_1458.length > 0)
         {
            var_1458.dispose();
            var_1458 = null;
         }
         handler.roomEngine.events.removeEventListener("REOE_ADDED",onRoomObjectAdded);
         handler.roomEngine.events.removeEventListener("REOE_REMOVED",onRoomObjectRemoved);
         handler.container.inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         var_18 = null;
         var_637 = null;
         super.dispose();
      }
      
      public function close() : void
      {
         removeView(var_18,false);
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener("RWRBFOCME_OPEN",updateEventHandler);
         param1.addEventListener("RWRBSLUE_SKILL_LIST",updateEventHandler);
         param1.addEventListener("RWRBIUE_RENTABLE_BOT",updateEventHandler);
         param1.addEventListener("RWAIE_AVATAR_INFO",updateEventHandler);
         param1.addEventListener("RWUIUE_OWN_USER",updateEventHandler);
         param1.addEventListener("RWUIUE_PEER",updateEventHandler);
         param1.addEventListener("RWROUE_FURNI_ADDED",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_SELECTED",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",updateEventHandler);
         param1.addEventListener("RWFIUE_FURNI",updateEventHandler);
         param1.addEventListener("RWUIUE_BOT",updateEventHandler);
         param1.addEventListener("RWPIUE_PET_INFO",updateEventHandler);
         param1.addEventListener("rwudue_user_data_updated",updateEventHandler);
         param1.addEventListener("RWROUE_USER_REMOVED",updateEventHandler);
         param1.addEventListener("RWREUE_NORMAL_MODE",updateEventHandler);
         param1.addEventListener("RWREUE_GAME_MODE",updateEventHandler);
         param1.addEventListener("RWONE_TYPE",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_ROLL_OVER",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.addEventListener("RWPIUE_PET_STATUS_UPDATE",updateEventHandler);
         param1.addEventListener("RWPLUE_PET_LEVEL_UPDATE",updateEventHandler);
         param1.addEventListener("RWPBRE_PET_BREEDING_RESULT",updateEventHandler);
         param1.addEventListener("RWPPBE_PET_BREEDING_",updateEventHandler);
         param1.addEventListener("RWIUM_INVENTORY_UPDATED",updateEventHandler);
         param1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_",updateEventHandler);
         param1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT",updateEventHandler);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWRBFOCME_OPEN",updateEventHandler);
         param1.removeEventListener("RWRBSLUE_SKILL_LIST",updateEventHandler);
         param1.removeEventListener("RWRBIUE_RENTABLE_BOT",updateEventHandler);
         param1.removeEventListener("RWAIE_AVATAR_INFO",updateEventHandler);
         param1.removeEventListener("RWUIUE_OWN_USER",updateEventHandler);
         param1.removeEventListener("RWUIUE_PEER",updateEventHandler);
         param1.removeEventListener("RWROUE_FURNI_ADDED",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_SELECTED",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",updateEventHandler);
         param1.removeEventListener("RWFIUE_FURNI",updateEventHandler);
         param1.removeEventListener("RWUIUE_BOT",updateEventHandler);
         param1.removeEventListener("RWPIUE_PET_INFO",updateEventHandler);
         param1.removeEventListener("rwudue_user_data_updated",updateEventHandler);
         param1.removeEventListener("RWROUE_USER_REMOVED",updateEventHandler);
         param1.removeEventListener("RWREUE_NORMAL_MODE",updateEventHandler);
         param1.removeEventListener("RWREUE_GAME_MODE",updateEventHandler);
         param1.removeEventListener("RWONE_TYPE",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.removeEventListener("RWPIUE_PET_STATUS_UPDATE",updateEventHandler);
         param1.removeEventListener("RWPLUE_PET_LEVEL_UPDATE",updateEventHandler);
         param1.removeEventListener("RWPBRE_PET_BREEDING_RESULT",updateEventHandler);
         param1.removeEventListener("RWPPBE_PET_BREEDING_",updateEventHandler);
         param1.removeEventListener("RWIUM_INVENTORY_UPDATED",updateEventHandler);
         param1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_",updateEventHandler);
         param1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT",updateEventHandler);
      }
      
      private function updateEventHandler(param1:RoomWidgetUpdateEvent) : void
      {
         var _loc12_:RoomWidgetAvatarInfoEvent = null;
         var _loc8_:RoomWidgetPetStatusUpdateEvent = null;
         var _loc3_:class_2146 = null;
         var _loc22_:RoomWidgetPetLevelUpdateEvent = null;
         var _loc27_:class_2146 = null;
         var _loc2_:RoomWidgetPetBreedingResultEvent = null;
         var _loc4_:BreedPetsResultData = null;
         var _loc14_:BreedPetsResultData = null;
         var _loc20_:RoomWidgetPetBreedingEvent = null;
         var _loc7_:int = 0;
         var _loc25_:int = 0;
         var _loc16_:RoomWidgetConfirmPetBreedingEvent = null;
         var _loc15_:RoomWidgetConfirmPetBreedingResultEvent = null;
         var _loc9_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc11_:class_3270 = null;
         var _loc13_:RoomWidgetRentableBotInfoUpdateEvent = null;
         var _loc5_:IRoomSession = null;
         var _loc26_:class_2146 = null;
         var _loc23_:RoomWidgetRentableBotSkillListUpdateEvent = null;
         var _loc18_:RoomWidgetRentableBotForceOpenContextMenuEvent = null;
         var _loc21_:int = 0;
         var _loc17_:class_2146 = null;
         var _loc6_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc24_:RoomWidgetPetInfoUpdateEvent = null;
         var _loc19_:RoomWidgetRoomObjectUpdateEvent = null;
         switch(param1.type)
         {
            case "RWAIE_AVATAR_INFO":
               _loc12_ = param1 as RoomWidgetAvatarInfoEvent;
               var_1382 = !var_265 && handler.container.roomSession != null && _loc12_.roomIndex == handler.container.roomSession.ownUserRoomId;
               if(_loc12_.allowNameChange)
               {
                  useMinimizedOwnAvatarMenu = true;
                  selectOwnAvatar();
               }
               else
               {
                  updateUserView(_loc12_.userId,_loc12_.userName,_loc12_.userType,_loc12_.roomIndex,_loc12_.allowNameChange,null);
               }
               var_265 = true;
               break;
            case "RWONE_TYPE":
               if(RoomWidgetRoomObjectNameEvent(param1).category == 100)
               {
                  updateUserView(RoomWidgetRoomObjectNameEvent(param1).userId,RoomWidgetRoomObjectNameEvent(param1).userName,RoomWidgetRoomObjectNameEvent(param1).userType,RoomWidgetRoomObjectNameEvent(param1).roomIndex,false,null);
               }
               break;
            case "RWROUE_FURNI_ADDED":
               if(RoomWidgetRoomObjectUpdateEvent(param1).category == 10)
               {
                  if(var_335 != null)
                  {
                     var_335.roomObjectAdded(RoomWidgetRoomObjectUpdateEvent(param1).id);
                  }
               }
               break;
            case "RWROUE_OBJECT_SELECTED":
               if(RoomWidgetRoomObjectUpdateEvent(param1).category == 100)
               {
                  _handlePetInfo = true;
               }
               removeBreedPetViews();
               break;
            case "RWROUE_OBJECT_DESELECTED":
               if(var_18 && !(var_18 is NewUserHelpView))
               {
                  removeView(var_18,false);
               }
               removeUseProductViews();
               removeBreedPetViews();
               break;
            case "RWFIUE_FURNI":
               if(var_18)
               {
                  removeView(var_18,false);
               }
               removeUseProductViews();
               removeBreedPetViews();
               break;
            case "RWROUE_OBJECT_ROLL_OVER":
               if(var_1382)
               {
                  return;
               }
               if(!(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView || var_18 is OwnPetMenuView || var_18 is NewUserHelpView || var_18 is RentableBotMenuView))
               {
                  var_2909 = RoomWidgetRoomObjectUpdateEvent(param1).id;
                  messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_NAME",RoomWidgetRoomObjectUpdateEvent(param1).id,RoomWidgetRoomObjectUpdateEvent(param1).category));
               }
               break;
            case "RWROUE_OBJECT_ROLL_OUT":
               if(var_1382)
               {
                  return;
               }
               if(!(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView || var_18 is OwnPetMenuView || var_18 is NewUserHelpView || var_18 is RentableBotMenuView))
               {
                  if(RoomWidgetRoomObjectUpdateEvent(param1).id == var_2909)
                  {
                     if(var_18 && !var_18.allowNameChange)
                     {
                        removeView(var_18,false);
                        var_2909 = -1;
                     }
                  }
               }
               break;
            case "RWPIUE_PET_STATUS_UPDATE":
               _loc8_ = param1 as RoomWidgetPetStatusUpdateEvent;
               if(var_18 && var_18 is OwnPetMenuView)
               {
                  if(_loc8_ != null && var_583 != null)
                  {
                     _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc8_.petId);
                     if(_loc3_ != null && _loc3_.webID == var_583.id)
                     {
                        removeView(var_18,true);
                     }
                  }
               }
               if(_loc8_ != null)
               {
                  removeBreedPetViewsWithId(_loc8_.petId);
               }
               break;
            case "RWPLUE_PET_LEVEL_UPDATE":
               _loc22_ = param1 as RoomWidgetPetLevelUpdateEvent;
               if(var_18 && var_18 is OwnPetMenuView)
               {
                  if(_loc22_ != null && var_583 != null)
                  {
                     _loc27_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc22_.petId);
                     if(_loc27_ != null && _loc27_.webID == var_583.id)
                     {
                        removeView(var_18,true);
                     }
                  }
               }
               if(_loc22_ != null)
               {
                  removeBreedPetViewsWithId(_loc22_.petId);
               }
               break;
            case "RWPBRE_PET_BREEDING_RESULT":
               _loc2_ = param1 as RoomWidgetPetBreedingResultEvent;
               _loc4_ = new BreedPetsResultData();
               _loc4_.stuffId = _loc2_.resultData.stuffId;
               _loc4_.classId = _loc2_.resultData.classId;
               _loc4_.productCode = _loc2_.resultData.productCode;
               _loc4_.userId = _loc2_.resultData.userId;
               _loc4_.userName = _loc2_.resultData.userName;
               _loc4_.rarityLevel = _loc2_.resultData.rarityLevel;
               _loc4_.hasMutation = _loc2_.resultData.hasMutation;
               _loc14_ = new BreedPetsResultData();
               _loc14_.stuffId = _loc2_.resultData2.stuffId;
               _loc14_.classId = _loc2_.resultData2.classId;
               _loc14_.productCode = _loc2_.resultData2.productCode;
               _loc14_.userId = _loc2_.resultData2.userId;
               _loc14_.userName = _loc2_.resultData2.userName;
               _loc14_.rarityLevel = _loc2_.resultData2.rarityLevel;
               _loc14_.hasMutation = _loc2_.resultData2.hasMutation;
               showBreedPetsResultView(_loc4_,_loc14_);
               break;
            case "RWPPBE_PET_BREEDING_":
               _loc20_ = param1 as RoomWidgetPetBreedingEvent;
               _loc7_ = findPetRoomObjectIdByWebId(_loc20_.ownPetId);
               _loc25_ = findPetRoomObjectIdByWebId(_loc20_.otherPetId);
               switch(_loc20_.state)
               {
                  case 0:
                     showBreedMonsterPlantsConfirmationView(_loc7_,_loc25_,false);
                     break;
                  case 1:
                     cancelBreedingPets(_loc7_,_loc25_);
                     break;
                  case 2:
                     acceptBreedingPets(_loc7_,_loc25_);
                     break;
                  case 3:
                     showBreedMonsterPlantsConfirmationView(_loc7_,_loc25_,true);
               }
               break;
            case "RWIUM_INVENTORY_UPDATED":
               if(var_335 != null)
               {
                  var_335.updatePlacingButtons();
               }
               break;
            case "RWPPBE_CONFIRM_PET_BREEDING_":
               _loc16_ = param1 as RoomWidgetConfirmPetBreedingEvent;
               showConfirmPetBreedingView(_loc16_.pet1,_loc16_.pet2,_loc16_.nestId,_loc16_.rarityCategories,_loc16_.resultPetTypeId);
               break;
            case "RWPPBE_CONFIRM_PET_BREEDING_RESULT":
               switch((_loc15_ = param1 as RoomWidgetConfirmPetBreedingResultEvent).result)
               {
                  case 0:
                     removeConfirmPetBreedingView();
                     break;
                  case 1:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.nonest.head}","${breedpets.confirmation.alert.nonest.desc}");
                     removeConfirmPetBreedingView();
                     break;
                  case 2:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.petsmissing.head}","${breedpets.confirmation.alert.petsmissing.desc}");
                     removeConfirmPetBreedingView();
                     break;
                  case 3:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.name.invalid.head}","${breedpets.confirmation.alert.name.invalid.desc}");
                     if(var_655)
                     {
                        var_655.enable();
                     }
               }
               break;
            case "RWUIUE_OWN_USER":
            case "RWUIUE_PEER":
               _loc9_ = param1 as RoomWidgetUserInfoUpdateEvent;
               var_3025.populate(_loc9_);
               _loc11_ = _loc9_.isSpectatorMode ? null : var_3025;
               updateUserView(_loc9_.webID,_loc9_.name,_loc9_.userType,_loc9_.userRoomId,var_3025.allowNameChange,_loc11_);
               break;
            case "RWRBIUE_RENTABLE_BOT":
               _loc13_ = param1 as RoomWidgetRentableBotInfoUpdateEvent;
               if(!var_272)
               {
                  var_272 = new class_3025();
               }
               var_272.populate(_loc13_);
               _loc5_ = handler.container.roomSessionManager.getSession(_loc21_);
               if(!_loc5_)
               {
                  return;
               }
               _loc26_ = _loc5_.userDataManager.getRentableBotUserData(_loc13_.webID);
               if(!_loc26_)
               {
                  return;
               }
               var_1458[_loc13_.webID.toString()] = _loc26_.botSkillData;
               if(var_272 && _loc26_.botSkillData)
               {
                  var_272.cloneAndSetSkillsWithCommands(_loc26_.botSkillData);
               }
               updateRentableBotView(_loc13_.webID,_loc13_.name,_loc13_.userRoomId,var_272);
               break;
            case "RWRBSLUE_SKILL_LIST":
               _loc23_ = param1 as RoomWidgetRentableBotSkillListUpdateEvent;
               var_1458[_loc23_.botId.toString()] = _loc23_.botSkillsWithCommands;
               if(var_272)
               {
                  var_272.cloneAndSetSkillsWithCommands(_loc23_.botSkillsWithCommands);
                  updateRentableBotView(var_272.id,var_272.name,var_272.roomIndex,var_272,true);
               }
               break;
            case "RWRBFOCME_OPEN":
               _loc18_ = param1 as RoomWidgetRentableBotForceOpenContextMenuEvent;
               if(var_272)
               {
                  updateRentableBotView(var_272.id,var_272.name,var_272.roomIndex,var_272,false,true);
                  break;
               }
               _loc21_ = handler.container.roomEngine.activeRoomId;
               _loc17_ = handler.container.roomSessionManager.getSession(_loc21_).userDataManager.getUserDataByType(_loc18_.botId,4);
               messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",_loc17_.roomObjectId,100));
               handler.container.roomEngine.selectAvatar(_loc21_,_loc17_.roomObjectId);
               break;
            case "RWUIUE_BOT":
               _loc6_ = param1 as RoomWidgetUserInfoUpdateEvent;
               updateUserView(_loc6_.webID,_loc6_.name,_loc6_.userType,_loc6_.userRoomId,false,null);
               break;
            case "RWPIUE_PET_INFO":
               if(_handlePetInfo)
               {
                  _loc24_ = param1 as RoomWidgetPetInfoUpdateEvent;
                  var_583.populate(_loc24_);
                  updatePetView(_loc24_.id,_loc24_.name,_loc24_.roomIndex,var_583);
               }
               break;
            case "rwudue_user_data_updated":
               if(!var_265)
               {
                  getOwnCharacterInfo();
               }
               break;
            case "RWROUE_USER_REMOVED":
               _loc19_ = param1 as RoomWidgetRoomObjectUpdateEvent;
               if(var_18 && var_18.roomIndex == _loc19_.id)
               {
                  removeView(var_18,false);
               }
               for each(var _loc10_ in var_469)
               {
                  if(_loc10_.objectId == _loc19_.id)
                  {
                     removeView(_loc10_,false);
                     break;
                  }
               }
               removeBreedPetViewsWithId(_loc19_.id);
               break;
            case "RWREUE_NORMAL_MODE":
               var_1798 = false;
               break;
            case "RWREUE_GAME_MODE":
               var_1798 = true;
         }
         checkUpdateNeed();
      }
      
      private function findPetRoomObjectIdByWebId(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc6_:class_2146 = null;
         var _loc5_:int = handler.container.roomSession.roomId;
         var _loc3_:int = handler.container.roomEngine.getRoomObjectCount(_loc5_,100);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = handler.container.roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
            _loc6_ = handler.container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
            if(!(_loc6_ == null || _loc6_.type != 2))
            {
               if(_loc6_.webID == param1)
               {
                  return _loc2_.getId();
               }
            }
            _loc4_++;
         }
         return -1;
      }
      
      private function removeBreedPetViewsWithId(param1:int) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in var_573)
         {
            if(_loc2_.objectId == param1 || _loc2_.requestRoomObjectId == param1)
            {
               if(_loc3_.indexOf(_loc2_) == -1)
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         for each(var _loc4_ in _loc3_)
         {
            removeView(_loc4_,false);
         }
      }
      
      public function selectOwnAvatar() : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = null;
         if(!handler || !handler.container || !handler.roomSession)
         {
            return;
         }
         var _loc3_:int = handler.container.sessionDataManager.userId;
         var _loc1_:class_2146 = handler.roomSession.userDataManager.getUserData(_loc3_);
         if(!_loc1_)
         {
            return;
         }
         _loc2_ = new RoomWidgetRoomObjectMessage("RWROM_SELECT_OBJECT",_loc1_.roomObjectId,100);
         handler.container.processWidgetMessage(_loc2_);
      }
      
      public function get ownAvatarPosture() : String
      {
         var _loc2_:IRoomObjectModel = null;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getModel();
            if(_loc2_ != null)
            {
               return _loc2_.getString("figure_posture");
            }
         }
         return "std";
      }
      
      public function get canStandUp() : Boolean
      {
         var _loc2_:IRoomObjectModel = null;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getModel();
            if(_loc2_ != null)
            {
               return _loc2_.getNumber("figure_can_stand_up") > 0;
            }
         }
         return false;
      }
      
      public function get isSwimming() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.getNumber("figure_effect");
               return _loc2_ == 29 || _loc2_ == 30 || _loc2_ == 185;
            }
         }
         return false;
      }
      
      private function updateRentableBotView(param1:int, param2:String, param3:int, param4:class_3025, param5:Boolean = false, param6:Boolean = false) : void
      {
         var showBotContextMenu:Boolean;
         var doNotOpen:Boolean;
         var botId:int = param1;
         var name:String = param2;
         var roomIndex:int = param3;
         var data:class_3025 = param4;
         var keepClosed:Boolean = param5;
         var forceOpen:Boolean = param6;
         if(!data)
         {
            return;
         }
         showBotContextMenu = var_637.getBoolean("menu.bot.enabled");
         doNotOpen = keepClosed && !var_18;
         if(forceOpen)
         {
            doNotOpen = false;
         }
         if(showBotContextMenu && var_18 && !(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView || var_18 is PetMenuView || var_18 is OwnPetMenuView || var_18 is RentableBotMenuView))
         {
            removeView(var_18,false);
         }
         removeUseProductViews();
         if(forceOpen || var_18 != null && var_18.userId == botId && !keepClosed || var_18 == null || var_18.userId != botId || var_18.userName != name || var_18.roomIndex != roomIndex || var_18.userType != 4)
         {
            if(var_18)
            {
               removeView(var_18,false);
            }
            if(!var_1798)
            {
               if(!var_1002)
               {
                  var_1002 = new RentableBotMenuView(this);
               }
               if(!doNotOpen)
               {
                  var_1296 = roomIndex;
                  _buttonsSetup = function():void
                  {
                     var_18 = var_1002;
                     RentableBotMenuView.setup(var_1002 as RentableBotMenuView,botId,name,roomIndex,4,data);
                  };
                  maybeSetupMenuView(roomIndex);
               }
            }
         }
         else if(var_18 is RentableBotMenuView)
         {
            if(var_18.userName == name)
            {
               removeView(var_18,false);
            }
         }
      }
      
      private function updatePetView(param1:int, param2:String, param3:int, param4:PetInfoData) : void
      {
         var petId:int = param1;
         var userName:String = param2;
         var roomIndex:int = param3;
         var petData:PetInfoData = param4;
         if(!petData)
         {
            return;
         }
         if(var_18 && !(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView || var_18 is PetMenuView || var_18 is OwnPetMenuView || var_18 is RentableBotMenuView))
         {
            removeView(var_18,false);
         }
         removeUseProductViews();
         if(var_18 == null || var_18.userId != petId || var_18.userName != userName || var_18.roomIndex != roomIndex || var_18.userType != 2)
         {
            if(var_18)
            {
               removeView(var_18,false);
            }
            if(!var_1798)
            {
               var_1296 = roomIndex;
               if(petData.isOwnPet)
               {
                  if(!var_2086)
                  {
                     var_2086 = new OwnPetMenuView(this,_catalog);
                  }
                  _buttonsSetup = function():void
                  {
                     var_18 = var_2086;
                     OwnPetMenuView.setup(var_2086 as OwnPetMenuView,petId,userName,roomIndex,2,petData);
                  };
               }
               else
               {
                  if(!var_903)
                  {
                     var_903 = new PetMenuView(this);
                  }
                  _buttonsSetup = function():void
                  {
                     var_18 = var_903;
                     PetMenuView.setup(var_903 as PetMenuView,petId,userName,roomIndex,2,petData);
                  };
               }
               maybeSetupMenuView(roomIndex);
            }
         }
         else if(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView)
         {
            if(var_18.userName == userName)
            {
               removeView(var_18,false);
            }
         }
      }
      
      private function maybeSetupMenuView(param1:int) : void
      {
         if(_roomEvents.hasClickUserWired())
         {
            return;
         }
         setupMenuView(param1);
      }
      
      private function onUserClickHandledEvent(param1:WiredUserClickHandledEvent) : void
      {
         if(param1.openMenu)
         {
            setupMenuView(param1.index);
            checkUpdateNeed();
         }
      }
      
      private function setupMenuView(param1:int) : void
      {
         if(var_1296 == param1 && _buttonsSetup != null)
         {
            _buttonsSetup();
            var_1296 = -1;
            _buttonsSetup = null;
         }
      }
      
      private function updateUserView(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:class_3270) : void
      {
         var friendNameView:UserNameView;
         var blocked:Boolean;
         var userId:int = param1;
         var userName:String = param2;
         var userType:int = param3;
         var roomIndex:int = param4;
         var allowNameChange:Boolean = param5;
         var data:class_3270 = param6;
         var showAvatarContextMenu:Boolean = data != null;
         if(showAvatarContextMenu && var_18 && !(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView || var_18 is PetMenuView || var_18 is OwnPetMenuView || var_18 is RentableBotMenuView))
         {
            removeView(var_18,false);
         }
         removeUseProductViews();
         if(var_18 == null || var_18.userId != userId || var_18.userName != userName || var_18.roomIndex != roomIndex || var_18.userType != 1 || allowNameChange)
         {
            if(var_18)
            {
               removeView(var_18,false);
            }
            if(!var_1798)
            {
               if(showAvatarContextMenu)
               {
                  var_1296 = roomIndex;
                  _buttonsSetup = null;
                  if(data.isOwnUser)
                  {
                     if(isUserDecorating)
                     {
                        return;
                     }
                     if(RoomEnterEffect.isRunning())
                     {
                        if(!var_2004)
                        {
                           var_2004 = new NewUserHelpView(this);
                        }
                        _buttonsSetup = function():void
                        {
                           var_18 = var_2004;
                           NewUserHelpView.setup(var_2004 as NewUserHelpView,userId,userName,roomIndex,1);
                        };
                     }
                     else
                     {
                        if(!_cachedOwnAvatarMenu)
                        {
                           _cachedOwnAvatarMenu = new OwnAvatarMenuView(this);
                        }
                        _buttonsSetup = function():void
                        {
                           var_18 = _cachedOwnAvatarMenu;
                           OwnAvatarMenuView.setup(_cachedOwnAvatarMenu as OwnAvatarMenuView,userId,userName,roomIndex,1,data);
                        };
                     }
                  }
                  else
                  {
                     if(!var_901)
                     {
                        var_901 = new AvatarMenuView(this);
                     }
                     _buttonsSetup = function():void
                     {
                        var_18 = var_901;
                        AvatarMenuView.setup(var_901 as AvatarMenuView,userId,userName,roomIndex,userType,data);
                     };
                     for each(friendNameView in var_469)
                     {
                        if(friendNameView.userId == userId)
                        {
                           removeView(friendNameView,false);
                           break;
                        }
                     }
                  }
                  maybeSetupMenuView(roomIndex);
               }
               else if(!handler.roomEngine.isDecorateMode)
               {
                  if(!var_1062)
                  {
                     var_1062 = new AvatarContextInfoButtonView(this);
                  }
                  var_18 = var_1062;
                  blocked = handler.container.sessionDataManager.isBlocked(userId);
                  if(handler.container.sessionDataManager.userId == userId)
                  {
                     AvatarContextInfoButtonView.setup(var_18,userId,userName,roomIndex,userType,allowNameChange,false,blocked);
                     if(var_1382)
                     {
                        _catalog.windowManager.registerHintWindow("avatar",var_18.window);
                        _catalog.windowManager.showHint("avatar");
                        if(!handler.container.sessionDataManager.isNoob)
                        {
                           setAvatarHightlightTimer();
                        }
                     }
                  }
                  else
                  {
                     AvatarContextInfoButtonView.setup(var_18,userId,userName,roomIndex,userType,allowNameChange,true,blocked);
                  }
               }
            }
         }
         else if(var_18 is AvatarMenuView || var_18 is OwnAvatarMenuView)
         {
            if(var_18.userName == userName)
            {
               removeView(var_18,false);
            }
         }
      }
      
      public function removeView(param1:ContextInfoView, param2:Boolean) : void
      {
         var_1382 = false;
         removeAvatarHighlightTimer();
         if(param1)
         {
            if(var_5321)
            {
               param1.hide(param2);
            }
            else
            {
               param1.dispose();
               var_1062 = null;
               var_901 = null;
               _cachedOwnAvatarMenu = null;
               var_2086 = null;
               var_1002 = null;
               var_903 = null;
               var_2004 = null;
            }
            if(param1 == var_18)
            {
               var_18 = null;
            }
            if(param1 is UserNameView)
            {
               var_469.remove((param1 as UserNameView).userName);
               param1.dispose();
               checkUpdateNeed();
            }
            if(param1 is UseProductView)
            {
               var_675.remove((param1 as UseProductView).userId);
               param1.dispose();
               checkUpdateNeed();
            }
            if(param1 is BreedPetView)
            {
               var_573.remove((param1 as BreedPetView).userId);
               param1.dispose();
               checkUpdateNeed();
            }
         }
      }
      
      public function removeUseProductViews() : void
      {
         for each(var _loc1_ in var_675)
         {
            _loc1_.dispose();
         }
         var_675.reset();
         checkUpdateNeed();
      }
      
      public function removeBreedPetViews() : void
      {
         for each(var _loc1_ in var_573)
         {
            _loc1_.dispose();
         }
         var_573.reset();
         checkUpdateNeed();
      }
      
      public function showUserName(param1:class_2146, param2:int) : void
      {
         var _loc3_:UserNameView = null;
         if(var_469[param1.name] == null)
         {
            _loc3_ = new UserNameView(this);
            UserNameView.setup(_loc3_,param1.webID,param1.name,-1,1,param2,4288528218,8000,param1.isBlocked);
            var_469[param1.name] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:UserNameView = null;
         if(var_469[param2] == null)
         {
            _loc5_ = new UserNameView(this,true);
            UserNameView.setup(_loc5_,param1,param2,param1,1,param1,param3,param4);
            var_469[param2] = _loc5_;
            checkUpdateNeed();
         }
      }
      
      private function showUseProductMenu(param1:class_2146, param2:UseProductItem) : void
      {
         var _loc3_:UseProductView = null;
         if(var_675[param1.webID.toString()] == null)
         {
            _loc3_ = new UseProductView(this);
            UseProductView.setup(_loc3_,param1.webID,param1.name,-1,2,param2);
            var_675[param1.webID.toString()] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      private function showBreedPetMenu(param1:class_2146, param2:UseProductItem) : void
      {
         var _loc3_:BreedPetView = null;
         if(var_573[param1.webID.toString()] == null)
         {
            _loc3_ = new BreedPetView(this);
            BreedPetView.setup(_loc3_,param1.webID,param1.name,-1,2,param2,param1.canBreed);
            var_573[param1.webID.toString()] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      private function setAvatarHightlightTimer() : void
      {
         var_1682 = new Timer(5000);
         var_1682.addEventListener("timer",onAvatarHighlightTimerEvent);
         var_1682.start();
      }
      
      private function removeAvatarHighlightTimer() : void
      {
         var_1382 = false;
         _catalog.windowManager.unregisterHintWindow("avatar");
         if(!var_1682)
         {
            return;
         }
         var_1682.stop();
         var_1682 = null;
      }
      
      private function onAvatarHighlightTimerEvent(param1:TimerEvent) : void
      {
         removeAvatarHighlightTimer();
      }
      
      public function checkUpdateNeed() : void
      {
         if(!var_59)
         {
            return;
         }
         if(var_18 || var_469.length > 0 || var_675.length > 0 || var_573.length > 0 || var_351 && var_351.isVisible)
         {
            var_59.registerUpdateReceiver(this,10);
         }
         else
         {
            var_59.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         if(var_18)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",var_18.userId,var_18.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(!_loc3_)
            {
               return;
            }
            var_18.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
         }
         if(var_351 && var_351.isVisible())
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",var_351.userId,var_351.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(!_loc3_)
            {
               return;
            }
            var_351.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
         }
         for each(var _loc2_ in var_469)
         {
            if(_loc2_.isGameRoomMode)
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION",_loc2_.userId,_loc2_.userType)) as RoomWidgetUserLocationUpdateEvent;
            }
            else
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc2_.userId,_loc2_.userType)) as RoomWidgetUserLocationUpdateEvent;
            }
            if(_loc3_)
            {
               _loc2_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
         for each(var _loc4_ in var_675)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc4_.userId,_loc4_.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               _loc4_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
         for each(var _loc5_ in var_573)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc5_.userId,_loc5_.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               _loc5_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
      }
      
      public function openAvatarEditor() : void
      {
         handler.container.avatarEditor.openEditor(0,null,null,true);
         handler.container.avatarEditor.loadOwnAvatarInEditor(0);
      }
      
      public function get hasClub() : Boolean
      {
         return handler.container.sessionDataManager.hasClub;
      }
      
      public function get hasVip() : Boolean
      {
         return handler.container.sessionDataManager.hasVip;
      }
      
      public function get hasEffectOn() : Boolean
      {
         var _loc1_:Array = handler.container.inventory.getActivatedAvatarEffects();
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.isInUse)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         var_4634 = param1;
      }
      
      public function get isDancing() : Boolean
      {
         return var_4634;
      }
      
      public function get hasFreeSaddle() : Boolean
      {
         if(var_583 != null)
         {
            return var_583.hasFreeSaddle;
         }
         return false;
      }
      
      public function get isRiding() : Boolean
      {
         if(var_583 != null)
         {
            return var_583.isRiding;
         }
         return false;
      }
      
      public function get isCurrentUserRiding() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.getNumber("figure_effect");
               if(_loc2_ == 77)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function openTrainingView() : void
      {
         handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_OPEN_PET_TRAINING"));
      }
      
      public function closeTrainingView() : void
      {
         handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_CLOSE_PET_TRAINING"));
      }
      
      public function get useMinimizedOwnAvatarMenu() : Boolean
      {
         return handler.container.config.getBoolean("use_minimized_own_avatar_menu");
      }
      
      public function set useMinimizedOwnAvatarMenu(param1:Boolean) : void
      {
         handler.container.config.setProperty("use_minimized_own_avatar_menu",param1 ? "1" : "0");
      }
      
      public function sendSignRequest(param1:int) : void
      {
         handler.container.roomSession.sendSignMessage(param1);
      }
      
      public function showUseProductConfirmation(param1:int, param2:int, param3:int) : void
      {
         if(!var_414)
         {
            var_414 = new UseProductConfirmationView(this);
         }
         var_414.open(param1,param2,param3);
      }
      
      private function removeUseProductConfirmationView() : void
      {
         if(var_414)
         {
            var_414.dispose();
            var_414 = null;
         }
      }
      
      public function showBreedingPetsWaitingConfirmationAlert(param1:int, param2:int) : void
      {
         removeBreedingPetsWaitingConfirmationAlert();
         _breedingConfirmationAlert = windowManager.confirm("${breedpets.confirmation.notification.title}","${breedpets.confirmation.notification.text}",0,onWaitingConfirmationAlert);
         var_2801 = param1;
         var_2098 = param2;
      }
      
      public function onWaitingConfirmationAlert(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
         }
         if(param2.type == "WE_CANCEL")
         {
            if(var_2098 != -1 && var_2098 != -1)
            {
               cancelBreedPets(var_2801,var_2098);
            }
         }
         removeBreedingPetsWaitingConfirmationAlert();
      }
      
      private function removeBreedingPetsWaitingConfirmationAlert() : void
      {
         if(_breedingConfirmationAlert != null)
         {
            _breedingConfirmationAlert.dispose();
            _breedingConfirmationAlert = null;
            var_2801 = -1;
            var_2098 = -1;
         }
      }
      
      public function acceptBreedingPets(param1:int, param2:int) : void
      {
         if(var_404 != null)
         {
            if(var_404.requestRoomObjectId == param1 && var_404.targetRoomObjectId == param2)
            {
               removeBreedMonsterPlantsConfirmationView();
            }
         }
         if(_breedingConfirmationAlert != null)
         {
            _breedingConfirmationAlert.dispose();
         }
      }
      
      public function cancelBreedingPets(param1:int, param2:int) : void
      {
         if(var_404 != null)
         {
            if(var_404.requestRoomObjectId == param1 && var_404.targetRoomObjectId == param2)
            {
               removeBreedMonsterPlantsConfirmationView();
            }
         }
         removeBreedingPetsWaitingConfirmationAlert();
         windowManager.alert("${breedpets.cancel.notification.title}","${breedpets.cancel.notification.text}",0,onBreedingAlert);
      }
      
      public function onBreedingAlert(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK" || param2.type == "WE_CANCEL")
         {
            param1.dispose();
         }
      }
      
      public function showBreedMonsterPlantsConfirmationView(param1:int, param2:int, param3:Boolean) : void
      {
         if(!var_404)
         {
            var_404 = new BreedMonsterPlantsConfirmationView(this);
         }
         var_404.open(param1,param2,param3);
      }
      
      public function showConfirmPetBreedingView(param1:ConfirmPetBreedingPetData, param2:ConfirmPetBreedingPetData, param3:int, param4:Array, param5:int) : void
      {
         if(!var_655)
         {
            var_655 = new ConfirmPetBreedingView(this);
         }
         var _loc6_:int = findPetRoomObjectIdByWebId(param1.webId);
         var _loc7_:int = findPetRoomObjectIdByWebId(param2.webId);
         var_655.open(_loc6_,_loc7_,param3,param4,param5,param1.level,param2.level);
      }
      
      private function removeBreedMonsterPlantsConfirmationView() : void
      {
         if(var_404)
         {
            var_404.dispose();
            var_404 = null;
         }
      }
      
      private function removeConfirmPetBreedingView() : void
      {
         if(var_655)
         {
            var_655.dispose();
            var_655 = null;
         }
      }
      
      public function showBreedPetsResultView(param1:BreedPetsResultData, param2:BreedPetsResultData) : void
      {
         if(!var_335)
         {
            var_335 = new BreedPetsResultView(this);
         }
         var_335.open(param1,param2);
      }
      
      public function removeBreedPetsResultView(param1:BreedPetsResultView) : void
      {
         if(param1 != null)
         {
            if(param1 == var_335)
            {
               var_335.dispose();
               var_335 = null;
            }
            else
            {
               param1.dispose();
            }
         }
      }
      
      private function findCurrentUserRoomObject() : IRoomObject
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc5_:int = handler.container.sessionDataManager.userId;
         var _loc6_:int = handler.roomEngine.activeRoomId;
         var _loc3_:int = handler.roomEngine.getRoomObjectCount(_loc6_,100);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = handler.roomEngine.getRoomObjectWithIndex(_loc6_,_loc4_,100);
            if(_loc2_ != null)
            {
               var _loc1_:class_2146 = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
            }
            _loc4_++;
         }
         return null;
      }
      
      internal function get isUserDecorating() : Boolean
      {
         return handler.roomSession.isUserDecorating;
      }
      
      internal function set isUserDecorating(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         handler.roomSession.isUserDecorating = param1;
         if(param1)
         {
            _loc5_ = handler.container.sessionDataManager.userId;
            if(!var_351)
            {
               _loc4_ = handler.container.sessionDataManager.userName;
               _loc2_ = handler.container.roomSession.ownUserRoomId;
               var_351 = new DecorateModeView(this,_loc5_,_loc4_,_loc2_);
            }
            var_351.show();
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc5_,1)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               var_351.update(_loc3_.rectangle,_loc3_.screenLocation,0);
            }
         }
         else if(var_351)
         {
            var_351.hide(false);
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function isMonsterPlant() : Boolean
      {
         if(var_583 != null)
         {
            return var_583.petType == 16;
         }
         return false;
      }
      
      public function cancelBreedPets(param1:int, param2:int) : void
      {
         var _loc3_:class_2146 = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:class_2146 = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new class_3119(1,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function acceptBreedPets(param1:int, param2:int) : void
      {
         var _loc3_:class_2146 = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:class_2146 = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new class_3119(2,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function breedPets(param1:int, param2:int) : void
      {
         var _loc3_:class_2146 = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:class_2146 = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new class_3119(0,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function openBotSkillConfigurationView(param1:int, param2:int, param3:Point = null) : void
      {
         if(!var_866.hasKey(param2))
         {
            switch(param2 - 2)
            {
               case 0:
                  var_866.add(2,new BotChatterMarkovConfiguration(this));
                  break;
               case 3:
                  var_866.add(5,new BotChangeNameConfiguration(this));
                  break;
               default:
                  return;
            }
         }
         var _loc4_:class_2534 = var_866.getValue(param2);
         _loc4_.open(param1,param3);
      }
      
      public function cancelPetBreeding(param1:int) : void
      {
         handler.container.connection.send(new class_3483(param1));
      }
      
      public function confirmPetBreeding(param1:int, param2:String, param3:int, param4:int) : void
      {
         handler.container.connection.send(new class_2759(param1,param2,param3,param4));
      }
      
      public function showNestBreedingSuccess(param1:int, param2:int) : void
      {
         if(var_3435 == null)
         {
            var_3435 = new NestBreedingSuccessView(this);
         }
         var _loc3_:int = findPetRoomObjectIdByWebId(param1);
         var_3435.open(_loc3_,param2);
      }
      
      public function get friendList() : class_258
      {
         return handler.friendList;
      }
   }
}


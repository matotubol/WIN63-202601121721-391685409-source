package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.class_26;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_20;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.campaign.HabboCampaigns;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.friendbar.groupforums.UnseenForumsCountUpdatedEvent;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.events.HabboUnseenItemsUpdatedEvent;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.nux.HabboNuxDialogs;
   import com.sulake.habbo.phonenumber.HabboPhoneNumber;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.quest.events.UnseenAchievementsCountUpdateEvent;
   import com.sulake.habbo.quest.events.UnseenDailyTasksCountUpdateEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.extensions.CitizenshipVipDiscountPromoExtension;
   import com.sulake.habbo.toolbar.extensions.CitizenshipVipQuestsPromoExtension;
   import com.sulake.habbo.toolbar.extensions.ClubDiscountPromoExtension;
   import com.sulake.habbo.toolbar.extensions.PurseAreaExtension;
   import com.sulake.habbo.toolbar.extensions.SettingsExtension;
   import com.sulake.habbo.toolbar.extensions.VideoOfferExtension;
   import com.sulake.habbo.toolbar.extensions.purse.indicators.SeasonalCurrencyIndicator;
   import com.sulake.habbo.toolbar.offers.OfferExtension;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDCoreLocalizationManager;
   import com.sulake.iid.IIDHabboCampaigns;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboGroupForumController;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboMessenger;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboNuxDialogs;
   import com.sulake.iid.IIDHabboPhoneNumber;
   import com.sulake.iid.IIDHabboQuestEngine;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import package_4.class_1757;
   import package_71.class_2196;
   
   public class HabboToolbar extends class_17 implements IHabboToolbar
   {
      
      private var _windowManager:class_38;
      
      private var _communicationManager:class_57;
      
      private var var_18:BottomBarLeft;
      
      private var var_5195:BottomBackgroundBorder;
      
      private var var_265:Boolean;
      
      private var var_571:PurseAreaExtension;
      
      private var var_1178:SettingsExtension;
      
      private var var_37:IConnection;
      
      private var _catalog:IHabboCatalog;
      
      private var _messenger:class_46;
      
      private var _navigator:class_41;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _roomEvents:IHabboUserDefinedRoomEvents;
      
      private var var_3438:SeasonalCurrencyIndicator;
      
      private var var_1664:ClubDiscountPromoExtension;
      
      private var var_2440:CitizenshipVipQuestsPromoExtension;
      
      private var var_1774:CitizenshipVipDiscountPromoExtension;
      
      private var var_1323:VideoOfferExtension;
      
      private var _localization:class_26;
      
      private var _inventory:class_61;
      
      private var var_430:ExtensionView;
      
      private var _soundManager:class_544;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarRenderManager:class_48;
      
      private var _questEngine:class_498;
      
      private var _freeFlowChat:class_51;
      
      private var _roomUI:IRoomUI;
      
      private var _offerExtension:OfferExtension;
      
      private var var_731:Timer;
      
      private var var_1116:Timer;
      
      private var var_1093:Timer;
      
      public function HabboToolbar(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         param1.attachComponent(new HabboPhoneNumber(param1,0,param3),[new IIDHabboPhoneNumber()]);
         param1.attachComponent(new HabboNuxDialogs(param1,0,param3),[new IIDHabboNuxDialogs()]);
         param1.attachComponent(new HabboCampaigns(param1,0,param3),[new IIDHabboCampaigns()]);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         },true),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },true,[{
            "type":"CATALOG_INITIALIZED",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NOT_READY",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NEW_ITEMS_SHOW",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NEW_ITEMS_HIDE",
            "callback":onCatalogEvent
         }]),new ComponentDependency(new IIDCoreLocalizationManager(),function(param1:class_26):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_61):void
         {
            _inventory = param1;
         },false,[{
            "type":"HUIUE_UNSEEN_ITEMS_CHANGED",
            "callback":onUnseenItemsUpdate
         },{
            "type":"HIHCE_HABBO_CLUB_CHANGED",
            "callback":onClubChanged
         }]),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },true,[{
            "type":"PUE_perks_updated",
            "callback":onPerksUpdated
         }]),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_498):void
         {
            _questEngine = param1;
         },false,[{
            "type":"qe_uacue",
            "callback":onUnseenAchievementsCountUpdate
         },{
            "type":"qe_udtcue",
            "callback":onUnseenDailyTasksCountUpdate
         }]),new ComponentDependency(new IIDHabboMessenger(),function(param1:class_46):void
         {
            _messenger = param1;
         },false,[{
            "type":"MMME_new",
            "callback":onMiniMailUpdate
         },{
            "type":"MMME_unread",
            "callback":onMiniMailUpdate
         },{
            "type":"HUIUE_UNSEEN_ITEMS_CHANGED",
            "callback":onUnseenItemsUpdate
         }]),new ComponentDependency(new IIDHabboGroupForumController(),null,false,[{
            "type":"UNSEEN_FORUMS_COUNT",
            "callback":onUnseenForumsCountUpdate
         }]),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         },false),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _roomEvents = param1;
         },false,[{
            "type":"WIRED_MENU_BUTTON_PREFERENCE_CHANGED",
            "callback":onWiredMenuEvent
         }])]);
      }
      
      override public function dispose() : void
      {
         var_265 = false;
         var_37 = null;
         destroyClientPromoTimer();
         destroyDimmerTimer();
         destroyOwnRoomPromoTimer();
         if(var_430)
         {
            var_430.dispose();
            var_430 = null;
         }
         if(var_571)
         {
            var_571.dispose();
            var_571 = null;
         }
         if(var_1178)
         {
            var_1178.dispose();
            var_1178 = null;
         }
         if(_offerExtension != null)
         {
            _offerExtension.dispose();
            _offerExtension = null;
         }
         if(var_1664)
         {
            var_1664.dispose();
            var_1664 = null;
         }
         if(var_2440)
         {
            var_2440.dispose();
            var_2440 = null;
         }
         if(var_1774)
         {
            var_1774.dispose();
            var_1774 = null;
         }
         if(var_1323)
         {
            var_1323.dispose();
            var_1323 = null;
         }
         if(_messenger != null)
         {
            if(_messenger.events)
            {
               _messenger.events.removeEventListener("MMME_new",onMiniMailUpdate);
               _messenger.events.removeEventListener("MMME_unread",onMiniMailUpdate);
            }
            _messenger = null;
         }
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
         super.dispose();
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
      }
      
      override protected function initComponent() : void
      {
         var_37 = _communicationManager.connection;
         _communicationManager.addHabboConnectionMessageEvent(new class_1757(onUserRights));
         var_5195 = new BottomBackgroundBorder(this);
         var_18 = new BottomBarLeft(this,_windowManager,assets,events);
         var_18.window.visible = false;
         initRoomEnterEffect();
         var_430 = new ExtensionView(_windowManager,assets,this);
         if(var_18 == null)
         {
            class_21.log("Error, toolbar view was not available");
            return;
         }
         var _loc3_:String = getProperty("new.user.wing");
         if(_loc3_ != "")
         {
            var _loc1_:int = getInteger("new.user.promo.delay",10) * 1000;
            if(_loc3_ == "social" || _loc3_ == "quest" || _loc3_ == "group" || _loc3_ == "game")
            {
               var _loc2_:int = getInteger("new.user.promo.room.delay",180) * 1000;
            }
         }
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(var_430 && !var_265)
         {
            initPurseAreaExtension();
            initSeasonalCurrencyExtension();
            initVipExtendExtension();
            initCitizenshipVipExtendExtension();
            initCitizenshipVipQuestsExtension();
            initVideoOfferExtension();
            initOfferExtension();
            initSettingsExtension();
            var_265 = true;
         }
      }
      
      private function onCatalogEvent(param1:CatalogEvent) : void
      {
         if(var_18)
         {
            var_18.onCatalogEvent(param1);
         }
      }
      
      private function onWiredMenuEvent(param1:WiredMenuEvent) : void
      {
         if(var_18)
         {
            var_18.onWiredMenuEvent(param1);
         }
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         if(!var_1323)
         {
            initVideoOfferExtension();
         }
      }
      
      private function onShowClientPromo(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         destroyClientPromoTimer();
         var _loc5_:String = getProperty("new.user.wing");
         var _loc6_:String = null;
         switch(_loc5_)
         {
            case "social":
               _loc3_ = "new.user.promo.social";
               _loc2_ = "HTIE_ICON_NAVIGATOR";
               _loc6_ = "NAVIGATOR";
               break;
            case "group":
               _loc3_ = "new.user.promo.group";
               _loc2_ = "HTIE_EXT_GROUP";
               var _loc4_:int = 1;
               break;
            case "quest":
               _loc3_ = "new.user.promo.quest";
               _loc2_ = "HTIE_ICON_PROGRESSION";
               _loc6_ = "QUESTS";
               break;
            case "game":
               _loc3_ = "new.user.promo.game";
               _loc2_ = "HTIE_ICON_GAMES";
               _loc6_ = "GAMES";
               break;
            default:
               return;
         }
         if(getIconLocation(_loc2_) != null)
         {
            _habboHelp.showWelcomeScreen(_loc2_,_loc3_,0,_loc6_);
         }
      }
      
      private function onShowOwnRoomPromo(param1:TimerEvent) : void
      {
         destroyOwnRoomPromoTimer();
         _habboHelp.showWelcomeScreen("HTIE_ICON_NAVIGATOR","new.user.promo.room",0,"NAVIGATOR_ME_TAB");
      }
      
      private function initRoomEnterEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!isNewIdentity())
         {
            return;
         }
         if(getBoolean("room.enter.effect.enabled"))
         {
            _loc1_ = getInteger("room.enter.effect.delay",4000);
            _loc2_ = getInteger("room.enter.effect.duration",2000);
            RoomEnterEffect.init(_loc1_,_loc2_);
            createAndAttachDimmerWindow(class_1812(var_18.window));
            if(var_731 == null)
            {
               var_731 = new Timer(_loc1_ + _loc2_,1);
               var_731.addEventListener("timerComplete",onRemoveDimmer);
               var_731.start();
            }
         }
      }
      
      private function initPurseAreaExtension() : void
      {
         var_571 = new PurseAreaExtension(this,_catalog);
         var_571.getClubArea().onClubChanged();
      }
      
      private function initSettingsExtension() : void
      {
         var_1178 = new SettingsExtension(this);
      }
      
      private function initSeasonalCurrencyExtension() : void
      {
         if(getBoolean("seasonalcurrencyindicator.enabled"))
         {
            var_3438 = new SeasonalCurrencyIndicator(this,_windowManager,assets,_catalog,_localization);
            var _loc1_:int = var_3438.displayedActivityPointType;
            var _loc2_:PurseEvent = new PurseEvent("catalog_purse_activity_point_balance",_catalog.getPurse().getActivityPointsForType(0),0);
            var_3438.onBalance(null);
         }
      }
      
      private function initVipExtendExtension() : void
      {
         if(getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            var_1664 = new ClubDiscountPromoExtension(this);
         }
      }
      
      private function initCitizenshipVipQuestsExtension() : void
      {
         if(getBoolean("citizenship.vip.quest.promotion.enabled"))
         {
            var_2440 = new CitizenshipVipQuestsPromoExtension(this,_windowManager,assets,events,_localization,var_37);
         }
      }
      
      private function initCitizenshipVipExtendExtension() : void
      {
         if(getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            var_1774 = new CitizenshipVipDiscountPromoExtension(this);
         }
      }
      
      private function initVideoOfferExtension() : void
      {
         var _loc1_:Boolean = !isNewIdentity() || !getBoolean("new.identity.hide.ui");
         if(_catalog.videoOffers.enabled && getBoolean("toolbar.extension.video.promo.enabled") && _loc1_)
         {
            var_1323 = new VideoOfferExtension(this);
         }
      }
      
      private function initOfferExtension() : void
      {
         var _loc1_:Boolean = !isNewIdentity() || !getBoolean("new.identity.hide.ui");
         if(getBoolean("offers.enabled") && _loc1_ && !getBoolean("offers.habboclub.enabled"))
         {
            _offerExtension = new OfferExtension(this,_windowManager,assets,_catalog);
         }
      }
      
      public function toggleSettingVisibility() : void
      {
         if(var_1178 && var_1178.window)
         {
            var_1178.window.visible = !var_1178.window.visible;
         }
         extensionView.refreshItemWindow();
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         destroyDimmerTimer();
         if(var_18)
         {
            removeDimmer(var_18.window as class_1812);
         }
         if(var_430)
         {
            var_430.removeDimmers();
         }
      }
      
      public function createAndAttachDimmerWindow(param1:class_1812) : void
      {
         if(RoomEnterEffect.isRunning())
         {
            if(param1 == null)
            {
               return;
            }
            var _loc2_:class_1741 = _windowManager.createWindow("toolbar_dimmer","",30,1,0x80 | 0x0800 | 1,new Rectangle(0,0,param1.width,param1.height),null,0);
            null.color = 0;
            null.blend = 0.3;
            param1.addChild(null);
            param1.invalidate();
         }
      }
      
      public function removeDimmer(param1:class_1812) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1741 = param1.findChildByName("toolbar_dimmer");
         if(_loc2_ != null)
         {
            param1.removeChild(_loc2_);
            param1.invalidate();
            _windowManager.destroy(_loc2_);
         }
      }
      
      public function toggleWindowVisibility(param1:String) : void
      {
         var _loc4_:HabboToolbarEvent = null;
         var _loc5_:HabboToolbarEvent = null;
         var _loc2_:String = HabboToolbarIconEnum[param1];
         if(_loc2_ == "HTIE_ICON_CAMERA")
         {
            _loc4_ = new HabboToolbarEvent("HTE_ICON_CAMERA");
            _loc4_.iconName = "toolBarCameraIcon";
            events.dispatchEvent(_loc4_);
         }
         else
         {
            _loc5_ = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
            _loc5_.iconId = _loc2_;
            _loc5_.iconName = param1;
            events.dispatchEvent(_loc5_);
         }
         var _loc3_:class_2196 = new class_2196("Toolbar",param1,"client.toolbar.clicked");
         if(var_37)
         {
            var_37.send(_loc3_);
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         if(param1 == "HTIE_EXT_GROUP")
         {
            var _loc2_:Rectangle = var_430.getIconLocation(param1);
         }
         else if(var_18)
         {
            _loc2_ = var_18.getIconLocation(param1);
         }
         if(var_571)
         {
            _loc2_ = var_571.getIconLocation(param1);
         }
         return null;
      }
      
      public function getIcon(param1:String) : class_1741
      {
         if(param1 == "HTIE_EXT_GROUP")
         {
            var _loc2_:class_1741 = var_430.getIcon(param1);
         }
         else if(var_18)
         {
            _loc2_ = var_18.geIcon(param1);
            if(null as IStaticBitmapWrapperWindow)
            {
               _loc2_ = null.parent;
            }
         }
         if(var_571)
         {
            _loc2_ = var_571.getIcon(param1);
         }
         return null;
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         if(var_18)
         {
            var_18.setUnseenItemCount(param1,param2);
         }
      }
      
      public function setToolbarState(param1:String) : void
      {
         switch(param1)
         {
            case "HTE_STATE_HOTEL_VIEW":
            case "HTE_STATE_GAME_CENTER_VIEW":
               showExtensions(true);
               break;
            case "HTE_STATE_ROOM_VIEW":
               showExtensions(true);
               break;
            case "HTE_STATE_HIDDEN":
               showExtensions(false);
         }
         if(var_430 != null)
         {
            var_430.landingView = param1 == "HTE_STATE_HOTEL_VIEW";
         }
         if(var_18)
         {
            var_18.setToolbarState(param1);
            var_18.window.visible = true;
         }
         if(_habboHelp != null)
         {
            _habboHelp.outsideRoom = param1 != "HTE_STATE_ROOM_VIEW";
         }
         var _loc2_:HabboToolbarEvent = new HabboToolbarEvent("HTE_RESIZED");
         events.dispatchEvent(_loc2_);
      }
      
      private function showExtensions(param1:Boolean) : void
      {
         if(var_430)
         {
            var_430.visible = param1;
         }
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:BitmapData = null;
         if(param2 != null)
         {
            _loc3_ = param2.clone();
         }
         if(var_18)
         {
            var_18.setIconBitmap(param1,param2);
         }
      }
      
      public function getRect() : Rectangle
      {
         if(var_18)
         {
            return var_18.window.rectangle;
         }
         return new Rectangle();
      }
      
      public function get extensionView() : IExtensionView
      {
         return var_430;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function createTransitionToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         if(var_18 && !var_18.disposed)
         {
            return var_18.animateToIcon(param1,param2,param3,param4);
         }
         param2.dispose();
         return null;
      }
      
      public function isXmasEnabled() : Boolean
      {
         return getBoolean("xmas11.enabled");
      }
      
      public function isValentinesEnabled() : Boolean
      {
         return getBoolean("valentines.enabled");
      }
      
      public function isNewIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function setIconVisibility(param1:String, param2:Boolean) : void
      {
         if(var_18)
         {
            var_18.iconVisibility(param1,param2);
         }
      }
      
      private function destroyDimmerTimer() : void
      {
         if(var_731)
         {
            var_731.removeEventListener("timerComplete",onRemoveDimmer);
            var_731.stop();
            var_731 = null;
         }
      }
      
      private function destroyClientPromoTimer() : void
      {
         if(var_1116)
         {
            var_1116.removeEventListener("timerComplete",onShowClientPromo);
            var_1116.stop();
            var_1116 = null;
         }
      }
      
      private function destroyOwnRoomPromoTimer() : void
      {
         if(var_1093)
         {
            var_1093.removeEventListener("timerComplete",onShowOwnRoomPromo);
            var_1093.stop();
            var_1093 = null;
         }
      }
      
      private function onMiniMailUpdate(param1:MiniMailMessageEvent) : void
      {
         if(!_messenger || !var_18)
         {
            return;
         }
         if(var_18 != null)
         {
            var_18.unseenMiniMailMessageCount = _messenger.getUnseenMiniMailMessageCount();
            var_18.memenu.unseenMinimailsCount = _messenger.getUnseenMiniMailMessageCount();
            setUnseenItemCount("HTIE_ICON_MEMENU",var_18.unseenMeMenuCount);
         }
      }
      
      private function onUnseenAchievementsCountUpdate(param1:UnseenAchievementsCountUpdateEvent) : void
      {
         if(var_18 != null)
         {
            var_18.unseenAchievementCount = param1.count;
            var_18.progmenu.unseenAchievementsCount = param1.count;
            setUnseenItemCount("HTIE_ICON_PROGRESSION",var_18.unseenProgMenuCount);
         }
      }
      
      private function onUnseenDailyTasksCountUpdate(param1:UnseenDailyTasksCountUpdateEvent) : void
      {
         if(var_18 != null)
         {
            var_18.unseenDailyTasksCount = param1.count;
            var_18.progmenu.unseenDailyTaskCount = param1.count;
            setUnseenItemCount("HTIE_ICON_PROGRESSION",var_18.unseenProgMenuCount);
         }
      }
      
      private function onUnseenForumsCountUpdate(param1:UnseenForumsCountUpdatedEvent) : void
      {
         if(var_18 != null)
         {
            var_18.unseenForumsCount = param1.unseenForumsCount;
            var_18.memenu.unseenForumsCount = param1.unseenForumsCount;
            setUnseenItemCount("HTIE_ICON_MEMENU",var_18.unseenMeMenuCount);
         }
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         if(var_18 != null)
         {
            var_18.onDuty = param1;
         }
      }
      
      private function onUnseenItemsUpdate(param1:HabboUnseenItemsUpdatedEvent) : void
      {
         setUnseenItemCount("HTIE_ICON_INVENTORY",param1.inventoryCount);
         setUnseenItemCount("HTIE_ICON_GAMES",param1.getCategoryCount(6));
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(var_571 != null)
         {
            var_571.getClubArea().onClubChanged(param1);
         }
         if(var_1774 != null)
         {
            var_1774.onClubChanged(param1);
         }
         if(var_1323 != null)
         {
            var_1323.onClubChanged(param1);
         }
         if(var_1664 != null)
         {
            var_1664.onClubChanged(param1);
         }
      }
      
      public function refreshPurseAreaIndicators() : void
      {
         var_571.refreshIndicators();
      }
      
      public function get toolBarAreaWidth() : int
      {
         if(var_18)
         {
            return var_18.getToolbarAreaWidth();
         }
         return 0;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get connection() : IConnection
      {
         return var_37;
      }
      
      public function get navigator() : class_41
      {
         if(_newNavigator != null)
         {
            return _newNavigator.legacyNavigator;
         }
         return null;
      }
      
      public function get questEngine() : class_498
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get inventory() : class_61
      {
         return _inventory;
      }
      
      public function get localization() : class_26
      {
         return _localization;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get messenger() : class_46
      {
         return _messenger;
      }
      
      public function get roomEvents() : IHabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function reboot() : void
      {
         (context as class_20).reboot();
      }
   }
}


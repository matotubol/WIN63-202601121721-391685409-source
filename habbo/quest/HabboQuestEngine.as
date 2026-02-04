package com.sulake.habbo.quest
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_1942;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_1968;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_2012;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.quest.dailytasks.DailyTasksController;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDDailyTasks;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import package_62.class_2098;
   
   public class HabboQuestEngine extends class_17 implements class_498, class_31, ILinkEventTracker
   {
      
      private static const const_736:int = 5;
      
      private static const TWINKLE_ANIMATION_START_TIME:int = 800;
      
      private static const TWINKLE_ANIMATION_OBJECT_COUNT:int = 15;
      
      private static const DELAY_BETWEEN_TWINKLE_STARTS:int = 300;
      
      private static const const_48:Array = ["MOVEITEM","ENTEROTHERSROOM","CHANGEFIGURE","FINDLIFEGUARDTOWER","SCRATCHAPET"];
      
      private var _windowManager:class_38;
      
      private var _communication:class_57;
      
      private var _localization:class_27;
      
      private var var_637:class_16;
      
      private var var_1692:class_1762;
      
      private var var_1267:QuestController;
      
      private var var_485:AchievementController;
      
      private var var_3725:RoomCompetitionController;
      
      private var _toolbar:IHabboToolbar;
      
      private var _catalog:IHabboCatalog;
      
      private var _navigator:IHabboNewNavigator;
      
      private var _notifications:class_536;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _tracking:class_53;
      
      private var var_1520:TwinkleImages;
      
      private var _currentlyInRoom:Boolean = false;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_5181:Boolean = false;
      
      private var var_3813:DailyTasksController;
      
      private var var_1869:AchievementsResolutionController;
      
      public function HabboQuestEngine(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_1267 = new QuestController(this);
         var_485 = new AchievementController(this);
         var_1869 = new AchievementsResolutionController(this);
         var_3725 = new RoomCompetitionController(this);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationComponentInit);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboNotifications(),onNotificationsReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboNewNavigator(),onHabboNavigatorReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboTracking(),onTrackingReady);
         param1.addLinkEventTracker(this);
         var_3813 = new DailyTasksController(this,param1,0,param3);
         param1.attachComponent(var_3813,[new IIDDailyTasks()]);
         registerUpdateReceiver(this,5);
      }
      
      public static function moveChildrenToRow(param1:class_1812, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:class_1741 = null;
         for each(var _loc5_ in param2)
         {
            _loc6_ = param1.getChildByName(_loc5_);
            if(_loc6_ != null && _loc6_.visible)
            {
               _loc6_.x = param3;
               param3 += _loc6_.width + param4;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeUpdateReceiver(this);
         context.removeLinkEventTracker(this);
         if(_toolbar)
         {
            _toolbar.release(new IIDHabboToolbar());
            _toolbar = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(_notifications != null)
         {
            _notifications.release(new IIDHabboNotifications());
            _notifications = null;
         }
         if(_windowManager != null)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(_localization != null)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(var_637 != null)
         {
            var_637.release(new IIDHabboConfigurationManager());
            var_637 = null;
         }
         if(_communication != null)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",var_485.onBadgeImageReady);
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(var_1692)
         {
            var_1692.dispose();
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_navigator != null)
         {
            _navigator.release(new IIDHabboNewNavigator());
            _navigator = null;
         }
         if(_tracking != null)
         {
            _tracking.release(new IIDHabboTracking());
            _tracking = null;
         }
         if(var_1520)
         {
            var_1520.dispose();
            var_1520 = null;
         }
         if(_roomEngine)
         {
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(var_1869)
         {
            var_1869.dispose();
            var_1869 = null;
         }
         super.dispose();
      }
      
      public function getXmlWindow(param1:String, param2:int = 1) : class_1741
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:class_1741 = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1);
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
         }
         return _loc4_;
      }
      
      private function onCommunicationComponentInit(param1:IID = null, param2:IUnknown = null) : void
      {
         _communication = class_57(param2);
         var_1692 = new class_1762(this);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = class_38(param2);
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _localization = class_27(param2);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         if(param2 == null)
         {
            return;
         }
         var_637 = param2 as class_16;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _catalog = param2 as IHabboCatalog;
      }
      
      private function onNotificationsReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _notifications = param2 as class_536;
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _sessionDataManager = param2 as ISessionDataManager;
         _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",var_485.onBadgeImageReady);
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onHabboNavigatorReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _navigator = param2 as IHabboNewNavigator;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _roomEngine = param2 as IRoomEngine;
      }
      
      private function onTrackingReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _tracking = param2 as class_53;
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get questController() : QuestController
      {
         return var_1267;
      }
      
      public function get roomCompetitionController() : RoomCompetitionController
      {
         return var_3725;
      }
      
      public function get achievementController() : AchievementController
      {
         return var_485;
      }
      
      public function get achievementsResolutionController() : AchievementsResolutionController
      {
         return var_1869;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get tracking() : class_53
      {
         return _tracking;
      }
      
      public function openCatalog(param1:class_2098) : void
      {
         var _loc2_:String = param1.catalogPageName;
         if(_loc2_ != "")
         {
            class_21.log("Questing->Open Catalog: " + _loc2_);
            _catalog.openCatalogPage(_loc2_);
         }
         else
         {
            class_21.log("Questing->Open Catalog: Quest Catalog page name not defined");
            _catalog.openCatalog();
         }
      }
      
      public function openNavigator(param1:class_2098) : void
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = hasLocalizedValue(param1.getQuestLocalizationKey() + ".searchtag");
         if(_loc2_)
         {
            _loc3_ = param1.getQuestLocalizationKey() + ".searchtag";
         }
         else
         {
            _loc3_ = param1.getCampaignLocalizationKey() + ".searchtag";
         }
         var _loc4_:String = _localization.getLocalization(_loc3_);
         class_21.log("Questing->Open Navigator: " + _loc4_);
         _navigator.performTagSearch(_loc4_);
      }
      
      public function hasQuestRoomsIds() : Boolean
      {
         var _loc1_:String = getQuestRoomIds();
         return _loc1_ != null && _loc1_ != "";
      }
      
      private function getQuestRoomIds() : String
      {
         return _localization.getLocalization("quests." + getSeasonalCampaignCodePrefix() + ".roomids");
      }
      
      public function goToQuestRooms() : void
      {
         if(!hasQuestRoomsIds())
         {
            return;
         }
         var _loc4_:String = getQuestRoomIds();
         var _loc2_:Array = _loc4_.split(",");
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:int = Math.max(0,Math.min(_loc2_.length - 1,Math.floor(Math.random() * _loc2_.length)));
         var _loc1_:String = _loc2_[_loc3_];
         var _loc5_:int = int(_loc1_);
         class_21.log("Forwarding to a guest room: " + _loc5_);
         _navigator.goToRoom(_loc5_);
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _toolbar = IHabboToolbar(param2) as IHabboToolbar;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            if(param1.iconId == "HTIE_ICON_ACHIEVEMENTS")
            {
               var_485.onToolbarClick();
            }
         }
      }
      
      public function ensureAchievementsInitialized() : void
      {
         if(var_485 != null)
         {
            var_485.ensureAchievementsInitialized();
         }
      }
      
      public function showAchievements() : void
      {
         if(var_485 != null)
         {
            var_485.show();
         }
      }
      
      public function showQuests() : void
      {
         if(var_1267 != null && !var_1267.questsList.isVisible())
         {
            var_1267.onToolbarClick();
         }
      }
      
      public function getAchievementLevel(param1:String, param2:String) : int
      {
         if(var_485 != null)
         {
            return var_485.getAchievementLevel(param1,param2);
         }
         return 0;
      }
      
      public function reenableRoomCompetitionWindow() : void
      {
         var_3725.dontShowAgain = false;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         communication.connection.send(param1);
      }
      
      public function getQuestRowTitle(param1:class_2098) : String
      {
         var _loc2_:String = param1.waitPeriodSeconds < 1 ? param1.getQuestLocalizationKey() + ".name" : "quests.list.questdelayed";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestName(param1:class_2098) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestDesc(param1:class_2098) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".desc";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestHint(param1:class_2098) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".hint";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getCampaignNameByCode(param1:String) : String
      {
         var _loc2_:String = param1 + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getCampaignName(param1:class_2098) : String
      {
         return getCampaignNameByCode(param1.getCampaignLocalizationKey());
      }
      
      public function getAchievementCategoryName(param1:String) : String
      {
         var _loc2_:String = "quests." + param1 + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function setupQuestImage(param1:class_1812, param2:class_2098) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = param1.findChildByName("quest_pic_bitmap") as IStaticBitmapWrapperWindow;
         var _loc4_:String = param2.waitPeriodSeconds > 0 ? "quest_timer_questionmark" : (param2.campaignCode + "_" + param2.localizationCode + param2.imageVersion + (isQuestWithPrompts(param2) ? "_a" : "")).toLowerCase();
         _loc3_.assetUri = "${image.library.questing.url}" + _loc4_ + ".png";
      }
      
      public function setupPromptFrameImage(param1:class_1812, param2:class_2098, param3:String) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("prompt_pic_" + param3) as IStaticBitmapWrapperWindow;
         _loc4_.assetUri = "${image.library.questing.url}" + (param2.campaignCode + "_" + param2.localizationCode + param2.imageVersion + "_" + param3).toLowerCase() + ".png";
      }
      
      public function setupRewardImage(param1:class_1812, param2:int) : void
      {
         var _loc3_:class_1741 = param1.findChildByName("currency_icon");
         _loc3_.style = class_2085.getIconStyleFor(param2,this,true);
      }
      
      public function setupCampaignImage(param1:class_1812, param2:class_2098, param3:Boolean) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("campaign_pic_bitmap") as IStaticBitmapWrapperWindow;
         if(!param3)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         var _loc5_:String = param2.campaignCode;
         if(isSeasonalQuest(param2))
         {
            _loc5_ = getSeasonalCampaignCodePrefix() + "_campaign_icon";
         }
         _loc4_.assetUri = "${image.library.questing.url}" + _loc5_ + ".png";
      }
      
      public function setupAchievementCategoryImage(param1:class_1812, param2:AchievementCategory, param3:Boolean) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("category_pic_bitmap") as IStaticBitmapWrapperWindow;
         _loc4_.assetUri = "${image.library.questing.url}" + (param3 ? "ach_category_" + param2.code : "achicon_" + param2.code) + ".png";
      }
      
      public function isQuestWithPrompts(param1:class_2098) : Boolean
      {
         return const_48.indexOf(param1.localizationCode) > -1;
      }
      
      public function refreshReward(param1:Boolean, param2:class_1812, param3:int, param4:int) : void
      {
         param1 = param3 < 0 || param4 < 1 ? false : param1;
         var _loc5_:class_1741 = param2.findChildByName("reward_caption_txt");
         var _loc6_:class_1741 = param2.findChildByName("reward_amount_txt");
         var _loc7_:class_1741 = param2.findChildByName("currency_icon");
         _loc6_.visible = param1;
         _loc5_.visible = param1;
         _loc7_.visible = param1;
         if(!param1)
         {
            return;
         }
         _loc6_.caption = "" + param4;
         moveChildrenToRow(param2,["reward_caption_txt","reward_amount_txt","currency_icon"],_loc5_.x,3);
         this.setupRewardImage(param2,param3);
      }
      
      public function update(param1:uint) : void
      {
         var_1267.update(param1);
         var_485.update(param1);
         var_3813.update(param1);
      }
      
      public function getTwinkleAnimation(param1:class_1812) : Animation
      {
         var _loc3_:int = 0;
         if(var_1520 == null)
         {
            var_1520 = new TwinkleImages(this);
         }
         var _loc4_:int = 800;
         var _loc2_:Animation = new Animation(class_2251(param1.findChildByName("twinkle_bitmap")));
         _loc3_ = 0;
         while(_loc3_ < 15)
         {
            _loc2_.addObject(new Twinkle(var_1520,_loc4_));
            _loc4_ += 300;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get currentlyInRoom() : Boolean
      {
         return _currentlyInRoom;
      }
      
      public function set currentlyInRoom(param1:Boolean) : void
      {
         _currentlyInRoom = param1;
      }
      
      public function isSeasonalCalendarEnabled() : Boolean
      {
         return var_637.getBoolean("seasonalQuestCalendar.enabled");
      }
      
      public function isSeasonalQuest(param1:class_2098) : Boolean
      {
         var _loc2_:String = getSeasonalCampaignCodePrefix();
         return _loc2_ != "" && param1.campaignCode.indexOf(_loc2_) == 0;
      }
      
      public function getSeasonalCampaignCodePrefix() : String
      {
         return getProperty("seasonalQuestCalendar.campaignPrefix");
      }
      
      public function setIsFirstLoginOfDay(param1:Boolean) : void
      {
         this.var_5181 = param1;
      }
      
      public function get isFirstLoginOfDay() : Boolean
      {
         return this.var_5181;
      }
      
      public function get configuration() : class_16
      {
         return var_637;
      }
      
      public function hasLocalizedValue(param1:String) : Boolean
      {
         return _localization.getLocalization(param1,"") != "";
      }
      
      public function get navigator() : IHabboNewNavigator
      {
         return _navigator;
      }
      
      public function requestSeasonalQuests() : void
      {
         send(new class_1968());
      }
      
      public function requestQuests() : void
      {
         send(new class_2012());
      }
      
      public function activateQuest(param1:int) : void
      {
         send(new class_1942(param1));
      }
      
      public function get linkPattern() : String
      {
         return "questengine/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "gotorooms":
               goToQuestRooms();
               break;
            case "achievements":
               if(_loc2_.length == 3)
               {
                  var_485.show();
                  var_485.selectCategoryInternalLink(_loc2_[2]);
                  break;
               }
               showAchievements();
               break;
            case "calendar":
               var_1267.seasonalCalendarWindow.onToolbarClick();
               break;
            case "quests":
               var_1267.onToolbarClick();
               break;
            default:
               class_21.log("QuestEngine unknown link-type received: " + _loc2_[1]);
         }
      }
   }
}

